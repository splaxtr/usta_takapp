import 'package:drift/drift.dart';
import 'package:usta_takapp/core/database/app_database.dart' as db;
import '../domain/project.dart';

class ProjectMapper {
  static Project toDomain(db.Project row) => Project(
        id: row.id,
        employerId: row.employerId,
        title: row.title,
        startDate: row.startDate,
        endDate: row.endDate,
        status: row.status,
        budget: row.budget,
        description: row.description,
      );

  static db.ProjectsCompanion toInsert(Project model) => db.ProjectsCompanion(
        employerId: Value(model.employerId),
        title: Value(model.title),
        startDate: Value(model.startDate),
        endDate: Value(model.endDate),
        status: Value(model.status),
        budget: Value(model.budget),
        description: Value(model.description),
      );

  static db.ProjectsCompanion toUpdate(Project model) => db.ProjectsCompanion(
        id: Value(model.id!),
        employerId: Value(model.employerId),
        title: Value(model.title),
        startDate: Value(model.startDate),
        endDate: Value(model.endDate),
        status: Value(model.status),
        budget: Value(model.budget),
        description: Value(model.description),
      );
}

class ProjectRepository {
  final db.ProjectDao _dao;
  ProjectRepository(this._dao);

  Future<List<Project>> fetchAll() async {
    final rows = await _dao.fetchAll();
    return rows.map(ProjectMapper.toDomain).toList();
  }

  Future<Project?> fetchById(int id) async {
    final row = await _dao.fetchById(id);
    return row == null ? null : ProjectMapper.toDomain(row);
  }

  Future<int> insert(Project project) => _dao.insertProject(ProjectMapper.toInsert(project));

  Future<bool> update(Project project) {
    if (project.id == null) return Future.value(false);
    return _dao.updateProject(ProjectMapper.toUpdate(project));
  }

  Future<int> delete(int id) => _dao.deleteById(id);
}
