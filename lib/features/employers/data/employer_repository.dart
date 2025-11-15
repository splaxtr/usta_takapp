import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart' as db;
import '../../debts/domain/debt.dart';
import '../../projects/domain/project.dart';
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

  static db.EmployersCompanion toInsert(Employer model) =>
      db.EmployersCompanion(
        name: Value(model.name),
        contact: Value(model.contact),
        note: Value(model.note),
      );

  static db.EmployersCompanion toUpdate(Employer model) =>
      db.EmployersCompanion(
        id: Value(model.id!),
        name: Value(model.name),
        contact: Value(model.contact),
        note: Value(model.note),
        createdAt: model.createdAt != null
            ? Value(model.createdAt!)
            : const Value.absent(),
        updatedAt: model.updatedAt != null
            ? Value(model.updatedAt!)
            : Value(DateTime.now()),
      );
}

class EmployerRepository {
  EmployerRepository(this._db) : _dao = _db.employerDao;

  final db.AppDatabase _db;
  final db.EmployerDao _dao;

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

  Future<List<Project>> getProjectsByEmployer(int employerId) async {
    final rows = await (_db.select(
      _db.projects,
    )..where((tbl) => tbl.employerId.equals(employerId))).get();
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

  Future<List<Debt>> getDebtsByEmployer(int employerId) async {
    final rows = await (_db.select(
      _db.debts,
    )..where((tbl) => tbl.employerId.equals(employerId))).get();
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

  Future<int> getTotalDebtForEmployer(int employerId) async {
    final query = await _db
        .customSelect(
          "SELECT COALESCE(SUM(amount),0) AS total FROM debts WHERE employer_id = ?1 AND status IN ('pending','partial')",
          variables: [Variable<int>(employerId)],
          readsFrom: {_db.debts},
        )
        .getSingle();
    return query.read<int>('total');
  }

  Future<void> repositorySanityCheck() async {
    final rows = await _dao.fetchAll();
    debugPrint('EmployerRepository OK: ${rows.length} kayıt');
  }
}
