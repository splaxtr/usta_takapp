import '../domain/employer.dart';

class EmployerState {
  final bool loading;
  final List<Employer> data;
  final String? error;

  const EmployerState({
    required this.loading,
    required this.data,
    this.error,
  });

  factory EmployerState.initial() => const EmployerState(loading: true, data: []);

  EmployerState copyWith({
    bool? loading,
    List<Employer>? data,
    String? error,
  }) {
    return EmployerState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      error: error,
    );
  }
}
