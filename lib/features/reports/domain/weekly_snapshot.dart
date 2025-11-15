import 'package:flutter/foundation.dart';

import '../../debts/domain/debt.dart';
import '../../debts/domain/debt_payment.dart';
import '../../finance/domain/income_expense.dart';
import '../../workers/domain/worker_assignment.dart';
import '../../projects/domain/project.dart';

const Object _undefined = Object();

@immutable
class WeeklySnapshot {
  final int? id;
  final DateTime weekStart;
  final int incomeTotal;
  final int expenseTotal;
  final int debtTotal;
  final int payrollTotal;
  final DateTime generatedAt;

  final List<IncomeExpenseModel> transactions;
  final List<WorkerAssignmentModel> assignments;
  final List<Debt> debts;
  final List<DebtPayment> debtPayments;
  final List<Project> activeProjects;

  const WeeklySnapshot({
    this.id,
    required this.weekStart,
    required this.incomeTotal,
    required this.expenseTotal,
    required this.debtTotal,
    required this.payrollTotal,
    required this.generatedAt,
    this.transactions = const [],
    this.assignments = const [],
    this.debts = const [],
    this.debtPayments = const [],
    this.activeProjects = const [],
  });

  WeeklySnapshot copyWith({
    DateTime? weekStart,
    int? incomeTotal,
    int? expenseTotal,
    int? debtTotal,
    int? payrollTotal,
    DateTime? generatedAt,
    List<IncomeExpenseModel>? transactions,
    List<WorkerAssignmentModel>? assignments,
    List<Debt>? debts,
    List<DebtPayment>? debtPayments,
    List<Project>? activeProjects,
    Object? id = _undefined,
  }) {
    return WeeklySnapshot(
      id: id == _undefined ? this.id : id as int?,
      weekStart: weekStart ?? this.weekStart,
      incomeTotal: incomeTotal ?? this.incomeTotal,
      expenseTotal: expenseTotal ?? this.expenseTotal,
      debtTotal: debtTotal ?? this.debtTotal,
      payrollTotal: payrollTotal ?? this.payrollTotal,
      generatedAt: generatedAt ?? this.generatedAt,
      transactions: transactions ?? this.transactions,
      assignments: assignments ?? this.assignments,
      debts: debts ?? this.debts,
      debtPayments: debtPayments ?? this.debtPayments,
      activeProjects: activeProjects ?? this.activeProjects,
    );
  }

  factory WeeklySnapshot.fromJson(Map<String, dynamic> json) => WeeklySnapshot(
        id: json['id'] as int?,
        weekStart: DateTime.parse(json['weekStart'] as String),
        incomeTotal: json['incomeTotal'] as int,
        expenseTotal: json['expenseTotal'] as int,
        debtTotal: json['debtTotal'] as int,
        payrollTotal: json['payrollTotal'] as int,
        generatedAt: DateTime.parse(json['generatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'weekStart': weekStart.toIso8601String(),
        'incomeTotal': incomeTotal,
        'expenseTotal': expenseTotal,
        'debtTotal': debtTotal,
        'payrollTotal': payrollTotal,
        'generatedAt': generatedAt.toIso8601String(),
      };
}
