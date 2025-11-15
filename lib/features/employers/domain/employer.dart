import 'package:flutter/foundation.dart';

const Object _undefined = Object();

@immutable
class Employer {
  final int? id;
  final String name;
  final String? contact;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Employer({
    this.id,
    required this.name,
    this.contact,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  Employer copyWith({
    String? name,
    Object? id = _undefined,
    Object? contact = _undefined,
    Object? note = _undefined,
    Object? createdAt = _undefined,
    Object? updatedAt = _undefined,
  }) => Employer(
    id: id == _undefined ? this.id : id as int?,
    name: name ?? this.name,
    contact: contact == _undefined ? this.contact : contact as String?,
    note: note == _undefined ? this.note : note as String?,
    createdAt: createdAt == _undefined
        ? this.createdAt
        : createdAt as DateTime?,
    updatedAt: updatedAt == _undefined
        ? this.updatedAt
        : updatedAt as DateTime?,
  );

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
    id: json['id'] as int?,
    name: json['name'] as String,
    contact: json['contact'] as String?,
    note: json['note'] as String?,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'contact': contact,
    'note': note,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
