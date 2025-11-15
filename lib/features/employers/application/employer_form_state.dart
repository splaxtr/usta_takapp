class EmployerFormState {
  final int? id;
  final String name;
  final String phone;
  final String note;
  final String totalCreditLimit;
  final DateTime? createdAt;
  final bool loading;
  final bool saving;
  final String? error;
  final int revision;

  const EmployerFormState({
    this.id,
    this.name = '',
    this.phone = '',
    this.note = '',
    this.totalCreditLimit = '0',
    this.createdAt,
    this.loading = false,
    this.saving = false,
    this.error,
    this.revision = 0,
  });

  factory EmployerFormState.initial() => const EmployerFormState();

  EmployerFormState copyWith({
    int? id,
    String? name,
    String? phone,
    String? note,
    String? totalCreditLimit,
    DateTime? createdAt,
    bool? loading,
    bool? saving,
    String? error,
    bool clearError = false,
    int? revision,
  }) {
    return EmployerFormState(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      totalCreditLimit: totalCreditLimit ?? this.totalCreditLimit,
      createdAt: createdAt ?? this.createdAt,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      error: clearError ? null : (error ?? this.error),
      revision: revision ?? this.revision,
    );
  }

  bool get canSubmit => !loading && !saving && name.trim().isNotEmpty;
}
