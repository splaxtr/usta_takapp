import '../domain/project.dart';

class ProjectState {
  final bool loading;
  final List<Project> data;
  final String? error;

  const ProjectState({
    required this.loading,
    required this.data,
    this.error,
  });

  factory ProjectState.initial() => const ProjectState(loading: true, data: []);

  ProjectState copyWith({
    bool? loading,
    List<Project>? data,
    String? error,
  }) => ProjectState(
        loading: loading ?? this.loading,
        data: data ?? this.data,
        error: error,
      );
}
