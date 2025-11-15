import '../../debts/domain/debt.dart';
import '../../projects/domain/project.dart';

class DashboardState {
  final bool loading;
  final int totalIncome;
  final int totalExpense;
  final int totalDebt;
  final List<Project> activeProjects;
  final List<Debt> upcomingDebts;
  final String? error;

  const DashboardState({
    required this.loading,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalDebt,
    required this.activeProjects,
    required this.upcomingDebts,
    this.error,
  });

  factory DashboardState.initial() => const DashboardState(
        loading: true,
        totalIncome: 0,
        totalExpense: 0,
        totalDebt: 0,
        activeProjects: [],
        upcomingDebts: [],
      );

  DashboardState copyWith({
    bool? loading,
    int? totalIncome,
    int? totalExpense,
    int? totalDebt,
    List<Project>? activeProjects,
    List<Debt>? upcomingDebts,
    String? error,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      totalDebt: totalDebt ?? this.totalDebt,
      activeProjects: activeProjects ?? this.activeProjects,
      upcomingDebts: upcomingDebts ?? this.upcomingDebts,
      error: error,
    );
  }
}
