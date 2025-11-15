part of '../app_database.dart';

@DriftAccessor(tables: [IncomeExpense])
class FinanceDao extends DatabaseAccessor<AppDatabase> with _$FinanceDaoMixin {
  FinanceDao(AppDatabase db) : super(db);

  Future<List<IncomeExpenseData>> byProject(int projectId) {
    return (select(incomeExpense)..where((t) => t.projectId.equals(projectId))).get();
  }

  Stream<List<IncomeExpenseData>> watchByProject(int projectId) {
    return (select(incomeExpense)..where((t) => t.projectId.equals(projectId))).watch();
  }

  Future<int> insertTransaction(IncomeExpenseCompanion entry) => into(incomeExpense).insert(entry);

  Future<bool> updateTransaction(IncomeExpenseData row) => update(incomeExpense).replace(row);

  Future<int> deleteTransaction(int id) => (delete(incomeExpense)..where((t) => t.id.equals(id))).go();
}
