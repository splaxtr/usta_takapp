import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/finance_repository.dart';
import '../domain/income_expense.dart';
import 'finance_state.dart';

final financeNotifierProvider = StateNotifierProvider.family<FinanceNotifier, FinanceState, int>((ref, projectId) {
  final repo = ref.watch(financeRepositoryProvider);
  return FinanceNotifier(repo, projectId)..load();
});

class FinanceNotifier extends StateNotifier<FinanceState> {
  FinanceNotifier(this._repo, this._projectId) : super(FinanceState.initial());

  final FinanceRepository _repo;
  final int _projectId;

  Future<void> load() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final result = await _repo.fetchByProject(_projectId);
      state = state.copyWith(loading: false, data: result);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> addTransaction(IncomeExpenseModel model) async {
    await _repo.insert(model);
    await load();
  }

  Future<void> updateTransaction(IncomeExpenseModel model) async {
    await _repo.update(model);
    await load();
  }

  Future<void> deleteTransaction(int id) async {
    await _repo.delete(id);
    await load();
  }
}
