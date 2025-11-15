import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/worker_repository.dart';
import '../domain/payment.dart';
import '../domain/worker.dart';
import '../domain/worker_assignment.dart';
import 'worker_state.dart';

final workerNotifierProvider = StateNotifierProvider<WorkerNotifier, WorkerState>((ref) {
  final repo = ref.watch(workerRepositoryProvider);
  return WorkerNotifier(repo)..loadWorkers();
});

class WorkerNotifier extends StateNotifier<WorkerState> {
  WorkerNotifier(this._repo) : super(WorkerState.initial());

  final WorkerRepository _repo;

  Future<void> loadWorkers() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final result = await _repo.fetchAll();
      state = state.copyWith(loading: false, workers: result);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> addWorker(WorkerModel worker) async {
    await _repo.insert(worker);
    await loadWorkers();
  }

  Future<void> updateWorker(WorkerModel worker) async {
    await _repo.update(worker);
    await loadWorkers();
  }

  Future<void> deleteWorker(int id) async {
    await _repo.delete(id);
    await loadWorkers();
  }

  Future<void> loadAssignments(int projectId) async {
    final items = await _repo.assignmentsByProject(projectId);
    state = state.copyWith(assignments: {...state.assignments, projectId: items});
  }

  Future<void> addAssignment(WorkerAssignmentModel assignment) async {
    await _repo.addAssignment(assignment);
    await loadAssignments(assignment.projectId);
  }

  Future<void> loadPayments(int workerId) async {
    final items = await _repo.paymentsByWorker(workerId);
    state = state.copyWith(payments: {...state.payments, workerId: items});
  }

  Future<void> addPayment(PaymentModel payment) async {
    await _repo.addPayment(payment);
    await loadPayments(payment.workerId);
  }
}
