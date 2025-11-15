class WorkerFormState {
  final int? id;
  final String fullName;
  final String dailyRate;
  final String phone;
  final String note;
  final bool active;
  final bool loading;
  final bool saving;
  final String? error;
  final int revision;

  const WorkerFormState({
    this.id,
    this.fullName = '',
    this.dailyRate = '',
    this.phone = '',
    this.note = '',
    this.active = true,
    this.loading = false,
    this.saving = false,
    this.error,
    this.revision = 0,
  });

  factory WorkerFormState.initial() => const WorkerFormState();

  WorkerFormState copyWith({
    int? id,
    String? fullName,
    String? dailyRate,
    String? phone,
    String? note,
    bool? active,
    bool? loading,
    bool? saving,
    String? error,
    bool clearError = false,
    int? revision,
  }) {
    return WorkerFormState(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      dailyRate: dailyRate ?? this.dailyRate,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      active: active ?? this.active,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      error: clearError ? null : (error ?? this.error),
      revision: revision ?? this.revision,
    );
  }

  bool get isValid {
    final rate = double.tryParse(dailyRate.replaceAll(',', '.')) ?? 0;
    return fullName.trim().isNotEmpty && rate > 0;
  }

  bool get canSubmit => !loading && !saving && isValid;
}
