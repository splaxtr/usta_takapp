import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../dashboard/application/dashboard_notifier.dart';
import '../data/project_repository.dart';
import '../domain/project.dart';
import 'project_form_state.dart';
import 'project_notifier.dart';

final projectFormNotifierProvider = StateNotifierProvider.autoDispose
    .family<ProjectFormNotifier, ProjectFormState, int?>((ref, projectId) {
  final repo = ref.read(projectRepositoryProvider);
  return ProjectFormNotifier(ref, repo, projectId);
});

class ProjectFormNotifier extends StateNotifier<ProjectFormState> {
  ProjectFormNotifier(this._ref, this._repo, this._projectId)
      : super(ProjectFormState.initial()) {
    if (_projectId != null) {
      _load();
    }
  }

  final Ref _ref;
  final ProjectRepository _repo;
  final int? _projectId;

  void setTitle(String value) =>
      state = state.copyWith(title: value, clearError: true);

  void setEmployer(int? id) =>
      state = state.copyWith(employerId: id, clearError: true);

  void setStartDate(DateTime date) => state = state.copyWith(
        updateStartDate: true,
        startDate: date,
        clearError: true,
      );

  void setEndDate(DateTime? date) => state = state.copyWith(
        endDate: date,
        clearEndDate: date == null,
        clearError: true,
      );

  void setBudget(String value) =>
      state = state.copyWith(budget: value, clearError: true);

  void setDescription(String value) =>
      state = state.copyWith(description: value, clearError: true);

  Future<void> _load() async {
    try {
      state = state.copyWith(loading: true, clearError: true);
      final project = await _repo.fetchById(_projectId!);
      if (project == null) {
        state = state.copyWith(
          loading: false,
          error: 'Proje bulunamadı',
        );
        return;
      }
      state = state.copyWith(
        loading: false,
        id: project.id,
        title: project.title,
        employerId: project.employerId,
        updateStartDate: true,
        startDate: project.startDate,
        endDate: project.endDate,
        budget: (project.budget / 100).toStringAsFixed(2),
        description: project.description ?? '',
        status: project.status,
        revision: state.revision + 1,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  String? _validate(double budget) {
    if (state.title.trim().isEmpty) {
      return 'Başlık zorunludur';
    }
    if (state.employerId == null) {
      return 'İşveren seçmelisiniz';
    }
    if (budget <= 0) {
      return 'Bütçe pozitif olmalı';
    }
    if (state.endDate != null && state.endDate!.isBefore(state.startDate)) {
      return 'Bitiş tarihi başlangıçtan önce olamaz';
    }
    return null;
  }

  Future<bool> save() async {
    if (!state.canSubmit) return false;
    try {
      state = state.copyWith(saving: true, clearError: true);
      final parsedBudget = (double.tryParse(
                state.budget.replaceAll(',', '.'),
              ) ??
              0) *
          100;
      final validation = _validate(parsedBudget);
      if (validation != null) {
        state = state.copyWith(saving: false, error: validation);
        return false;
      }
      final project = Project(
        id: state.id,
        employerId: state.employerId!,
        title: state.title.trim(),
        startDate: state.startDate,
        endDate: state.endDate,
        status: state.status,
        budget: parsedBudget.toInt(),
        description: state.description.isEmpty ? null : state.description,
      );
      if (state.id == null) {
        await _repo.insert(project);
      } else {
        await _repo.update(project);
      }
      await _ref.read(projectNotifierProvider.notifier).loadProjects();
      await _ref.read(dashboardProvider.notifier).refresh();
      state = state.copyWith(saving: false);
      return true;
    } catch (e) {
      state = state.copyWith(saving: false, error: e.toString());
      return false;
    }
  }
}
