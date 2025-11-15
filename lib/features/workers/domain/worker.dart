import 'package:flutter/foundation.dart';

const Object _undefined = Object();

@immutable
class WorkerModel {
  final int? id;
  final String fullName;
  final int dailyRate;
  final String? phone;
  final String? note;
  final bool active;

  const WorkerModel({
    this.id,
    required this.fullName,
    required this.dailyRate,
    this.phone,
    this.note,
    this.active = true,
  });

  WorkerModel copyWith({
    String? fullName,
    int? dailyRate,
    bool? active,
    Object? id = _undefined,
    Object? phone = _undefined,
    Object? note = _undefined,
  }) => WorkerModel(
    id: id == _undefined ? this.id : id as int?,
    fullName: fullName ?? this.fullName,
    dailyRate: dailyRate ?? this.dailyRate,
    phone: phone == _undefined ? this.phone : phone as String?,
    note: note == _undefined ? this.note : note as String?,
    active: active ?? this.active,
  );

  factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
    id: json['id'] as int?,
    fullName: json['fullName'] as String,
    dailyRate: json['dailyRate'] as int,
    phone: json['phone'] as String?,
    note: json['note'] as String?,
    active: json['active'] as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'dailyRate': dailyRate,
    'phone': phone,
    'note': note,
    'active': active,
  };
}
