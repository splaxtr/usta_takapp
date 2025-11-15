import '../../debts/domain/debt.dart';
import '../../projects/domain/project.dart';

class DashboardState {
  final int totalIncome;
  final int totalExpense;
  int get netBalance => totalIncome - totalExpense;

  final int totalDebt;
  final List<Debt> upcomingDebts;
  final List<Project> activeProjects;

  final bool loading;
  final String? error;

  DashboardState({
    required this.totalIncome,
    required this.totalExpense,
    required this.totalDebt,
    required this.upcomingDebts,
    required this.activeProjects,
    this.loading = false,
    this.error,
  });

  factory DashboardState.initial() => DashboardState(
        totalIncome: 0,
        totalExpense: 0,
        totalDebt: 0,
        upcomingDebts: const [],
        activeProjects: const [],
        loading: true,
      );

  DashboardState copyWith({
    int? totalIncome,
    int? totalExpense,
    int? totalDebt,
    List<Debt>? upcomingDebts,
    List<Project>? activeProjects,
    bool? loading,
    String? error,
  }) =>
      DashboardState(
        totalIncome: totalIncome ?? this.totalIncome,
        totalExpense: totalExpense ?? this.totalExpense,
        totalDebt: totalDebt ?? this.totalDebt,
        upcomingDebts: upcomingDebts ?? this.upcomingDebts,
        activeProjects: activeProjects ?? this.activeProjects,
        loading: loading ?? this.loading,
        error: error,
      );
}
