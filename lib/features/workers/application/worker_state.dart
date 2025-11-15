import '../domain/payment.dart';
import '../domain/worker.dart';
import '../domain/worker_assignment.dart';

class WorkerState {
  final bool loading;
  final List<WorkerModel> workers;
  final WorkerModel? selectedWorker;
  final List<WorkerAssignmentModel> assignments;
  final List<PaymentModel> payments;
  final int totalWorkedDays;
  final int totalWorkedAmount;
  final int totalPaidAmount;
  final int remainingAmount;
  final String? error;

  const WorkerState({
    required this.loading,
    required this.workers,
    required this.selectedWorker,
    required this.assignments,
    required this.payments,
    required this.totalWorkedDays,
    required this.totalWorkedAmount,
    required this.totalPaidAmount,
    required this.remainingAmount,
    this.error,
  });

  factory WorkerState.initial() => const WorkerState(
    loading: true,
    workers: [],
    selectedWorker: null,
    assignments: [],
    payments: [],
    totalWorkedDays: 0,
    totalWorkedAmount: 0,
    totalPaidAmount: 0,
    remainingAmount: 0,
  );

  WorkerState copyWith({
    bool? loading,
    List<WorkerModel>? workers,
    WorkerModel? selectedWorker,
    bool clearSelectedWorker = false,
    List<WorkerAssignmentModel>? assignments,
    List<PaymentModel>? payments,
    int? totalWorkedDays,
    int? totalWorkedAmount,
    int? totalPaidAmount,
    int? remainingAmount,
    String? error,
  }) {
    return WorkerState(
      loading: loading ?? this.loading,
      workers: workers ?? this.workers,
      selectedWorker: clearSelectedWorker
          ? null
          : (selectedWorker ?? this.selectedWorker),
      assignments: assignments ?? this.assignments,
      payments: payments ?? this.payments,
      totalWorkedDays: totalWorkedDays ?? this.totalWorkedDays,
      totalWorkedAmount: totalWorkedAmount ?? this.totalWorkedAmount,
      totalPaidAmount: totalPaidAmount ?? this.totalPaidAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      error: error,
    );
  }
}
