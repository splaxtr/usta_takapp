class PaymentFormState {
  final int? id;
  final int? workerId;
  final int? projectId;
  final String amount;
  final DateTime paymentDate;
  final String note;
  final bool loading;
  final bool saving;
  final String? error;
  final int revision;

  const PaymentFormState({
    this.id,
    this.workerId,
    this.projectId,
    this.amount = '',
    DateTime? paymentDate,
    this.note = '',
    this.loading = false,
    this.saving = false,
    this.error,
    this.revision = 0,
  }) : paymentDate = paymentDate ?? DateTime.now();

  factory PaymentFormState.initial() => PaymentFormState();

  PaymentFormState copyWith({
    int? id,
    int? workerId,
    int? projectId,
    String? amount,
    DateTime? paymentDate,
    String? note,
    bool? loading,
    bool? saving,
    String? error,
    bool clearError = false,
    int? revision,
  }) {
    return PaymentFormState(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      projectId: projectId ?? this.projectId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      note: note ?? this.note,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      error: clearError ? null : (error ?? this.error),
      revision: revision ?? this.revision,
    );
  }

  bool get canSubmit =>
      !loading &&
      !saving &&
      workerId != null &&
      projectId != null &&
      amount.trim().isNotEmpty;
}
