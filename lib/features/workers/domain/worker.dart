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
    int? id,
    String? fullName,
    int? dailyRate,
    String? phone,
    String? note,
    bool? active,
  }) {
    return WorkerModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      dailyRate: dailyRate ?? this.dailyRate,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      active: active ?? this.active,
    );
  }

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
