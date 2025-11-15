import '../../debts/domain/debt.dart';
import '../../debts/domain/debt_payment.dart';
import '../../finance/domain/income_expense.dart';
import '../../projects/domain/project.dart';
import '../../workers/domain/worker_assignment.dart';
import '../domain/weekly_snapshot.dart';

class ReportState {
  final bool loading;
  final WeeklySnapshot? snapshot;
  final int debtPaid;
  final List<IncomeExpenseModel> transactions;
  final List<WorkerAssignmentModel> assignments;
  final List<Debt> debts;
  final List<DebtPayment> debtPayments;
  final List<Project> activeProjects;
  final DateTime weekStart;
  final DateTime weekEnd;
  final String? error;

  int get income => snapshot?.incomeTotal ?? 0;
  int get expense => snapshot?.expenseTotal ?? 0;
  int get payroll => snapshot?.payrollTotal ?? 0;
  int get debtTaken => snapshot?.debtTotal ?? 0;
  int get net => income - expense;

  const ReportState({
    required this.loading,
    required this.snapshot,
    required this.debtPaid,
    required this.transactions,
    required this.assignments,
    required this.debts,
    required this.debtPayments,
    required this.activeProjects,
    required this.weekStart,
    required this.weekEnd,
    this.error,
  });

  factory ReportState.initial() {
    final start = _startOfWeek(DateTime.now());
    return ReportState(
      loading: true,
      snapshot: null,
      debtPaid: 0,
      transactions: const [],
      assignments: const [],
      debts: const [],
      debtPayments: const [],
      activeProjects: const [],
      weekStart: start,
      weekEnd: start.add(const Duration(days: 6)),
    );
  }

  ReportState copyWith({
    bool? loading,
    WeeklySnapshot? snapshot,
    bool clearSnapshot = false,
    int? debtPaid,
    List<IncomeExpenseModel>? transactions,
    List<WorkerAssignmentModel>? assignments,
    List<Debt>? debts,
    List<DebtPayment>? debtPayments,
    List<Project>? activeProjects,
    DateTime? weekStart,
    DateTime? weekEnd,
    String? error,
  }) {
    return ReportState(
      loading: loading ?? this.loading,
      snapshot: clearSnapshot ? null : (snapshot ?? this.snapshot),
      debtPaid: debtPaid ?? this.debtPaid,
      transactions: transactions ?? this.transactions,
      assignments: assignments ?? this.assignments,
      debts: debts ?? this.debts,
      debtPayments: debtPayments ?? this.debtPayments,
      activeProjects: activeProjects ?? this.activeProjects,
      weekStart: weekStart ?? this.weekStart,
      weekEnd: weekEnd ?? this.weekEnd,
      error: error,
    );
  }
}

DateTime _startOfWeek(DateTime date) {
  final startOfDay = DateTime(date.year, date.month, date.day);
  return startOfDay.subtract(Duration(days: date.weekday - DateTime.monday));
}
