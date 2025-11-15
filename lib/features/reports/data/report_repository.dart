import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart' as db;
import '../../debts/domain/debt.dart';
import '../../debts/domain/debt_payment.dart';
import '../../finance/domain/income_expense.dart';
import '../../workers/domain/worker_assignment.dart';
import '../domain/weekly_report.dart';

class ReportRepository {
  ReportRepository(this._db) : _dao = _db.reportDao;

  final db.AppDatabase _db;
  final db.ReportDao _dao;

  WeeklyReport _mapSnapshot(db.WeeklySnapshot row) => WeeklyReport(
    id: row.id,
    weekStart: row.weekStart,
    incomeTotal: row.incomeTotal,
    expenseTotal: row.expenseTotal,
    debtTotal: row.debtTotal,
    payrollTotal: row.payrollTotal,
    generatedAt: row.generatedAt,
  );

  Future<int> getWeeklyIncome(DateTime start, DateTime end) async {
    final row = await _db
        .customSelect(
          'SELECT COALESCE(SUM(amount),0) AS total FROM income_expense WHERE type = ?1 AND tx_date BETWEEN ?2 AND ?3',
          variables: [
            const Variable<String>('income'),
            Variable<DateTime>(start),
            Variable<DateTime>(end),
          ],
          readsFrom: {_db.incomeExpense},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<int> getWeeklyExpense(DateTime start, DateTime end) async {
    final row = await _db
        .customSelect(
          'SELECT COALESCE(SUM(amount),0) AS total FROM income_expense WHERE type = ?1 AND tx_date BETWEEN ?2 AND ?3',
          variables: [
            const Variable<String>('expense'),
            Variable<DateTime>(start),
            Variable<DateTime>(end),
          ],
          readsFrom: {_db.incomeExpense},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<int> getWeeklyPayroll(DateTime start, DateTime end) async {
    final row = await _db
        .customSelect(
          '''
      SELECT COALESCE(SUM(wa.hours * w.daily_rate),0) AS total
      FROM worker_assignments wa
      INNER JOIN workers w ON w.id = wa.worker_id
      WHERE wa.work_date BETWEEN ?1 AND ?2
      ''',
          variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
          readsFrom: {_db.workerAssignments, _db.workers},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<int> getWeeklyDebt(DateTime start, DateTime end) async {
    final row = await _db
        .customSelect(
          'SELECT COALESCE(SUM(amount),0) AS total FROM debts WHERE borrow_date BETWEEN ?1 AND ?2',
          variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
          readsFrom: {_db.debts},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<int> getWeeklyDebtPayments(DateTime start, DateTime end) async {
    final row = await _db
        .customSelect(
          'SELECT COALESCE(SUM(amount),0) AS total FROM debt_payments WHERE payment_date BETWEEN ?1 AND ?2',
          variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
          readsFrom: {_db.debtPayments},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<WeeklyReport?> getSnapshot(DateTime weekStart) async {
    final row = await _dao.fetchByWeek(weekStart);
    return row == null ? null : _mapSnapshot(row);
  }

  Future<int> insertSnapshot(WeeklyReport snapshot) async {
    return _dao.upsertSnapshot(
      db.WeeklySnapshotsCompanion(
        id: snapshot.id != null ? Value(snapshot.id!) : const Value.absent(),
        weekStart: Value(snapshot.weekStart),
        incomeTotal: Value(snapshot.incomeTotal),
        expenseTotal: Value(snapshot.expenseTotal),
        debtTotal: Value(snapshot.debtTotal),
        payrollTotal: Value(snapshot.payrollTotal),
        generatedAt: Value(snapshot.generatedAt),
      ),
    );
  }

  Future<List<WeeklyReport>> fetchAllSnapshots() async {
    final rows = await _dao.fetchAll();
    return rows.map(_mapSnapshot).toList();
  }

  Future<int> deleteSnapshot(DateTime weekStart) => _dao.deleteWeek(weekStart);

  Future<WeeklyReport> getOrCreateSnapshot(
    DateTime weekStart,
    DateTime weekEnd,
  ) async {
    final existing = await getSnapshot(weekStart);
    if (existing != null) return existing;
    final income = await getWeeklyIncome(weekStart, weekEnd);
    final expense = await getWeeklyExpense(weekStart, weekEnd);
    final payroll = await getWeeklyPayroll(weekStart, weekEnd);
    final debt = await getWeeklyDebt(weekStart, weekEnd);
    final snapshot = WeeklyReport(
      weekStart: weekStart,
      incomeTotal: income,
      expenseTotal: expense,
      debtTotal: debt,
      payrollTotal: payroll,
      generatedAt: DateTime.now(),
    );
    await insertSnapshot(snapshot);
    return snapshot;
  }

  Future<List<IncomeExpenseModel>> getTransactionsForWeek(
    DateTime start,
    DateTime end,
  ) async {
    final rows =
        await (_db.select(_db.incomeExpense)
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
    final rows =
        await (_db.select(_db.workerAssignments)
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
    final rows = await (_db.select(
      _db.debts,
    )..where((tbl) => tbl.borrowDate.isBetweenValues(start, end))).get();
    return rows
        .map(
          (row) => Debt(
            id: row.id,
            employerId: row.employerId,
            projectId: row.projectId,
            amount: row.amount,
            borrowDate: row.borrowDate,
            dueDate: row.dueDate,
            status: row.status,
            description: row.description,
          ),
        )
        .toList();
  }

  Future<List<DebtPayment>> getDebtPaymentsForWeek(
    DateTime start,
    DateTime end,
  ) async {
    final rows = await (_db.select(
      _db.debtPayments,
    )..where((tbl) => tbl.paymentDate.isBetweenValues(start, end))).get();
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

  Future<void> repositorySanityCheck() async {
    final rows = await _dao.fetchAll();
    debugPrint('ReportRepository OK: ${rows.length} snapshot');
  }
}
