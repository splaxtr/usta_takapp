import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart' as db;
import '../../debts/domain/debt.dart';
import '../../projects/domain/project.dart';

class DashboardRepository {
  DashboardRepository(this._db);

  final db.AppDatabase _db;

  Future<int> getTotalIncome() async {
    final row = await _db.customSelect(
      'SELECT COALESCE(SUM(amount), 0) AS total FROM income_expense WHERE type = ?1',
      variables: [const Variable<String>('income')],
      readsFrom: {_db.incomeExpense},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> getTotalExpense() async {
    final row = await _db.customSelect(
      'SELECT COALESCE(SUM(amount), 0) AS total FROM income_expense WHERE type = ?1',
      variables: [const Variable<String>('expense')],
      readsFrom: {_db.incomeExpense},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> getTotalDebtPending() async {
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

  Future<List<Debt>> getUpcomingDueDebts() async {
    final horizon = DateTime.now().add(const Duration(days: 7));
    final rows = await (_db.select(_db.debts)
          ..where(
            (tbl) =>
                tbl.dueDate.isSmallerOrEqualValue(horizon) &
                tbl.status.isNotIn(['paid']),
          )
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.dueDate)]))
        .get();
    return rows.map(_mapDebt).toList();
  }

  Future<List<Project>> fetchActiveProjects() async {
    final rows = await (_db.select(_db.projects)
          ..where((tbl) => tbl.status.equals('active')))
        .get();
    return rows.map(_mapProject).toList();
  }

  Project _mapProject(db.Project row) => Project(
        id: row.id,
        employerId: row.employerId,
        title: row.title,
        startDate: row.startDate,
        endDate: row.endDate,
        status: row.status,
        budget: row.budget,
        description: row.description,
      );

  Debt _mapDebt(db.Debt row) => Debt(
        id: row.id,
        employerId: row.employerId,
        projectId: row.projectId,
        amount: row.amount,
        borrowDate: row.borrowDate,
        dueDate: row.dueDate,
        status: DebtStatusX.fromString(row.status),
        description: row.description,
        createdAt: row.createdAt,
      );

  void mapperSanityCheckProject(db.Project row) {
    _mapProject(row);
  }

  void mapperSanityCheckDebt(db.Debt row) {
    _mapDebt(row);
  }

  Future<void> repositorySanityCheck() async {
    final active = await fetchActiveProjects();
    debugPrint('DashboardRepository OK: ${active.length} aktif proje');
  }
}
