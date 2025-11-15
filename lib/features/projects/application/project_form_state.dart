class ProjectFormState {
  final int? id;
  final String title;
  final int? employerId;
  final DateTime startDate;
  final DateTime? endDate;
  final String budget;
  final String description;
  final String status;
  final bool loading;
  final bool saving;
  final String? error;
  final int revision;

  const ProjectFormState({
    this.id,
    this.title = '',
    this.employerId,
    DateTime? startDate,
    this.endDate,
    this.budget = '',
    this.description = '',
    this.status = 'active',
    this.loading = false,
    this.saving = false,
    this.error,
    this.revision = 0,
  }) : startDate = startDate ?? DateTime.now();

  factory ProjectFormState.initial() => ProjectFormState();

  ProjectFormState copyWith({
    int? id,
    String? title,
    int? employerId,
    DateTime? startDate,
    bool updateStartDate = false,
    DateTime? endDate,
    bool clearEndDate = false,
    String? budget,
    String? description,
    String? status,
    bool? loading,
    bool? saving,
    String? error,
    bool clearError = false,
    int? revision,
  }) {
    return ProjectFormState(
      id: id ?? this.id,
      title: title ?? this.title,
      employerId: employerId ?? this.employerId,
      startDate: updateStartDate ? startDate : this.startDate,
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
      budget: budget ?? this.budget,
      description: description ?? this.description,
      status: status ?? this.status,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      error: clearError ? null : (error ?? this.error),
      revision: revision ?? this.revision,
    );
  }

  bool get canSubmit =>
      !loading && !saving && title.trim().isNotEmpty && employerId != null;
}
