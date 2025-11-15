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
    int? id,
    String? name,
    String? contact,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Employer(
      id: id ?? this.id,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        id: json['id'] as int?,
        name: json['name'] as String,
        contact: json['contact'] as String?,
        note: json['note'] as String?,
        createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
        updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
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
