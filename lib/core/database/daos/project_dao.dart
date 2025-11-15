part of '../app_database.dart';

@DriftAccessor(tables: [Projects])
class ProjectDao extends DatabaseAccessor<AppDatabase> with _$ProjectDaoMixin {
  ProjectDao(AppDatabase db) : super(db);

  Future<Project?> fetchById(int id) {
    return (select(projects)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<Project>> fetchAll() => select(projects).get();
  Stream<List<Project>> watchActive() => (select(projects)..where((p) => p.status.equals('active'))).watch();
  Future<int> insertProject(ProjectsCompanion entry) => into(projects).insert(entry);
  Future<bool> updateProject(Project row) => update(projects).replace(row);
  Future<int> deleteById(int id) => (delete(projects)..where((t) => t.id.equals(id))).go();
}
