import 'package:flutter/material.dart';

import '../domain/payment.dart';
import '../domain/worker.dart';
import '../domain/worker_assignment.dart';

class WorkerTile extends StatelessWidget {
  const WorkerTile({super.key, required this.worker, this.onTap});

  final WorkerModel worker;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.white.withOpacity(0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(worker.fullName),
      subtitle: Text(
        'Günlük Ücret: ${(worker.dailyRate / 100).toStringAsFixed(2)} ₺',
      ),
      trailing: Chip(
        label: Text(worker.active ? 'Aktif' : 'Pasif'),
        backgroundColor: worker.active
            ? Colors.green.withOpacity(0.2)
            : Colors.grey.withOpacity(0.2),
      ),
    );
  }
}

class AssignmentTile extends StatelessWidget {
  const AssignmentTile({
    super.key,
    required this.assignment,
    required this.projectName,
  });

  final WorkerAssignmentModel assignment;
  final String? projectName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(projectName ?? 'Proje'),
          Text(
            'Tarih: ${assignment.workDate.toLocal().toString().split(' ').first}',
          ),
          Text('Gün/Saat: ${assignment.hours}'),
        ],
      ),
    );
  }
}

class WorkerPaymentTile extends StatelessWidget {
  const WorkerPaymentTile({super.key, required this.payment});

  final PaymentModel payment;

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
          Text(payment.method),
        ],
      ),
    );
  }
}
