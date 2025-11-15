class Debt {
  final int? id;
  final int employerId;
  final int? projectId;
  final int amount;
  final DateTime borrowDate;
  final DateTime dueDate;
  final String status; // pending / partial / paid
  final String? description;

  const Debt({
    this.id,
    required this.employerId,
    this.projectId,
    required this.amount,
    required this.borrowDate,
    required this.dueDate,
    required this.status,
    this.description,
  });

  Debt copyWith({
    int? id,
    int? employerId,
    int? projectId,
    int? amount,
    DateTime? borrowDate,
    DateTime? dueDate,
    String? status,
    String? description,
  }) {
    return Debt(
      id: id ?? this.id,
      employerId: employerId ?? this.employerId,
      projectId: projectId ?? this.projectId,
      amount: amount ?? this.amount,
      borrowDate: borrowDate ?? this.borrowDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  factory Debt.fromJson(Map<String, dynamic> json) => Debt(
        id: json['id'] as int?,
        employerId: json['employerId'] as int,
        projectId: json['projectId'] as int?,
        amount: json['amount'] as int,
        borrowDate: DateTime.parse(json['borrowDate'] as String),
        dueDate: DateTime.parse(json['dueDate'] as String),
        status: json['status'] as String,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'employerId': employerId,
        'projectId': projectId,
        'amount': amount,
        'borrowDate': borrowDate.toIso8601String(),
        'dueDate': dueDate.toIso8601String(),
        'status': status,
        'description': description,
      };
}
