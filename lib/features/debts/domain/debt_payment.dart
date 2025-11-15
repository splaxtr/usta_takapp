class DebtPayment {
  final int? id;
  final int debtId;
  final int amount;
  final DateTime paymentDate;
  final String? note;

  const DebtPayment({
    this.id,
    required this.debtId,
    required this.amount,
    required this.paymentDate,
    this.note,
  });

  DebtPayment copyWith({
    int? id,
    int? debtId,
    int? amount,
    DateTime? paymentDate,
    String? note,
  }) {
    return DebtPayment(
      id: id ?? this.id,
      debtId: debtId ?? this.debtId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      note: note ?? this.note,
    );
  }

  factory DebtPayment.fromJson(Map<String, dynamic> json) => DebtPayment(
        id: json['id'] as int?,
        debtId: json['debtId'] as int,
        amount: json['amount'] as int,
        paymentDate: DateTime.parse(json['paymentDate'] as String),
        note: json['note'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'debtId': debtId,
        'amount': amount,
        'paymentDate': paymentDate.toIso8601String(),
        'note': note,
      };
}
