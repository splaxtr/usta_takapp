import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/worker_notifier.dart';
import '../domain/payment.dart';

class AddWorkerPaymentModal extends ConsumerStatefulWidget {
  const AddWorkerPaymentModal({super.key, required this.workerId});

  final int workerId;

  @override
  ConsumerState<AddWorkerPaymentModal> createState() =>
      _AddWorkerPaymentModalState();
}

class _AddWorkerPaymentModalState extends ConsumerState<AddWorkerPaymentModal> {
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  String method = 'Nakit';
  DateTime paymentDate = DateTime.now();

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Tutar (₺)'),
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: method,
            decoration: const InputDecoration(labelText: 'Ödeme Yöntemi'),
            items: const [
              DropdownMenuItem(value: 'Nakit', child: Text('Nakit')),
              DropdownMenuItem(value: 'Havale', child: Text('Havale')),
            ],
            onChanged: (value) => setState(() => method = value ?? 'Nakit'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: noteController,
            decoration: const InputDecoration(labelText: 'Not'),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: paymentDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() => paymentDate = picked);
              }
            },
            child: Text(
              'Tarih: ${paymentDate.toLocal().toString().split(' ').first}',
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: amountController.text.isEmpty
                  ? null
                  : () async {
                      final amount =
                          (double.tryParse(
                                amountController.text.replaceAll(',', '.'),
                              ) ??
                              0) *
                          100;
                      final payment = PaymentModel(
                        workerId: widget.workerId,
                        projectId: null,
                        amount: amount.toInt(),
                        paymentDate: paymentDate,
                        method: method,
                        note: noteController.text,
                      );
                      await ref
                          .read(workerNotifierProvider.notifier)
                          .addPayment(payment);
                      Navigator.pop(context);
                    },
              child: const Text('Kaydet'),
            ),
          ),
        ],
      ),
    );
  }
}
