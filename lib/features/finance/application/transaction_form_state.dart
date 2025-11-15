class TransactionFormState {
  final int? id;
  final String type;
  final String amount;
  final String category;
  final int? employerId;
  final int? projectId;
  final String description;
  final DateTime txDate;
  final bool loading;
  final bool saving;
  final String? error;
  final int revision;

  const TransactionFormState({
    this.id,
    this.type = 'income',
    this.amount = '',
    this.category = '',
    this.employerId,
    this.projectId,
    this.description = '',
    DateTime? txDate,
    this.loading = false,
    this.saving = false,
    this.error,
    this.revision = 0,
  }) : txDate = txDate ?? DateTime.now();

  factory TransactionFormState.initial() =>
      TransactionFormState(category: 'Diğer');

  TransactionFormState copyWith({
    int? id,
    String? type,
    String? amount,
    String? category,
    int? employerId,
    int? projectId,
    bool clearProject = false,
    String? description,
    DateTime? txDate,
    bool updateDate = false,
    bool? loading,
    bool? saving,
    String? error,
    bool clearError = false,
    int? revision,
  }) {
    return TransactionFormState(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      employerId: employerId ?? this.employerId,
      projectId: clearProject ? null : (projectId ?? this.projectId),
      description: description ?? this.description,
      txDate: updateDate ? txDate : this.txDate,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      error: clearError ? null : (error ?? this.error),
      revision: revision ?? this.revision,
    );
  }

  bool get canSubmit => !loading && !saving && amount.trim().isNotEmpty;
}
