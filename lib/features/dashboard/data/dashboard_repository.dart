import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart' as db;
import '../../debts/domain/debt.dart';
import '../../projects/domain/project.dart';

class DashboardRepository {
  DashboardRepository(this._db);

  final db.AppDatabase _db;

  Future<int> fetchTotalIncome() async {
    final query = _db.customSelect(
      'SELECT COALESCE(SUM(amount), 0) AS total FROM income_expense WHERE type = ?1',
      variables: [const Variable<String>('income')],
    );
    final row = await query.getSingle();
    return row.read<int>('total');
  }

  Future<int> fetchTotalExpense() async {
    final query = _db.customSelect(
      'SELECT COALESCE(SUM(amount), 0) AS total FROM income_expense WHERE type = ?1',
      variables: [const Variable<String>('expense')],
    );
    final row = await query.getSingle();
    return row.read<int>('total');
  }

  Future<List<Project>> fetchActiveProjects() async {
    final rows = await (_db.select(
      _db.projects,
    )..where((tbl) => tbl.status.equals('active'))).get();
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

  Future<int> fetchTotalEmployerDebt() async {
    final query = _db.customSelect(
      "SELECT COALESCE(SUM(amount), 0) AS total FROM debts WHERE status IN ('pending','partial')",
    );
    final row = await query.getSingle();
    return row.read<int>('total');
  }

  Future<List<Debt>> fetchUpcomingDebts() async {
    final now = DateTime.now();
    final limitDate = now.add(const Duration(days: 7));
    final rows =
        await (_db.select(_db.debts)
              ..where(
                (tbl) =>
                    tbl.status.isIn(['pending', 'partial']) &
                    tbl.dueDate.isBetweenValues(now, limitDate),
              )
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.dueDate)])
              ..limit(10))
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
            status: row.status,
            description: row.description,
          ),
        )
        .toList();
  }

  void mapperSanityCheckProject(db.Project row) {
    final _ = Project(
      id: row.id,
      employerId: row.employerId,
      title: row.title,
      startDate: row.startDate,
      endDate: row.endDate,
      status: row.status,
      budget: row.budget,
      description: row.description,
    );
  }

  void mapperSanityCheckDebt(db.Debt row) {
    final _ = Debt(
      id: row.id,
      employerId: row.employerId,
      projectId: row.projectId,
      amount: row.amount,
      borrowDate: row.borrowDate,
      dueDate: row.dueDate,
      status: row.status,
      description: row.description,
    );
  }

  Future<void> repositorySanityCheck() async {
    final active = await fetchActiveProjects();
    debugPrint('DashboardRepository OK: ${active.length} aktif proje');
  }
}
