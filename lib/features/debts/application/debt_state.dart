import '../domain/debt.dart';
import '../domain/debt_payment.dart';

class DebtState {
  final bool loading;
  final List<Debt> debts;
  final Debt? selectedDebt;
  final List<DebtPayment> payments;
  final int remainingAmount;
  final String? error;

  const DebtState({
    required this.loading,
    required this.debts,
    required this.selectedDebt,
    required this.payments,
    required this.remainingAmount,
    this.error,
  });

  factory DebtState.initial() => const DebtState(
    loading: true,
    debts: [],
    selectedDebt: null,
    payments: [],
    remainingAmount: 0,
  );

  DebtState copyWith({
    bool? loading,
    List<Debt>? debts,
    Debt? selectedDebt,
    List<DebtPayment>? payments,
    int? remainingAmount,
    String? error,
  }) {
    return DebtState(
      loading: loading ?? this.loading,
      debts: debts ?? this.debts,
      selectedDebt: selectedDebt ?? this.selectedDebt,
      payments: payments ?? this.payments,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      error: error,
    );
  }
}
