import '../domain/income_expense.dart';

class FinanceState {
  final bool loading;
  final List<IncomeExpenseModel> transactions;
  final int totalIncome;
  final int totalExpense;
  final String? error;

  const FinanceState({
    required this.loading,
    required this.transactions,
    required this.totalIncome,
    required this.totalExpense,
    this.error,
  });

  factory FinanceState.initial() => const FinanceState(
    loading: true,
    transactions: [],
    totalIncome: 0,
    totalExpense: 0,
  );

  FinanceState copyWith({
    bool? loading,
    List<IncomeExpenseModel>? transactions,
    int? totalIncome,
    int? totalExpense,
    String? error,
  }) {
    return FinanceState(
      loading: loading ?? this.loading,
      transactions: transactions ?? this.transactions,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      error: error,
    );
  }
}
