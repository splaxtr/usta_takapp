import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/project_repository.dart';
import '../domain/project.dart';
import 'project_state.dart';

final projectNotifierProvider = StateNotifierProvider<ProjectNotifier, ProjectState>((ref) {
  final repo = ref.watch(projectRepositoryProvider);
  return ProjectNotifier(repo)..load();
});

class ProjectNotifier extends StateNotifier<ProjectState> {
  ProjectNotifier(this._repo) : super(ProjectState.initial());

  final ProjectRepository _repo;

  Future<void> load() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final result = await _repo.fetchAll();
      state = state.copyWith(loading: false, data: result);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> addProject(Project project) async {
    await _repo.insert(project);
    await load();
  }

  Future<void> updateProject(Project project) async {
    await _repo.update(project);
    await load();
  }

  Future<void> deleteProject(int id) async {
    await _repo.delete(id);
    await load();
  }
}
