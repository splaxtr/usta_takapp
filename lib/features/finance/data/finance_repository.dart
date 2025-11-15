import 'package:drift/drift.dart';
import 'package:usta_takapp/core/database/app_database.dart' as db;
import '../domain/income_expense.dart';

class IncomeExpenseMapper {
  static IncomeExpenseModel toDomain(db.IncomeExpenseData row) => IncomeExpenseModel(
        id: row.id,
        projectId: row.projectId,
        employerId: row.employerId,
        type: row.type,
        category: row.category,
        amount: row.amount,
        description: row.description,
        txDate: row.txDate,
      );

  static db.IncomeExpenseCompanion toInsert(IncomeExpenseModel model) => db.IncomeExpenseCompanion(
        projectId: Value(model.projectId),
        employerId: Value(model.employerId),
        type: Value(model.type),
        category: Value(model.category),
        amount: Value(model.amount),
        description: Value(model.description),
        txDate: Value(model.txDate),
      );

  static db.IncomeExpenseCompanion toUpdate(IncomeExpenseModel model) => db.IncomeExpenseCompanion(
        id: Value(model.id!),
        projectId: Value(model.projectId),
        employerId: Value(model.employerId),
        type: Value(model.type),
        category: Value(model.category),
        amount: Value(model.amount),
        description: Value(model.description),
        txDate: Value(model.txDate),
      );
}

class FinanceRepository {
  final db.FinanceDao _dao;
  FinanceRepository(this._dao);

  Future<List<IncomeExpenseModel>> fetchByProject(int projectId) async {
    final rows = await _dao.byProject(projectId);
    return rows.map(IncomeExpenseMapper.toDomain).toList();
  }

  Future<IncomeExpenseModel?> fetchById(int id) async {
    final row = await _dao.fetchById(id);
    return row == null ? null : IncomeExpenseMapper.toDomain(row);
  }

  Future<int> insert(IncomeExpenseModel model) => _dao.insertTransaction(IncomeExpenseMapper.toInsert(model));

  Future<bool> update(IncomeExpenseModel model) {
    if (model.id == null) return Future.value(false);
    return _dao.updateTransaction(IncomeExpenseMapper.toUpdate(model));
  }

  Future<int> delete(int id) => _dao.deleteTransaction(id);
}
