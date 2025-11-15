import 'package:drift/drift.dart';
import 'package:usta_takapp/core/database/app_database.dart' as db;
import '../domain/payment.dart';
import '../domain/worker.dart';
import '../domain/worker_assignment.dart';

class WorkerMapper {
  static WorkerModel toDomain(db.Worker row) => WorkerModel(
        id: row.id,
        fullName: row.fullName,
        dailyRate: row.dailyRate,
        phone: row.phone,
        note: row.note,
        active: row.active,
      );

  static db.WorkersCompanion toInsert(WorkerModel model) => db.WorkersCompanion(
        fullName: Value(model.fullName),
        dailyRate: Value(model.dailyRate),
        phone: Value(model.phone),
        note: Value(model.note),
        active: Value(model.active),
      );

  static db.WorkersCompanion toUpdate(WorkerModel model) => db.WorkersCompanion(
        id: Value(model.id!),
        fullName: Value(model.fullName),
        dailyRate: Value(model.dailyRate),
        phone: Value(model.phone),
        note: Value(model.note),
        active: Value(model.active),
      );
}

class WorkerAssignmentMapper {
  static WorkerAssignmentModel toDomain(db.WorkerAssignment row) => WorkerAssignmentModel(
        id: row.id,
        workerId: row.workerId,
        projectId: row.projectId,
        workDate: row.workDate,
        hours: row.hours,
        overtimeHours: row.overtimeHours,
      );

  static db.WorkerAssignmentsCompanion toInsert(WorkerAssignmentModel model) => db.WorkerAssignmentsCompanion(
        workerId: Value(model.workerId),
        projectId: Value(model.projectId),
        workDate: Value(model.workDate),
        hours: Value(model.hours),
        overtimeHours: Value(model.overtimeHours),
      );
}

class PaymentMapper {
  static PaymentModel toDomain(db.Payment row) => PaymentModel(
        id: row.id,
        workerId: row.workerId,
        projectId: row.projectId,
        amount: row.amount,
        paymentDate: row.paymentDate,
        method: row.method,
        note: row.note,
      );

  static db.PaymentsCompanion toInsert(PaymentModel model) => db.PaymentsCompanion(
        workerId: Value(model.workerId),
        projectId: Value(model.projectId),
        amount: Value(model.amount),
        paymentDate: Value(model.paymentDate),
        method: Value(model.method),
        note: Value(model.note),
      );
}

class WorkerRepository {
  final db.WorkerDao _dao;
  WorkerRepository(this._dao);

  Future<List<WorkerModel>> fetchAll() async {
    final rows = await _dao.fetchWorkers();
    return rows.map(WorkerMapper.toDomain).toList();
  }

  Future<WorkerModel?> fetchById(int id) async {
    final row = await _dao.fetchById(id);
    return row == null ? null : WorkerMapper.toDomain(row);
  }

  Future<int> insert(WorkerModel model) => _dao.insertWorker(WorkerMapper.toInsert(model));

  Future<bool> update(WorkerModel model) {
    if (model.id == null) return Future.value(false);
    return _dao.updateWorker(WorkerMapper.toUpdate(model));
  }

  Future<int> delete(int id) => _dao.deleteWorker(id);

  Future<List<WorkerAssignmentModel>> assignmentsByProject(int projectId) async {
    final rows = await _dao.assignmentsForProject(projectId);
    return rows.map(WorkerAssignmentMapper.toDomain).toList();
  }

  Future<int> addAssignment(WorkerAssignmentModel model) => _dao.insertAssignment(WorkerAssignmentMapper.toInsert(model));

  Future<List<PaymentModel>> paymentsByWorker(int workerId) async {
    final rows = await _dao.paymentsForWorker(workerId);
    return rows.map(PaymentMapper.toDomain).toList();
  }

  Future<int> addPayment(PaymentModel model) => _dao.insertPayment(PaymentMapper.toInsert(model));
}
