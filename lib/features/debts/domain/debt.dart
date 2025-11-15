import 'package:flutter/foundation.dart';

const Object _undefined = Object();

enum DebtStatus { pending, partial, paid }

extension DebtStatusX on DebtStatus {
  String get label => name;

  static DebtStatus fromString(String value) {
    switch (value) {
      case 'partial':
        return DebtStatus.partial;
      case 'paid':
        return DebtStatus.paid;
      default:
        return DebtStatus.pending;
    }
  }
}

@immutable
class Debt {
  final int? id;
  final int employerId;
  final int? projectId;
  final int amount;
  final DateTime borrowDate;
  final DateTime dueDate;
  final DebtStatus status;
  final String? description;
  final DateTime createdAt;

  const Debt({
    this.id,
    required this.employerId,
    this.projectId,
    required this.amount,
    required this.borrowDate,
    required this.dueDate,
    required this.status,
    this.description,
    required this.createdAt,
  });

  Debt copyWith({
    int? employerId,
    int? amount,
    DateTime? borrowDate,
    DateTime? dueDate,
    DebtStatus? status,
    DateTime? createdAt,
    Object? id = _undefined,
    Object? projectId = _undefined,
    Object? description = _undefined,
  }) =>
      Debt(
        id: id == _undefined ? this.id : id as int?,
        employerId: employerId ?? this.employerId,
        projectId: projectId == _undefined ? this.projectId : projectId as int?,
        amount: amount ?? this.amount,
        borrowDate: borrowDate ?? this.borrowDate,
        dueDate: dueDate ?? this.dueDate,
        status: status ?? this.status,
        description: description == _undefined
            ? this.description
            : description as String?,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Debt.fromJson(Map<String, dynamic> json) => Debt(
        id: json['id'] as int?,
        employerId: json['employerId'] as int,
        projectId: json['projectId'] as int?,
        amount: json['amount'] as int,
        borrowDate: DateTime.parse(json['borrowDate'] as String),
        dueDate: DateTime.parse(json['dueDate'] as String),
        status: DebtStatusX.fromString(json['status'] as String),
        description: json['description'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'employerId': employerId,
        'projectId': projectId,
        'amount': amount,
        'borrowDate': borrowDate.toIso8601String(),
        'dueDate': dueDate.toIso8601String(),
        'status': status.name,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
      };
}
