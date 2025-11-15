import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../workers/domain/payment.dart';
import '../../application/project_notifier.dart';

class ProjectPaymentsTab extends ConsumerWidget {
  const ProjectPaymentsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payments = ref.watch(projectNotifierProvider).payments;
    if (payments.isEmpty) {
      return const Center(child: Text('Ödeme kaydı yok'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (_, index) => PaymentTile(payment: payments[index]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () {},
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
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.03),
      ),
      child: Row(
        children: [
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
