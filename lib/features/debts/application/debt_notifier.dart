import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/debt_repository.dart';
import '../domain/debt.dart';
import '../domain/debt_payment.dart';
import 'debt_state.dart';

final debtNotifierProvider = StateNotifierProvider<DebtNotifier, DebtState>((
  ref,
) {
  final repo = ref.watch(debtRepositoryProvider);
  return DebtNotifier(repo)..loadDebts();
});

class DebtNotifier extends StateNotifier<DebtState> {
  DebtNotifier(this._repository) : super(DebtState.initial());

  final DebtRepository _repository;

  Future<void> loadDebts() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final debts = await _repository.fetchAll();
      state = state.copyWith(loading: false, debts: debts);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loadPendingDebts() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final debts = await _repository.fetchPending();
      state = state.copyWith(loading: false, debts: debts);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loadDebtDetail(int debtId) async {
    try {
      state = state.copyWith(loading: true, error: null);
      final debt = await _repository.fetchById(debtId);
      if (debt == null) {
        state = state.copyWith(loading: false, error: 'Borç bulunamadı');
        return;
      }
      final payments = await _repository.getPaymentsForDebt(debtId);
      final remaining = await _repository.getRemainingAmount(debtId);
      state = state.copyWith(
        loading: false,
        selectedDebt: debt,
        payments: payments,
        remainingAmount: remaining,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loadPayments(int debtId) async {
    final payments = await _repository.getPaymentsForDebt(debtId);
    final remaining = await _repository.getRemainingAmount(debtId);
    state = state.copyWith(payments: payments, remainingAmount: remaining);
  }

  Future<void> addDebt(Debt debt) async {
    await _repository.insertDebt(debt);
    await loadDebts();
  }

  Future<void> updateDebt(Debt debt) async {
    await _repository.updateDebt(debt);
    await loadDebts();
  }

  Future<void> deleteDebt(int id) async {
    await _repository.deleteDebt(id);
    await loadDebts();
  }

  Future<void> addPayment(DebtPayment payment) async {
    await _repository.insertDebtPayment(payment);
    await loadPayments(payment.debtId);
    await _updateStatusAfterPayment(payment.debtId);
    await loadDebts();
  }

  Future<void> _updateStatusAfterPayment(int debtId) async {
    final debt = await _repository.fetchById(debtId);
    if (debt == null) return;
    final remaining = await _repository.getRemainingAmount(debtId);
    if (remaining <= 0) {
      await markAsPaid(debtId);
    } else if (remaining < debt.amount) {
      await markAsPartial(debtId);
    } else {
      await _repository.setStatus(debtId, 'pending');
    }
  }

  Future<void> closeDebtIfFullyPaid(int debtId) async {
    final remaining = await _repository.getRemainingAmount(debtId);
    if (remaining <= 0) {
      await markAsPaid(debtId);
    }
  }

  Future<void> markAsPartial(int debtId) async {
    await _repository.setStatus(debtId, 'partial');
    await loadDebtDetail(debtId);
    await loadDebts();
  }

  Future<void> markAsPaid(int debtId) async {
    await _repository.setStatus(debtId, 'paid');
    await loadDebtDetail(debtId);
    await loadDebts();
  }
}
