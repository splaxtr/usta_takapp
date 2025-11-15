import 'package:drift/drift.dart';
import 'package:usta_takapp/core/database/app_database.dart' as db;
import '../domain/employer.dart';

class EmployerMapper {
  static Employer toDomain(db.Employer row) => Employer(
        id: row.id,
        name: row.name,
        contact: row.contact,
        note: row.note,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );

  static db.EmployersCompanion toInsert(Employer model) => db.EmployersCompanion(
        name: Value(model.name),
        contact: Value(model.contact),
        note: Value(model.note),
      );

  static db.EmployersCompanion toUpdate(Employer model) => db.EmployersCompanion(
        id: Value(model.id!),
        name: Value(model.name),
        contact: Value(model.contact),
        note: Value(model.note),
        createdAt: model.createdAt != null ? Value(model.createdAt!) : const Value.absent(),
        updatedAt: model.updatedAt != null ? Value(model.updatedAt!) : Value(DateTime.now()),
      );
}

class EmployerRepository {
  final db.EmployerDao _dao;
  EmployerRepository(this._dao);

  Future<List<Employer>> fetchAll() async {
    final rows = await _dao.fetchAll();
    return rows.map(EmployerMapper.toDomain).toList();
  }

  Future<Employer?> fetchById(int id) async {
    final row = await _dao.fetchById(id);
    return row == null ? null : EmployerMapper.toDomain(row);
  }

  Future<int> insert(Employer model) async {
    return _dao.insertEmployer(EmployerMapper.toInsert(model));
  }

  Future<bool> update(Employer model) async {
    if (model.id == null) return false;
    return _dao.updateEmployer(EmployerMapper.toUpdate(model));
  }

  Future<int> delete(int id) => _dao.deleteById(id);
}
