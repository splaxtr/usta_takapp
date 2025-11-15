import '../../debts/domain/debt.dart';
import '../../projects/domain/project.dart';
import '../domain/employer.dart';

class EmployerState {
  final bool loading;
  final List<Employer> employers;
  final Employer? selectedEmployer;
  final List<Project> projects;
  final List<Debt> debts;
  final int totalDebt;
  final Map<int, int> projectCounts;
  final Map<int, int> debtTotals;
  final String? error;

  const EmployerState({
    required this.loading,
    required this.employers,
    required this.selectedEmployer,
    required this.projects,
    required this.debts,
    required this.totalDebt,
    required this.projectCounts,
    required this.debtTotals,
    this.error,
  });

  factory EmployerState.initial() => const EmployerState(
    loading: true,
    employers: [],
    selectedEmployer: null,
    projects: [],
    debts: [],
    totalDebt: 0,
    projectCounts: <int, int>{},
    debtTotals: <int, int>{},
  );

  EmployerState copyWith({
    bool? loading,
    List<Employer>? employers,
    Employer? selectedEmployer,
    List<Project>? projects,
    List<Debt>? debts,
    int? totalDebt,
    Map<int, int>? projectCounts,
    Map<int, int>? debtTotals,
    String? error,
  }) {
    return EmployerState(
      loading: loading ?? this.loading,
      employers: employers ?? this.employers,
      selectedEmployer: selectedEmployer ?? this.selectedEmployer,
      projects: projects ?? this.projects,
      debts: debts ?? this.debts,
      totalDebt: totalDebt ?? this.totalDebt,
      projectCounts: projectCounts ?? this.projectCounts,
      debtTotals: debtTotals ?? this.debtTotals,
      error: error,
    );
  }
}
