part of '../app_database.dart';

@DriftAccessor(tables: [Workers, WorkerAssignments, Payments])
class WorkerDao extends DatabaseAccessor<AppDatabase> with _$WorkerDaoMixin {
  WorkerDao(AppDatabase db) : super(db);

  Future<Worker?> fetchById(int id) {
    return (select(workers)..where((w) => w.id.equals(id))).getSingleOrNull();
  }

  Future<List<Worker>> fetchWorkers() => select(workers).get();
  Stream<List<Worker>> watchActive() => (select(workers)..where((w) => w.active.equals(true))).watch();
  Future<int> insertWorker(WorkersCompanion entry) => into(workers).insert(entry);
  Future<bool> updateWorker(Worker row) => update(workers).replace(row);
  Future<int> deleteWorker(int id) => (delete(workers)..where((t) => t.id.equals(id))).go();

  Future<List<WorkerAssignment>> assignmentsForProject(int projectId) {
    return (select(workerAssignments)..where((a) => a.projectId.equals(projectId))).get();
  }

  Future<int> insertAssignment(WorkerAssignmentsCompanion entry) => into(workerAssignments).insert(entry);

  Future<List<Payment>> paymentsForWorker(int workerId) {
    return (select(payments)..where((p) => p.workerId.equals(workerId))).get();
  }

  Future<int> insertPayment(PaymentsCompanion entry) => into(payments).insert(entry);
}
