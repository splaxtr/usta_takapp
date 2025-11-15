import 'package:flutter/foundation.dart';

const Object _undefined = Object();

@immutable
class WorkerAssignmentModel {
  final int? id;
  final int workerId;
  final int projectId;
  final DateTime workDate;
  final int hours;
  final int overtimeHours;

  const WorkerAssignmentModel({
    this.id,
    required this.workerId,
    required this.projectId,
    required this.workDate,
    required this.hours,
    this.overtimeHours = 0,
  });

  WorkerAssignmentModel copyWith({
    int? workerId,
    int? projectId,
    DateTime? workDate,
    int? hours,
    Object? id = _undefined,
    Object? overtimeHours = _undefined,
  }) =>
      WorkerAssignmentModel(
        id: id == _undefined ? this.id : id as int?,
        workerId: workerId ?? this.workerId,
        projectId: projectId ?? this.projectId,
        workDate: workDate ?? this.workDate,
        hours: hours ?? this.hours,
        overtimeHours: overtimeHours == _undefined
            ? this.overtimeHours
            : overtimeHours as int,
      );

  factory WorkerAssignmentModel.fromJson(Map<String, dynamic> json) =>
      WorkerAssignmentModel(
        id: json['id'] as int?,
        workerId: json['workerId'] as int,
        projectId: json['projectId'] as int,
        workDate: DateTime.parse(json['workDate'] as String),
        hours: json['hours'] as int,
        overtimeHours: json['overtimeHours'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'workerId': workerId,
        'projectId': projectId,
        'workDate': workDate.toIso8601String(),
        'hours': hours,
        'overtimeHours': overtimeHours,
      };
}
