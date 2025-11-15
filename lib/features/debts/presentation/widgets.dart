import 'package:flutter/material.dart';

import '../domain/debt.dart';
import '../domain/debt_payment.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final String status;

  Color get _color {
    switch (status) {
      case 'paid':
        return Colors.green;
      case 'partial':
        return Colors.orange;
      default:
        return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: _color.withOpacity(0.2),
      label: Text(status.toUpperCase(), style: TextStyle(color: _color)),
    );
  }
}

class DueBadge extends StatelessWidget {
  const DueBadge({super.key, required this.days});

  final int days;

  Color get _color {
    if (days <= 3) return Colors.redAccent;
    if (days <= 7) return Colors.orangeAccent;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$days gün',
        style: TextStyle(color: _color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class DebtTile extends StatelessWidget {
  const DebtTile({
    super.key,
    required this.debt,
    required this.employerName,
    required this.projectName,
    this.onTap,
  });

  final Debt debt;
  final String employerName;
  final String? projectName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final remainingDays = debt.dueDate.difference(DateTime.now()).inDays;
    return ListTile(
      onTap: onTap,
      tileColor: Colors.white.withOpacity(0.02),
      title: Text(employerName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (projectName != null) Text('Proje: $projectName'),
          Text('Vade: ${debt.dueDate.toLocal().toString().split(' ').first}'),
          Text('Tutar: ${(debt.amount / 100).toStringAsFixed(2)} ₺'),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DueBadge(days: remainingDays),
          const SizedBox(height: 6),
          StatusBadge(status: debt.status),
        ],
      ),
    );
  }
}

class DebtPaymentTile extends StatelessWidget {
  const DebtPaymentTile({super.key, required this.payment});

  final DebtPayment payment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.02),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${(payment.amount / 100).toStringAsFixed(2)} ₺',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Tarih: ${payment.paymentDate.toLocal().toString().split(' ').first}',
                ),
                if (payment.note != null && payment.note!.isNotEmpty)
                  Text(payment.note!),
              ],
            ),
          ),
          const Icon(Icons.receipt_long),
        ],
      ),
    );
  }
}
