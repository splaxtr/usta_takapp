class DebtFormState {
  final int? id;
  final int? employerId;
  final int? projectId;
  final String amount;
  final DateTime borrowDate;
  final DateTime dueDate;
  final String description;
  final String status;
  final bool loading;
  final bool saving;
  final String? error;
  final int revision;

  const DebtFormState({
    this.id,
    this.employerId,
    this.projectId,
    this.amount = '',
    DateTime? borrowDate,
    DateTime? dueDate,
    this.description = '',
    this.status = 'pending',
    this.loading = false,
    this.saving = false,
    this.error,
    this.revision = 0,
  })  : borrowDate = borrowDate ?? DateTime.now(),
        dueDate = dueDate ?? DateTime.now().add(const Duration(days: 30));

  factory DebtFormState.initial() => DebtFormState();

  DebtFormState copyWith({
    int? id,
    int? employerId,
    int? projectId,
    bool clearProject = false,
    String? amount,
    DateTime? borrowDate,
    DateTime? dueDate,
    String? description,
    String? status,
    bool? loading,
    bool? saving,
    String? error,
    bool clearError = false,
    int? revision,
  }) {
    return DebtFormState(
      id: id ?? this.id,
      employerId: employerId ?? this.employerId,
      projectId: clearProject ? null : (projectId ?? this.projectId),
      amount: amount ?? this.amount,
      borrowDate: borrowDate ?? this.borrowDate,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      status: status ?? this.status,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      error: clearError ? null : (error ?? this.error),
      revision: revision ?? this.revision,
    );
  }

  bool get canSubmit =>
      !loading && !saving && employerId != null && amount.trim().isNotEmpty;
}
