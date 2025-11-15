import '../domain/debt.dart';
import '../domain/debt_payment.dart';

class DebtState {
  final bool loading;
  final List<Debt> data;
  final Map<int, List<DebtPayment>> payments;
  final String? error;

  const DebtState({
    required this.loading,
    required this.data,
    required this.payments,
    this.error,
  });

  factory DebtState.initial() => const DebtState(loading: true, data: [], payments: {});

  DebtState copyWith({
    bool? loading,
    List<Debt>? data,
    Map<int, List<DebtPayment>>? payments,
    String? error,
  }) {
    return DebtState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      payments: payments ?? this.payments,
      error: error,
    );
  }
}
