import '../../debts/domain/debt.dart';
import '../../finance/domain/income_expense.dart';
import '../../workers/domain/payment.dart';
import '../../workers/domain/worker.dart';
import '../domain/project.dart';
import '../domain/project_metrics.dart';
import '../domain/project_summary.dart';

class ProjectState {
  final bool loading;
  final List<Project> projects;
  final Project? selectedProject;
  final ProjectSummary? summary;

  final List<IncomeExpenseModel> transactions;
  final List<Debt> debts;
  final List<WorkerModel> workers;
  final List<PaymentModel> payments;

  final Map<int, ProjectSummary> projectSummaries;
  final Map<int, WorkerProjectStats> workerStats;

  final String? error;

  const ProjectState({
    required this.loading,
    required this.projects,
    required this.selectedProject,
    required this.summary,
    required this.transactions,
    required this.debts,
    required this.workers,
    required this.payments,
    required this.projectSummaries,
    required this.workerStats,
    this.error,
  });

  factory ProjectState.initial() => const ProjectState(
        loading: true,
        projects: [],
        selectedProject: null,
        summary: null,
        transactions: [],
        debts: [],
        workers: [],
        payments: [],
        projectSummaries: <int, ProjectSummary>{},
        workerStats: <int, WorkerProjectStats>{},
      );

  ProjectState copyWith({
    bool? loading,
    List<Project>? projects,
    Project? selectedProject,
    ProjectSummary? summary,
    bool clearSummary = false,
    List<IncomeExpenseModel>? transactions,
    List<Debt>? debts,
    List<WorkerModel>? workers,
    List<PaymentModel>? payments,
    Map<int, ProjectSummary>? projectSummaries,
    Map<int, WorkerProjectStats>? workerStats,
    String? error,
  }) {
    return ProjectState(
      loading: loading ?? this.loading,
      projects: projects ?? this.projects,
      selectedProject: selectedProject ?? this.selectedProject,
      summary: clearSummary ? null : (summary ?? this.summary),
      transactions: transactions ?? this.transactions,
      debts: debts ?? this.debts,
      workers: workers ?? this.workers,
      payments: payments ?? this.payments,
      projectSummaries: projectSummaries ?? this.projectSummaries,
      workerStats: workerStats ?? this.workerStats,
      error: error,
    );
  }
}
