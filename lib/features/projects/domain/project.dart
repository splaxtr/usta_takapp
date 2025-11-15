import 'package:flutter/foundation.dart';

const Object _undefined = Object();

@immutable
class Project {
  final int? id;
  final int employerId;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final String status;
  final int budget;
  final String? description;

  const Project({
    this.id,
    required this.employerId,
    required this.title,
    required this.startDate,
    this.endDate,
    required this.status,
    required this.budget,
    this.description,
  });

  Project copyWith({
    int? employerId,
    String? title,
    DateTime? startDate,
    String? status,
    int? budget,
    Object? id = _undefined,
    Object? endDate = _undefined,
    Object? description = _undefined,
  }) => Project(
    id: id == _undefined ? this.id : id as int?,
    employerId: employerId ?? this.employerId,
    title: title ?? this.title,
    startDate: startDate ?? this.startDate,
    endDate: endDate == _undefined ? this.endDate : endDate as DateTime?,
    status: status ?? this.status,
    budget: budget ?? this.budget,
    description: description == _undefined
        ? this.description
        : description as String?,
  );

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['id'] as int?,
    employerId: json['employerId'] as int,
    title: json['title'] as String,
    startDate: DateTime.parse(json['startDate'] as String),
    endDate: json['endDate'] != null
        ? DateTime.parse(json['endDate'] as String)
        : null,
    status: json['status'] as String,
    budget: json['budget'] as int,
    description: json['description'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'employerId': employerId,
    'title': title,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'status': status,
    'budget': budget,
    'description': description,
  };
}
