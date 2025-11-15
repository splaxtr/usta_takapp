import 'package:flutter/foundation.dart';

const Object _undefined = Object();

@immutable
class PaymentModel {
  final int? id;
  final int workerId;
  final int? projectId;
  final int amount;
  final DateTime paymentDate;
  final String method;
  final String? note;

  const PaymentModel({
    this.id,
    required this.workerId,
    required this.projectId,
    required this.amount,
    required this.paymentDate,
    required this.method,
    this.note,
  });

  PaymentModel copyWith({
    int? workerId,
    Object? projectId = _undefined,
    int? amount,
    DateTime? paymentDate,
    String? method,
    Object? id = _undefined,
    Object? note = _undefined,
  }) =>
      PaymentModel(
        id: id == _undefined ? this.id : id as int?,
        workerId: workerId ?? this.workerId,
        projectId: projectId == _undefined ? this.projectId : projectId as int?,
        amount: amount ?? this.amount,
        paymentDate: paymentDate ?? this.paymentDate,
        method: method ?? this.method,
        note: note == _undefined ? this.note : note as String?,
      );

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'] as int?,
        workerId: json['workerId'] as int,
        projectId: json['projectId'] as int?,
        amount: json['amount'] as int,
        paymentDate: DateTime.parse(json['paymentDate'] as String),
        method: json['method'] as String,
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'workerId': workerId,
        'projectId': projectId,
        'amount': amount,
        'paymentDate': paymentDate.toIso8601String(),
        'method': method,
        'note': note,
      };
}
