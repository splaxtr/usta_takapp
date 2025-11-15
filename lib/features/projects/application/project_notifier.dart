import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/project_repository.dart';
import '../domain/project.dart';
import '../domain/project_metrics.dart';
import 'project_state.dart';

final projectNotifierProvider =
    StateNotifierProvider<ProjectNotifier, ProjectState>((ref) {
      final repo = ref.read(projectRepositoryProvider);
      return ProjectNotifier(repo)..loadProjects();
    });

class ProjectNotifier extends StateNotifier<ProjectState> {
  ProjectNotifier(this._repo) : super(ProjectState.initial());

  final ProjectRepository _repo;

  Future<void> loadProjects() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final projects = await _repo.fetchAll();
      final summaries = <int, ProjectSummaryStats>{};
      for (final project in projects) {
        if (project.id != null) {
          summaries[project.id!] = await _repo.getProjectSummary(project.id!);
        }
      }
      state = state.copyWith(
        loading: false,
        projects: projects,
        projectSummaries: summaries,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loadProjectDetail(int projectId) async {
    try {
      state = state.copyWith(loading: true, error: null);
      final project = await _repo.fetchById(projectId);
      if (project == null) {
        state = state.copyWith(loading: false, error: 'Proje bulunamadı');
        return;
      }
      state = state.copyWith(selectedProject: project);
      await loadSummary(projectId);
      await loadTransactions(projectId);
      await loadDebts(projectId);
      await loadWorkers(projectId);
      await loadPayments(projectId);
      state = state.copyWith(loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loadSummary(int projectId) async {
    final summary = await _repo.getProjectSummary(projectId);
    state = state.copyWith(
      incomeTotal: summary.income,
      expenseTotal: summary.expense,
      netBalance: summary.netBalance,
      projectSummaries: {...state.projectSummaries, projectId: summary},
    );
  }

  Future<void> loadTransactions(int projectId) async {
    final tx = await _repo.getTransactionsForProject(projectId);
    state = state.copyWith(transactions: tx);
  }

  Future<void> loadDebts(int projectId) async {
    final items = await _repo.getDebtsForProject(projectId);
    state = state.copyWith(debts: items);
  }

  Future<void> loadWorkers(int projectId) async {
    final result = await _repo.getWorkersForProject(projectId);
    state = state.copyWith(workers: result.workers, workerStats: result.stats);
  }

  Future<void> loadPayments(int projectId) async {
    final items = await _repo.getPaymentsForProject(projectId);
    state = state.copyWith(payments: items);
  }

  Future<void> addProject(Project project) async {
    await _repo.insert(project);
    await loadProjects();
  }

  Future<void> updateProject(Project project) async {
    await _repo.update(project);
    await loadProjects();
  }

  Future<void> deleteProject(int id) async {
    await _repo.delete(id);
    await loadProjects();
  }
}
