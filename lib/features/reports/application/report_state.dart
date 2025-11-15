import '../../debts/domain/debt.dart';
import '../../debts/domain/debt_payment.dart';
import '../../finance/domain/income_expense.dart';
import '../../workers/domain/worker_assignment.dart';

class ReportState {
  final bool loading;
  final int income;
  final int expense;
  final int payroll;
  final int debtTaken;
  final int debtPaid;
  final List<IncomeExpenseModel> transactions;
  final List<WorkerAssignmentModel> assignments;
  final List<Debt> debts;
  final List<DebtPayment> debtPayments;
  final DateTime weekStart;
  final DateTime weekEnd;
  final String? error;

  const ReportState({
    required this.loading,
    required this.income,
    required this.expense,
    required this.payroll,
    required this.debtTaken,
    required this.debtPaid,
    required this.transactions,
    required this.assignments,
    required this.debts,
    required this.debtPayments,
    required this.weekStart,
    required this.weekEnd,
    this.error,
  });

  factory ReportState.initial() => ReportState(
    loading: true,
    income: 0,
    expense: 0,
    payroll: 0,
    debtTaken: 0,
    debtPaid: 0,
    transactions: const [],
    assignments: const [],
    debts: const [],
    debtPayments: const [],
    weekStart: _startOfWeek(DateTime.now()),
    weekEnd: _startOfWeek(DateTime.now()).add(const Duration(days: 6)),
  );

  ReportState copyWith({
    bool? loading,
    int? income,
    int? expense,
    int? payroll,
    int? debtTaken,
    int? debtPaid,
    List<IncomeExpenseModel>? transactions,
    List<WorkerAssignmentModel>? assignments,
    List<Debt>? debts,
    List<DebtPayment>? debtPayments,
    DateTime? weekStart,
    DateTime? weekEnd,
    String? error,
  }) {
    return ReportState(
      loading: loading ?? this.loading,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      payroll: payroll ?? this.payroll,
      debtTaken: debtTaken ?? this.debtTaken,
      debtPaid: debtPaid ?? this.debtPaid,
      transactions: transactions ?? this.transactions,
      assignments: assignments ?? this.assignments,
      debts: debts ?? this.debts,
      debtPayments: debtPayments ?? this.debtPayments,
      weekStart: weekStart ?? this.weekStart,
      weekEnd: weekEnd ?? this.weekEnd,
      error: error,
    );
  }
}

DateTime _startOfWeek(DateTime date) {
  final weekday = date.weekday;
  return DateTime(
    date.year,
    date.month,
    date.day,
  ).subtract(Duration(days: weekday - 1));
}
