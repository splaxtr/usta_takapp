import 'package:flutter/foundation.dart';

const Object _undefined = Object();

@immutable
class WeeklyReport {
  final int? id;
  final DateTime weekStart;
  final int incomeTotal;
  final int expenseTotal;
  final int debtTotal;
  final int payrollTotal;
  final DateTime generatedAt;

  const WeeklyReport({
    this.id,
    required this.weekStart,
    required this.incomeTotal,
    required this.expenseTotal,
    required this.debtTotal,
    required this.payrollTotal,
    required this.generatedAt,
  });

  WeeklyReport copyWith({
    DateTime? weekStart,
    int? incomeTotal,
    int? expenseTotal,
    int? debtTotal,
    int? payrollTotal,
    DateTime? generatedAt,
    Object? id = _undefined,
  }) => WeeklyReport(
    id: id == _undefined ? this.id : id as int?,
    weekStart: weekStart ?? this.weekStart,
    incomeTotal: incomeTotal ?? this.incomeTotal,
    expenseTotal: expenseTotal ?? this.expenseTotal,
    debtTotal: debtTotal ?? this.debtTotal,
    payrollTotal: payrollTotal ?? this.payrollTotal,
    generatedAt: generatedAt ?? this.generatedAt,
  );

  factory WeeklyReport.fromJson(Map<String, dynamic> json) => WeeklyReport(
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
