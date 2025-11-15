import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import 'dashboard_state.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final notifier = DashboardNotifier(ref.read);
  notifier.load();
  return notifier;
});

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier(this._read) : super(DashboardState.initial());

  final Reader _read;

  Future<void> load() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final repo = _read(dashboardRepositoryProvider);
      final results = await Future.wait([
        repo.getTotalIncome(),
        repo.getTotalExpense(),
        repo.getTotalDebtPending(),
        repo.getUpcomingDueDebts(),
        repo.fetchActiveProjects(),
      ]);
      state = state.copyWith(
        totalIncome: results[0] as int,
        totalExpense: results[1] as int,
        totalDebt: results[2] as int,
        upcomingDebts: results[3] as List,
        activeProjects: results[4] as List,
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() => load();
}
