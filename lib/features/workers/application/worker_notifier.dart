import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/worker_repository.dart';
import '../domain/payment.dart';
import '../domain/worker.dart';
import '../domain/worker_assignment.dart';
import 'worker_state.dart';

final workerNotifierProvider =
    StateNotifierProvider<WorkerNotifier, WorkerState>((ref) {
      final repo = ref.read(workerRepositoryProvider);
      return WorkerNotifier(repo)..loadWorkers();
    });

class WorkerNotifier extends StateNotifier<WorkerState> {
  WorkerNotifier(this._repository) : super(WorkerState.initial());

  final WorkerRepository _repository;

  Future<void> loadWorkers() async {
    try {
      state = state.copyWith(
        loading: true,
        error: null,
        clearSelectedWorker: true,
      );
      final workers = await _repository.fetchAll();
      state = state.copyWith(
        loading: false,
        workers: workers,
        assignments: [],
        payments: [],
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loadWorkerDetail(int workerId) async {
    try {
      state = state.copyWith(loading: true, error: null);
      final worker = await _repository.fetchById(workerId);
      if (worker == null) {
        state = state.copyWith(loading: false, error: 'Çalışan bulunamadı');
        return;
      }
      final assignments = await _repository.getAssignmentsForWorker(workerId);
      final payments = await _repository.getPaymentsForWorker(workerId);
      await _updateSummary(workerId);
      state = state.copyWith(
        loading: false,
        selectedWorker: worker,
        assignments: assignments,
        payments: payments,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> addWorker(WorkerModel worker) async {
    await _repository.insertWorker(worker);
    await loadWorkers();
  }

  Future<void> updateWorker(WorkerModel worker) async {
    await _repository.updateWorker(worker);
    await loadWorkers();
  }

  Future<void> deactivateWorker(int workerId) async {
    await _repository.deactivateWorker(workerId);
    await loadWorkers();
  }

  Future<void> loadAssignments(int workerId) async {
    final data = await _repository.getAssignmentsForWorker(workerId);
    state = state.copyWith(assignments: data);
  }

  Future<void> addAssignment(WorkerAssignmentModel assignment) async {
    await _repository.insertAssignment(assignment);
    await loadAssignments(assignment.workerId);
    await _updateSummary(assignment.workerId);
  }

  Future<void> deleteAssignment(int assignmentId, int workerId) async {
    await _repository.deleteAssignment(assignmentId);
    await loadAssignments(workerId);
    await _updateSummary(workerId);
  }

  Future<void> loadPayments(int workerId) async {
    final data = await _repository.getPaymentsForWorker(workerId);
    state = state.copyWith(payments: data);
  }

  Future<void> addPayment(PaymentModel payment) async {
    await _repository.insertPayment(payment);
    await loadPayments(payment.workerId);
    await _updateSummary(payment.workerId);
  }

  Future<void> _updateSummary(int workerId) async {
    final totals = await Future.wait([
      _repository.getTotalWorkedDays(workerId),
      _repository.getTotalWorkedAmount(workerId),
      _repository.getTotalPaidAmount(workerId),
      _repository.getRemainingAmount(workerId),
    ]);
    state = state.copyWith(
      totalWorkedDays: totals[0],
      totalWorkedAmount: totals[1],
      totalPaidAmount: totals[2],
      remainingAmount: totals[3],
    );
  }

  Future<void> recalculateSummary(int workerId) => _updateSummary(workerId);
}
