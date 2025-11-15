part of '../app_database.dart';

@DriftAccessor(tables: [Debts, DebtPayments])
class DebtDao extends DatabaseAccessor<AppDatabase> with _$DebtDaoMixin {
  DebtDao(AppDatabase db) : super(db);

  Future<Debt?> fetchById(int id) {
    return (select(debts)..where((d) => d.id.equals(id))).getSingleOrNull();
  }

  Future<List<Debt>> fetchAll() => select(debts).get();
  Stream<List<Debt>> watchByStatus(String status) => (select(debts)..where((d) => d.status.equals(status))).watch();
  Future<int> insertDebt(DebtsCompanion entry) => into(debts).insert(entry);
  Future<bool> updateDebt(Debt row) => update(debts).replace(row);
  Future<int> deleteDebt(int id) => (delete(debts)..where((t) => t.id.equals(id))).go();

  Future<List<DebtPayment>> paymentsForDebt(int debtId) {
    return (select(debtPayments)..where((p) => p.debtId.equals(debtId))).get();
  }

  Future<int> addPayment(DebtPaymentsCompanion entry) => into(debtPayments).insert(entry);
}
