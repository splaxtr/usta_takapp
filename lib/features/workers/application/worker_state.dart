import '../domain/payment.dart';
import '../domain/worker.dart';
import '../domain/worker_assignment.dart';

class WorkerState {
  final bool loading;
  final List<WorkerModel> workers;
  final Map<int, List<WorkerAssignmentModel>> assignments;
  final Map<int, List<PaymentModel>> payments;
  final String? error;

  const WorkerState({
    required this.loading,
    required this.workers,
    required this.assignments,
    required this.payments,
    this.error,
  });

  factory WorkerState.initial() => const WorkerState(
        loading: true,
        workers: [],
        assignments: {},
        payments: {},
      );

  WorkerState copyWith({
    bool? loading,
    List<WorkerModel>? workers,
    Map<int, List<WorkerAssignmentModel>>? assignments,
    Map<int, List<PaymentModel>>? payments,
    String? error,
  }) {
    return WorkerState(
      loading: loading ?? this.loading,
      workers: workers ?? this.workers,
      assignments: assignments ?? this.assignments,
      payments: payments ?? this.payments,
      error: error,
    );
  }
}
