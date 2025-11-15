import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_card.dart';
import '../../../workers/domain/payment.dart';
import '../../application/project_notifier.dart';

class ProjectPaymentsTab extends ConsumerWidget {
  const ProjectPaymentsTab({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectNotifierProvider);
    final project = state.selectedProject;
    if (project == null || project.id != projectId) {
      return const Center(child: CircularProgressIndicator());
    }
    final payments = state.payments;
    if (payments.isEmpty) {
      return const Center(child: Text('Ödeme kaydı yok'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, index) => PaymentTile(payment: payments[index]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Ödeme ekleme işlemi çalışan modülünden yapılır.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.attach_money),
            label: const Text('Ödeme Ekle'),
          ),
        ),
      ],
    );
  }
}

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key, required this.payment});

  final PaymentModel payment;

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
                  'Tutar: ${(payment.amount / 100).toStringAsFixed(2)} ₺',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Tarih: ${payment.paymentDate.toLocal().toString().split(' ').first}',
                ),
              ],
            ),
          ),
          Text(payment.method),
        ],
      ),
    );
  }
}
