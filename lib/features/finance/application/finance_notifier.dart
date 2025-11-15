import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/finance_repository.dart';
import '../domain/income_expense.dart';
import 'finance_state.dart';

final financeNotifierProvider =
    StateNotifierProvider<FinanceNotifier, FinanceState>((ref) {
      final repo = ref.read(financeRepositoryProvider);
      return FinanceNotifier(repo)..loadAll();
    });

class FinanceNotifier extends StateNotifier<FinanceState> {
  FinanceNotifier(this._repository) : super(FinanceState.initial());

  final FinanceRepository _repository;
  String _mode = 'all';
  int? _projectId;
  String? _category;
  DateTimeRange? _dateRange;

  Future<void> loadAll() async {
    _mode = 'all';
    _projectId = null;
    _category = null;
    _dateRange = null;
    await _loadTransactions(() => _repository.fetchAll());
  }

  Future<void> loadIncome() async {
    _mode = 'income';
    await _loadTransactions(() => _repository.fetchIncome());
  }

  Future<void> loadExpense() async {
    _mode = 'expense';
    await _loadTransactions(() => _repository.fetchExpense());
  }

  Future<void> loadByProject(int projectId) async {
    _mode = 'project';
    _projectId = projectId;
    await _loadTransactions(() => _repository.fetchByProject(projectId));
  }

  Future<void> loadByCategory(String category) async {
    _mode = 'category';
    _category = category;
    await _loadTransactions(() => _repository.fetchByCategory(category));
  }

  Future<void> loadByDateRange(DateTimeRange range) async {
    _mode = 'date';
    _dateRange = range;
    await _loadTransactions(
      () => _repository.fetchByDateRange(range.start, range.end),
    );
  }

  Future<void> addTransaction(IncomeExpenseModel model) async {
    await _repository.insertTransaction(model);
    await reloadTotals();
    await _reloadCurrentView();
  }

  Future<void> reloadTotals() async {
    final totals = await Future.wait([
      _repository.getTotalIncome(),
      _repository.getTotalExpense(),
    ]);
    state = state.copyWith(totalIncome: totals[0], totalExpense: totals[1]);
  }

  Future<void> _loadTransactions(
    Future<List<IncomeExpenseModel>> Function() loader,
  ) async {
    try {
      state = state.copyWith(loading: true, error: null);
      final results = await loader();
      final totals = await Future.wait([
        _repository.getTotalIncome(),
        _repository.getTotalExpense(),
      ]);
      state = state.copyWith(
        loading: false,
        transactions: results,
        totalIncome: totals[0],
        totalExpense: totals[1],
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> _reloadCurrentView() {
    switch (_mode) {
      case 'income':
        return loadIncome();
      case 'expense':
        return loadExpense();
      case 'project':
        return loadByProject(_projectId!);
      case 'category':
        return loadByCategory(_category!);
      case 'date':
        return loadByDateRange(_dateRange!);
      default:
        return loadAll();
    }
  }
}
