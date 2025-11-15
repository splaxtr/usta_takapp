part of '../app_database.dart';

@DriftAccessor(tables: [Employers])
class EmployerDao extends DatabaseAccessor<AppDatabase> with _$EmployerDaoMixin {
  EmployerDao(AppDatabase db) : super(db);

  Future<List<Employer>> fetchAll() => select(employers).get();
  Stream<List<Employer>> watchAll() => select(employers).watch();
  Future<int> insertEmployer(EmployersCompanion entry) => into(employers).insert(entry);
  Future<bool> updateEmployer(Employer row) => update(employers).replace(row);
  Future<int> deleteById(int id) => (delete(employers)..where((t) => t.id.equals(id))).go();
}
