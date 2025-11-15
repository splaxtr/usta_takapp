import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart' as db;
import '../../debts/domain/debt.dart';
import '../../debts/domain/debt_payment.dart';
import '../../finance/domain/income_expense.dart';
import '../../projects/domain/project.dart';
import '../../workers/domain/worker_assignment.dart';
import '../domain/weekly_snapshot.dart';

class ReportRepository {
  ReportRepository(this._db) : _dao = _db.reportDao;

  final db.AppDatabase _db;
  final db.ReportDao _dao;

  WeeklySnapshot _mapSnapshot(db.WeeklySnapshot row) => WeeklySnapshot(
        id: row.id,
        weekStart: row.weekStart,
        incomeTotal: row.incomeTotal,
        expenseTotal: row.expenseTotal,
        debtTotal: row.debtTotal,
        payrollTotal: row.payrollTotal,
        generatedAt: row.generatedAt,
      );

  DateTime _normalizeWeekStart(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    return startOfDay.subtract(Duration(days: date.weekday - DateTime.monday));
  }

  DateTime _weekEnd(DateTime start) => start.add(const Duration(days: 6));

  Future<WeeklySnapshot?> getSnapshot(DateTime weekStart) async {
    final normalized = _normalizeWeekStart(weekStart);
    final row = await _dao.fetchByWeek(normalized);
    return row == null ? null : _mapSnapshot(row);
  }

  Future<List<WeeklySnapshot>> listSnapshots() async {
    final rows = await _dao.fetchAll();
    return rows.map(_mapSnapshot).toList();
  }

  Future<WeeklySnapshot> calculateWeek(DateTime weekStart) async {
    final normalized = _normalizeWeekStart(weekStart);
    final weekEnd = _weekEnd(normalized);
    final income = await _sumIncomeExpense('income', normalized, weekEnd);
    final expense = await _sumIncomeExpense('expense', normalized, weekEnd);
    final payroll = await _sumPayroll(normalized, weekEnd);
    final outstandingDebt = await _sumOutstandingDebt();
    return WeeklySnapshot(
      weekStart: normalized,
      incomeTotal: income,
      expenseTotal: expense,
      debtTotal: outstandingDebt,
      payrollTotal: payroll,
      generatedAt: DateTime.now(),
    );
  }

  Future<WeeklySnapshot> generateSnapshot(DateTime weekStart) async {
    final snapshot = await calculateWeek(weekStart);
    await _dao.upsertSnapshot(_toCompanion(snapshot));
    return snapshot;
  }

  Future<WeeklySnapshot> ensureSnapshot(DateTime weekStart) async {
    final existing = await getSnapshot(weekStart);
    if (existing != null) return existing;
    return generateSnapshot(weekStart);
  }

  db.WeeklySnapshotsCompanion _toCompanion(WeeklySnapshot snapshot) =>
      db.WeeklySnapshotsCompanion(
        id: snapshot.id != null ? Value(snapshot.id!) : const Value.absent(),
        weekStart: Value(snapshot.weekStart),
        incomeTotal: Value(snapshot.incomeTotal),
        expenseTotal: Value(snapshot.expenseTotal),
        debtTotal: Value(snapshot.debtTotal),
        payrollTotal: Value(snapshot.payrollTotal),
        generatedAt: Value(snapshot.generatedAt),
      );

  Future<int> _sumIncomeExpense(
    String type,
    DateTime start,
    DateTime end,
  ) async {
    final row = await _db.customSelect(
      'SELECT COALESCE(SUM(amount),0) AS total FROM income_expense WHERE type = ?1 AND tx_date BETWEEN ?2 AND ?3',
      variables: [
        Variable<String>(type),
        Variable<DateTime>(start),
        Variable<DateTime>(end),
      ],
      readsFrom: {_db.incomeExpense},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> _sumPayroll(DateTime start, DateTime end) async {
    final row = await _db.customSelect(
      'SELECT COALESCE(SUM(amount),0) AS total FROM payments WHERE payment_date BETWEEN ?1 AND ?2',
      variables: [
        Variable<DateTime>(start),
        Variable<DateTime>(end),
      ],
      readsFrom: {_db.payments},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> _sumOutstandingDebt() async {
    final row = await _db.customSelect(
      '''
        SELECT COALESCE(SUM(d.amount - COALESCE((
          SELECT SUM(dp.amount) FROM debt_payments dp WHERE dp.debt_id = d.id
        ), 0)), 0) AS total
        FROM debts d
        WHERE d.status IN ('pending','partial')
      ''',
      readsFrom: {_db.debts, _db.debtPayments},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<List<IncomeExpenseModel>> getTransactionsForWeek(
    DateTime start,
    DateTime end,
  ) async {
    final rows = await (_db.select(_db.incomeExpense)
          ..where((tbl) => tbl.txDate.isBetweenValues(start, end))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.txDate,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return rows
        .map(
          (row) => IncomeExpenseModel(
            id: row.id,
            projectId: row.projectId,
            employerId: row.employerId,
            type: row.type,
            category: row.category,
            amount: row.amount,
            description: row.description,
            txDate: row.txDate,
          ),
        )
        .toList();
  }

  Future<List<WorkerAssignmentModel>> getAssignmentsForWeek(
    DateTime start,
    DateTime end,
  ) async {
    final rows = await (_db.select(_db.workerAssignments)
          ..where((tbl) => tbl.workDate.isBetweenValues(start, end))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.workDate,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return rows
        .map(
          (row) => WorkerAssignmentModel(
            id: row.id,
            workerId: row.workerId,
            projectId: row.projectId,
            workDate: row.workDate,
            hours: row.hours,
            overtimeHours: row.overtimeHours,
          ),
        )
        .toList();
  }

  Future<List<Debt>> getDebtsForWeek(DateTime start, DateTime end) async {
    final rows = await (_db.select(_db.debts)
          ..where((tbl) => tbl.borrowDate.isBetweenValues(start, end)))
        .get();
    return rows
        .map(
          (row) => Debt(
            id: row.id,
            employerId: row.employerId,
            projectId: row.projectId,
            amount: row.amount,
            borrowDate: row.borrowDate,
            dueDate: row.dueDate,
            status: DebtStatusX.fromString(row.status),
            description: row.description,
            createdAt: row.createdAt,
          ),
        )
        .toList();
  }

  Future<List<DebtPayment>> getDebtPaymentsForWeek(
    DateTime start,
    DateTime end,
  ) async {
    final rows = await (_db.select(_db.debtPayments)
          ..where((tbl) => tbl.paymentDate.isBetweenValues(start, end))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.paymentDate,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return rows
        .map(
          (row) => DebtPayment(
            id: row.id,
            debtId: row.debtId,
            amount: row.amount,
            paymentDate: row.paymentDate,
            note: row.note,
          ),
        )
        .toList();
  }

  Future<int> getWeeklyDebtPayments(DateTime start, DateTime end) async {
    final row = await _db.customSelect(
      'SELECT COALESCE(SUM(amount),0) AS total FROM debt_payments WHERE payment_date BETWEEN ?1 AND ?2',
      variables: [
        Variable<DateTime>(start),
        Variable<DateTime>(end),
      ],
      readsFrom: {_db.debtPayments},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<List<Project>> fetchActiveProjects() async {
    final rows = await (_db.select(_db.projects)
          ..where((tbl) => tbl.status.equals('active')))
        .get();
    return rows
        .map(
          (row) => Project(
            id: row.id,
            employerId: row.employerId,
            title: row.title,
            startDate: row.startDate,
            endDate: row.endDate,
            status: row.status,
            budget: row.budget,
            description: row.description,
          ),
        )
        .toList();
  }

  Future<void> mapperSanityCheck(db.WeeklySnapshot row) async {
    _mapSnapshot(row);
  }
}
