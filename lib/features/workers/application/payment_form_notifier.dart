import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../projects/application/project_notifier.dart';
import '../data/worker_repository.dart';
import '../domain/payment.dart';
import 'payment_form_state.dart';
import 'worker_notifier.dart';

final paymentFormNotifierProvider = StateNotifierProvider.autoDispose
    .family<PaymentFormNotifier, PaymentFormState, PaymentFormArgs>(
        (ref, args) {
  final repo = ref.read(workerRepositoryProvider);
  return PaymentFormNotifier(ref, repo, args);
});

class PaymentFormArgs {
  final int? workerId;
  final int? projectId;

  const PaymentFormArgs({this.workerId, this.projectId});
}

class PaymentFormNotifier extends StateNotifier<PaymentFormState> {
  PaymentFormNotifier(this._ref, this._repo, PaymentFormArgs args)
      : super(
          PaymentFormState.initial().copyWith(
            workerId: args.workerId,
            projectId: args.projectId,
          ),
        );

  final Ref _ref;
  final WorkerRepository _repo;

  void setWorker(int? id) => state = state.copyWith(workerId: id);

  void setProject(int? id) => state = state.copyWith(projectId: id);

  void setAmount(String value) => state = state.copyWith(amount: value);

  void setNote(String value) => state = state.copyWith(note: value);

  void setDate(DateTime value) => state = state.copyWith(paymentDate: value);

  Future<bool> save() async {
    if (!state.canSubmit) return false;
    try {
      state = state.copyWith(saving: true, clearError: true);
      final amount =
          (double.tryParse(state.amount.replaceAll(',', '.')) ?? 0) * 100;
      final payment = PaymentModel(
        workerId: state.workerId!,
        projectId: state.projectId!,
        amount: amount.toInt(),
        paymentDate: state.paymentDate,
        method: 'other',
        note: state.note.trim().isEmpty ? null : state.note,
      );
      await _repo.insertPayment(payment);
      await _ref.read(workerNotifierProvider.notifier).loadWorkers();
      await _ref.read(projectNotifierProvider.notifier).loadProjects();
      state = state.copyWith(saving: false);
      return true;
    } catch (e) {
      state = state.copyWith(saving: false, error: e.toString());
      return false;
    }
  }
}
