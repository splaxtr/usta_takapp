import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart' as db;
import '../domain/payment.dart';
import '../domain/worker.dart';
import '../domain/worker_assignment.dart';

class WorkerRepository {
  WorkerRepository(this._db) : _dao = _db.workerDao;

  final db.AppDatabase _db;
  final db.WorkerDao _dao;

  WorkerModel _mapWorker(db.Worker row) => WorkerModel(
    id: row.id,
    fullName: row.fullName,
    dailyRate: row.dailyRate,
    phone: row.phone,
    note: row.note,
    active: row.active,
  );

  WorkerAssignmentModel _mapAssignment(db.WorkerAssignment row) =>
      WorkerAssignmentModel(
        id: row.id,
        workerId: row.workerId,
        projectId: row.projectId,
        workDate: row.workDate,
        hours: row.hours,
        overtimeHours: row.overtimeHours,
      );

  PaymentModel _mapPayment(db.Payment row) => PaymentModel(
    id: row.id,
    workerId: row.workerId,
    projectId: row.projectId,
    amount: row.amount,
    paymentDate: row.paymentDate,
    method: row.method,
    note: row.note,
  );

  Future<List<WorkerModel>> fetchAll() async {
    final rows = await _dao.fetchWorkers();
    return rows.map(_mapWorker).toList();
  }

  Future<List<WorkerModel>> fetchActive() async {
    final rows = await (_db.select(
      _db.workers,
    )..where((tbl) => tbl.active.equals(true))).get();
    return rows.map(_mapWorker).toList();
  }

  Future<WorkerModel?> fetchById(int id) async {
    final row = await _dao.fetchById(id);
    return row == null ? null : _mapWorker(row);
  }

  Future<int> insertWorker(WorkerModel worker) {
    return _dao.insertWorker(
      db.WorkersCompanion(
        fullName: Value(worker.fullName),
        dailyRate: Value(worker.dailyRate),
        phone: Value(worker.phone),
        note: Value(worker.note),
        active: Value(worker.active),
      ),
    );
  }

  Future<bool> updateWorker(WorkerModel worker) {
    if (worker.id == null) return Future.value(false);
    return _dao.updateWorker(
      db.WorkersCompanion(
        id: Value(worker.id!),
        fullName: Value(worker.fullName),
        dailyRate: Value(worker.dailyRate),
        phone: Value(worker.phone),
        note: Value(worker.note),
        active: Value(worker.active),
      ),
    );
  }

  Future<void> deactivateWorker(int id) {
    return (_db.update(_db.workers)..where((tbl) => tbl.id.equals(id))).write(
      const db.WorkersCompanion(active: Value(false)),
    );
  }

  Future<List<WorkerAssignmentModel>> getAssignmentsForWorker(
    int workerId,
  ) async {
    final rows =
        await (_db.select(_db.workerAssignments)
              ..where((tbl) => tbl.workerId.equals(workerId))
              ..orderBy([
                (tbl) => OrderingTerm(
                  expression: tbl.workDate,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows.map(_mapAssignment).toList();
  }

  Future<int> insertAssignment(WorkerAssignmentModel assignment) {
    return _db
        .into(_db.workerAssignments)
        .insert(
          db.WorkerAssignmentsCompanion(
            workerId: Value(assignment.workerId),
            projectId: Value(assignment.projectId),
            workDate: Value(assignment.workDate),
            hours: Value(assignment.hours),
            overtimeHours: assignment.overtimeHours != null
                ? Value(assignment.overtimeHours!)
                : const Value.absent(),
          ),
        );
  }

  Future<int> deleteAssignment(int id) {
    return (_db.delete(
      _db.workerAssignments,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<PaymentModel>> getPaymentsForWorker(int workerId) async {
    final rows =
        await (_db.select(_db.payments)
              ..where((tbl) => tbl.workerId.equals(workerId))
              ..orderBy([
                (tbl) => OrderingTerm(
                  expression: tbl.paymentDate,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows.map(_mapPayment).toList();
  }

  Future<int> insertPayment(PaymentModel payment) {
    return _db
        .into(_db.payments)
        .insert(
          db.PaymentsCompanion(
            workerId: Value(payment.workerId),
            projectId: Value(payment.projectId),
            amount: Value(payment.amount),
            paymentDate: Value(payment.paymentDate),
            method: Value(payment.method),
            note: Value(payment.note),
          ),
        );
  }

  Future<int> getTotalWorkedDays(int workerId) async {
    final row = await _db
        .customSelect(
          'SELECT COALESCE(SUM(hours), 0) AS total FROM worker_assignments WHERE worker_id = ?1',
          variables: [Variable<int>(workerId)],
          readsFrom: {_db.workerAssignments},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<int> getTotalWorkedAmount(int workerId) async {
    final row = await _db
        .customSelect(
          '''
      SELECT COALESCE(SUM(wa.hours * w.daily_rate), 0) AS total
      FROM worker_assignments wa
      INNER JOIN workers w ON w.id = wa.worker_id
      WHERE wa.worker_id = ?1
      ''',
          variables: [Variable<int>(workerId)],
          readsFrom: {_db.workerAssignments, _db.workers},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<int> getTotalPaidAmount(int workerId) async {
    final row = await _db
        .customSelect(
          'SELECT COALESCE(SUM(amount), 0) AS total FROM payments WHERE worker_id = ?1',
          variables: [Variable<int>(workerId)],
          readsFrom: {_db.payments},
        )
        .getSingle();
    return row.read<int>('total');
  }

  Future<int> getRemainingAmount(int workerId) async {
    final worked = await getTotalWorkedAmount(workerId);
    final paid = await getTotalPaidAmount(workerId);
    final remaining = worked - paid;
    return remaining < 0 ? 0 : remaining;
  }

  void mapperSanityCheckWorker(db.Worker row) {
    _mapWorker(row);
  }

  void mapperSanityCheckAssignment(db.WorkerAssignment row) {
    _mapAssignment(row);
  }

  void mapperSanityCheckPayment(db.Payment row) {
    _mapPayment(row);
  }

  Future<void> repositorySanityCheck() async {
    final rows = await _dao.fetchWorkers();
    debugPrint('WorkerRepository OK: ${rows.length} kayıt');
  }
}
