import '../domain/income_expense.dart';

class FinanceState {
  final bool loading;
  final List<IncomeExpenseModel> data;
  final String? error;

  const FinanceState({
    required this.loading,
    required this.data,
    this.error,
  });

  factory FinanceState.initial() => const FinanceState(loading: true, data: []);

  FinanceState copyWith({
    bool? loading,
    List<IncomeExpenseModel>? data,
    String? error,
  }) {
    return FinanceState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      error: error,
    );
  }
}
