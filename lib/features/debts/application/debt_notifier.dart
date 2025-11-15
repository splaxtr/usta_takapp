import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/debt_repository.dart';
import '../domain/debt.dart';
import '../domain/debt_payment.dart';
import 'debt_state.dart';

final debtNotifierProvider = StateNotifierProvider<DebtNotifier, DebtState>((ref) {
  final repo = ref.watch(debtRepositoryProvider);
  return DebtNotifier(repo)..load();
});

class DebtNotifier extends StateNotifier<DebtState> {
  DebtNotifier(this._repo) : super(DebtState.initial());

  final DebtRepository _repo;

  Future<void> load() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final result = await _repo.fetchAll();
      state = state.copyWith(loading: false, data: result);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> addDebt(Debt debt) async {
    await _repo.insert(debt);
    await load();
  }

  Future<void> updateDebt(Debt debt) async {
    await _repo.update(debt);
    await load();
  }

  Future<void> deleteDebt(int id) async {
    await _repo.delete(id);
    await load();
  }

  Future<void> loadPayments(int debtId) async {
    final payments = await _repo.payments(debtId);
    state = state.copyWith(payments: {...state.payments, debtId: payments});
  }

  Future<void> addPayment(DebtPayment payment) async {
    await _repo.addPayment(payment);
    await loadPayments(payment.debtId);
  }
}
