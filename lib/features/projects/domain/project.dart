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
    int? id,
    int? employerId,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? budget,
    String? description,
  }) {
    return Project(
      id: id ?? this.id,
      employerId: employerId ?? this.employerId,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      budget: budget ?? this.budget,
      description: description ?? this.description,
    );
  }

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['id'] as int?,
        employerId: json['employerId'] as int,
        title: json['title'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
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
