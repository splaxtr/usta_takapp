import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/worker_notifier.dart';
import '../domain/worker.dart';

class AddWorkerModal extends ConsumerStatefulWidget {
  const AddWorkerModal({super.key});

  @override
  ConsumerState<AddWorkerModal> createState() => _AddWorkerModalState();
}

class _AddWorkerModalState extends ConsumerState<AddWorkerModal> {
  final nameController = TextEditingController();
  final rateController = TextEditingController();
  final phoneController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    rateController.dispose();
    phoneController.dispose();
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
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Ad Soyad'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: rateController,
            decoration: const InputDecoration(labelText: 'Günlük Ücret (₺)'),
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: 'Telefon'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: noteController,
            decoration: const InputDecoration(labelText: 'Not'),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  nameController.text.isEmpty || rateController.text.isEmpty
                  ? null
                  : () async {
                      final rate =
                          (double.tryParse(
                                rateController.text.replaceAll(',', '.'),
                              ) ??
                              0) *
                          100;
                      final worker = WorkerModel(
                        fullName: nameController.text,
                        dailyRate: rate.toInt(),
                        phone: phoneController.text.isEmpty
                            ? null
                            : phoneController.text,
                        note: noteController.text.isEmpty
                            ? null
                            : noteController.text,
                        active: true,
                      );
                      await ref
                          .read(workerNotifierProvider.notifier)
                          .addWorker(worker);
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
