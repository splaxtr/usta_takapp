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

  void setWorker(int? id) =>
      state = state.copyWith(workerId: id, clearError: true);

  void setProject(int? id) =>
      state = state.copyWith(projectId: id, clearError: true);

  void setAmount(String value) =>
      state = state.copyWith(amount: value, clearError: true);

  void setNote(String value) =>
      state = state.copyWith(note: value, clearError: true);

  void setDate(DateTime value) =>
      state = state.copyWith(paymentDate: value, clearError: true);

  Future<String?> _validate(int amount) async {
    if (state.workerId == null) {
      return 'Çalışan seçmelisiniz';
    }
    if (state.projectId == null) {
      return 'Proje seçmelisiniz';
    }
    if (amount <= 0) {
      return 'Tutar pozitif olmalı';
    }
    final remaining = await _repo.getRemainingAmount(state.workerId!);
    if (remaining <= 0) {
      return 'Hakediş bulunmuyor';
    }
    if (amount > remaining) {
      final remainingText = (remaining / 100).toStringAsFixed(2);
      return 'Hakediş aşımı! Maksimum $remainingText ₺ ödenebilir';
    }
    return null;
  }

  Future<bool> save() async {
    if (!state.canSubmit) return false;
    try {
      state = state.copyWith(saving: true, clearError: true);
      final amount =
          (double.tryParse(state.amount.replaceAll(',', '.')) ?? 0) * 100;
      final amountValue = amount.toInt();
      final validation = await _validate(amountValue);
      if (validation != null) {
        state = state.copyWith(saving: false, error: validation);
        return false;
      }
      final payment = PaymentModel(
        workerId: state.workerId!,
        projectId: state.projectId!,
        amount: amountValue,
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
