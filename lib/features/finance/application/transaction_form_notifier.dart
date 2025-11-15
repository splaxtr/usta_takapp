import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../dashboard/application/dashboard_notifier.dart';
import '../../projects/application/project_notifier.dart';
import '../data/finance_repository.dart';
import '../domain/income_expense.dart';
import 'finance_notifier.dart';
import 'transaction_form_state.dart';

final transactionFormNotifierProvider = StateNotifierProvider.autoDispose
    .family<TransactionFormNotifier, TransactionFormState, int?>(
        (ref, transactionId) {
  final repo = ref.read(financeRepositoryProvider);
  return TransactionFormNotifier(ref, repo, transactionId);
});

class TransactionFormNotifier extends StateNotifier<TransactionFormState> {
  TransactionFormNotifier(this._ref, this._repo, this._transactionId)
      : super(TransactionFormState.initial()) {
    if (_transactionId != null) {
      _load();
    }
  }

  final Ref _ref;
  final FinanceRepository _repo;
  final int? _transactionId;

  void setType(String value) => state = state.copyWith(type: value);

  void setAmount(String value) => state = state.copyWith(amount: value);

  void setCategory(String value) => state = state.copyWith(category: value);

  void setEmployer(int? id) =>
      state = state.copyWith(employerId: id, clearProject: true);

  void setProject(int? id) => state = state.copyWith(projectId: id);

  void setDescription(String value) =>
      state = state.copyWith(description: value);

  void setDate(DateTime value) =>
      state = state.copyWith(updateDate: true, txDate: value);

  Future<void> _load() async {
    try {
      state = state.copyWith(loading: true, clearError: true);
      final tx = await _repo.fetchById(_transactionId!);
      if (tx == null) {
        state = state.copyWith(
          loading: false,
          error: 'Kayıt bulunamadı',
        );
        return;
      }
      state = state.copyWith(
        loading: false,
        id: tx.id,
        type: tx.type,
        amount: (tx.amount / 100).toStringAsFixed(2),
        category: tx.category,
        employerId: tx.employerId,
        projectId: tx.projectId,
        description: tx.description ?? '',
        updateDate: true,
        txDate: tx.txDate,
        revision: state.revision + 1,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<bool> save() async {
    if (!state.canSubmit) return false;
    try {
      state = state.copyWith(saving: true, clearError: true);
      final amount =
          (double.tryParse(state.amount.replaceAll(',', '.')) ?? 0) * 100;
      final model = IncomeExpenseModel(
        id: state.id,
        projectId: state.projectId!,
        employerId: state.employerId!,
        type: state.type,
        category: state.category,
        amount: amount.toInt(),
        description: state.description.isEmpty ? null : state.description,
        txDate: state.txDate,
      );
      if (state.id == null) {
        await _repo.insertTransaction(model);
      } else {
        await _repo.updateTransaction(model);
      }
      await _ref.read(financeNotifierProvider.notifier).loadAll();
      await _ref.read(projectNotifierProvider.notifier).loadProjects();
      await _ref.read(dashboardProvider.notifier).loadDashboard();
      state = state.copyWith(saving: false);
      return true;
    } catch (e) {
      state = state.copyWith(saving: false, error: e.toString());
      return false;
    }
  }
}
