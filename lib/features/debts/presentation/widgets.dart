import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_tile.dart';
import '../domain/debt.dart';
import '../domain/debt_payment.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final String status;

  Color get _color {
    switch (status) {
      case 'partial':
        return Colors.blueAccent;
      case 'paid':
        return Colors.greenAccent;
      default:
        return Colors.orangeAccent;
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
    final subtitleParts = [
      'Tutar: ${(debt.amount / 100).toStringAsFixed(2)} ₺',
      'Vade: ${debt.dueDate.toLocal().toString().split(' ').first}',
      if (projectName != null) 'Proje: $projectName',
    ].where((element) => element.isNotEmpty).join(' • ');

    return AppTile(
      onTap: onTap,
      leading: const Icon(Icons.attach_money),
      title: employerName,
      subtitle: subtitleParts,
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
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
    return AppCard(
      child: Row(
        children: [
          const Icon(Icons.attach_money),
          const SizedBox(width: 12),
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
        ],
      ),
    );
  }
}
