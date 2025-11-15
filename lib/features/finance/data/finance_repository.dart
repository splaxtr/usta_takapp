import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart' as db;
import '../domain/income_expense.dart';

class FinanceRepository {
  FinanceRepository(this._db);

  final db.AppDatabase _db;

  IncomeExpenseModel _map(db.IncomeExpenseData row) => IncomeExpenseModel(
        id: row.id,
        projectId: row.projectId,
        employerId: row.employerId,
        type: row.type,
        category: row.category,
        amount: row.amount,
        description: row.description,
        txDate: row.txDate,
      );

  db.IncomeExpenseCompanion _toCompanion(IncomeExpenseModel model) =>
      db.IncomeExpenseCompanion(
        id: model.id != null ? Value(model.id!) : const Value.absent(),
        projectId: Value(model.projectId),
        employerId: Value(model.employerId),
        type: Value(model.type),
        category: Value(model.category),
        amount: Value(model.amount),
        description: Value(model.description),
        txDate: Value(model.txDate),
      );

  Future<List<IncomeExpenseModel>> fetchAll() async {
    final rows = await (_db.select(_db.incomeExpense)
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.txDate, mode: OrderingMode.desc),
          ]))
        .get();
    return rows.map(_map).toList();
  }

  Future<List<IncomeExpenseModel>> fetchByProject(int projectId) async {
    final rows = await (_db.select(_db.incomeExpense)
          ..where((tbl) => tbl.projectId.equals(projectId))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.txDate,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return rows.map(_map).toList();
  }

  Future<List<IncomeExpenseModel>> fetchByEmployer(int employerId) async {
    final rows = await (_db.select(
      _db.incomeExpense,
    )..where((tbl) => tbl.employerId.equals(employerId)))
        .get();
    return rows.map(_map).toList();
  }

  Future<List<IncomeExpenseModel>> fetchByDateRange(
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
    return rows.map(_map).toList();
  }

  Future<List<IncomeExpenseModel>> fetchIncome() async {
    final rows = await (_db.select(
      _db.incomeExpense,
    )..where((tbl) => tbl.type.equals('income')))
        .get();
    return rows.map(_map).toList();
  }

  Future<List<IncomeExpenseModel>> fetchExpense() async {
    final rows = await (_db.select(
      _db.incomeExpense,
    )..where((tbl) => tbl.type.equals('expense')))
        .get();
    return rows.map(_map).toList();
  }

  Future<List<IncomeExpenseModel>> fetchByCategory(String category) async {
    final rows = await (_db.select(
      _db.incomeExpense,
    )..where((tbl) => tbl.category.equals(category)))
        .get();
    return rows.map(_map).toList();
  }

  Future<IncomeExpenseModel?> fetchById(int id) async {
    final row = await (_db.select(
      _db.incomeExpense,
    )..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _map(row);
  }

  Future<int> insertTransaction(IncomeExpenseModel model) =>
      _db.into(_db.incomeExpense).insert(_toCompanion(model));

  Future<bool> updateTransaction(IncomeExpenseModel model) async {
    if (model.id == null) return false;
    return _db.update(_db.incomeExpense).replace(_toCompanion(model));
  }

  Future<int> deleteTransaction(int id) =>
      (_db.delete(_db.incomeExpense)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> getTotalIncome() async {
    final row = await _db.customSelect(
      "SELECT COALESCE(SUM(amount), 0) AS total FROM income_expense WHERE type = 'income'",
      readsFrom: {_db.incomeExpense},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> getTotalExpense() async {
    final row = await _db.customSelect(
      "SELECT COALESCE(SUM(amount), 0) AS total FROM income_expense WHERE type = 'expense'",
      readsFrom: {_db.incomeExpense},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> getTotalIncomeForProject(int projectId) async {
    final row = await _db.customSelect(
      "SELECT COALESCE(SUM(amount), 0) AS total FROM income_expense WHERE project_id = ?1 AND type = 'income'",
      variables: [Variable<int>(projectId)],
      readsFrom: {_db.incomeExpense},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> getTotalExpenseForProject(int projectId) async {
    final row = await _db.customSelect(
      "SELECT COALESCE(SUM(amount), 0) AS total FROM income_expense WHERE project_id = ?1 AND type = 'expense'",
      variables: [Variable<int>(projectId)],
      readsFrom: {_db.incomeExpense},
    ).getSingle();
    return row.read<int>('total');
  }

  void mapperSanityCheck(db.IncomeExpenseData row) {
    _toCompanion(_map(row));
  }

  Future<void> repositorySanityCheck() async {
    final rows = await fetchAll();
    debugPrint('FinanceRepository OK: ${rows.length} kayıt');
  }
}
