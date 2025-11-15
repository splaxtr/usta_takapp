import 'package:flutter/foundation.dart';

const Object _undefined = Object();

@immutable
class IncomeExpenseModel {
  final int? id;
  final int projectId;
  final int employerId;
  final String type; // income / expense
  final String category;
  final int amount;
  final String? description;
  final DateTime txDate;

  const IncomeExpenseModel({
    this.id,
    required this.projectId,
    required this.employerId,
    required this.type,
    required this.category,
    required this.amount,
    this.description,
    required this.txDate,
  });

  IncomeExpenseModel copyWith({
    int? projectId,
    int? employerId,
    String? type,
    String? category,
    int? amount,
    DateTime? txDate,
    Object? id = _undefined,
    Object? description = _undefined,
  }) => IncomeExpenseModel(
    id: id == _undefined ? this.id : id as int?,
    projectId: projectId ?? this.projectId,
    employerId: employerId ?? this.employerId,
    type: type ?? this.type,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    description: description == _undefined
        ? this.description
        : description as String?,
    txDate: txDate ?? this.txDate,
  );

  factory IncomeExpenseModel.fromJson(Map<String, dynamic> json) =>
      IncomeExpenseModel(
        id: json['id'] as int?,
        projectId: json['projectId'] as int,
        employerId: json['employerId'] as int,
        type: json['type'] as String,
        category: json['category'] as String,
        amount: json['amount'] as int,
        description: json['description'] as String?,
        txDate: DateTime.parse(json['txDate'] as String),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectId': projectId,
    'employerId': employerId,
    'type': type,
    'category': category,
    'amount': amount,
    'description': description,
    'txDate': txDate.toIso8601String(),
  };
}
