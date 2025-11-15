import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/dashboard_repository.dart';
import 'dashboard_state.dart';

final dashboardProvider = StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repo)..loadDashboard();
});

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier(this._repository) : super(DashboardState.initial());

  final DashboardRepository _repository;

  Future<void> loadDashboard() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final results = await Future.wait([
        _repository.fetchTotalIncome(),
        _repository.fetchTotalExpense(),
        _repository.fetchTotalEmployerDebt(),
        _repository.fetchActiveProjects(),
        _repository.fetchUpcomingDebts(),
      ]);

      state = state.copyWith(
        loading: false,
        totalIncome: results[0] as int,
        totalExpense: results[1] as int,
        totalDebt: results[2] as int,
        activeProjects: results[3] as List,
        upcomingDebts: results[4] as List,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
