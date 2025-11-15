import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/debt_notifier.dart';
import '../domain/debt_payment.dart';

class AddDebtPaymentModal extends ConsumerStatefulWidget {
  const AddDebtPaymentModal({super.key, required this.debtId});

  final int debtId;

  @override
  ConsumerState<AddDebtPaymentModal> createState() =>
      _AddDebtPaymentModalState();
}

class _AddDebtPaymentModalState extends ConsumerState<AddDebtPaymentModal> {
  final amountController = TextEditingController();
  final noteController = TextEditingController();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kısmi Ödeme', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Tutar (₺)'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: noteController,
            decoration: const InputDecoration(labelText: 'Not (opsiyonel)'),
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
                  : () {
                      final amount =
                          (double.tryParse(
                                amountController.text.replaceAll(',', '.'),
                              ) ??
                              0) *
                          100;
                      ref
                          .read(debtNotifierProvider.notifier)
                          .addPayment(
                            DebtPayment(
                              debtId: widget.debtId,
                              amount: amount.toInt(),
                              paymentDate: paymentDate,
                              note: noteController.text,
                            ),
                          );
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
