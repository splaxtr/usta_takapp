import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../employers/application/employer_notifier.dart';
import '../../projects/application/project_notifier.dart';
import '../application/debt_notifier.dart';
import '../domain/debt.dart';

class AddDebtModal extends ConsumerStatefulWidget {
  const AddDebtModal({super.key});

  @override
  ConsumerState<AddDebtModal> createState() => _AddDebtModalState();
}

class _AddDebtModalState extends ConsumerState<AddDebtModal> {
  int? employerId;
  int? projectId;
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime borrowDate = DateTime.now();
  DateTime dueDate = DateTime.now().add(const Duration(days: 30));

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employers = ref.watch(employerNotifierProvider).employers;
    final projects = ref.watch(projectNotifierProvider).projects;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Yeni Borç', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'İşveren'),
              items: employers
                  .map(
                    (e) => DropdownMenuItem(value: e.id, child: Text(e.name)),
                  )
                  .toList(),
              value: employerId,
              onChanged: (value) => setState(() {
                employerId = value;
                projectId = null;
              }),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Proje (opsiyonel)'),
              items: projects
                  .where(
                    (p) => employerId == null || p.employerId == employerId,
                  )
                  .map(
                    (p) => DropdownMenuItem(value: p.id, child: Text(p.title)),
                  )
                  .toList(),
              value: projectId,
              onChanged: (value) => setState(() => projectId = value),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Tutar (₺)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: borrowDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => borrowDate = picked);
                      }
                    },
                    child: Text(
                      'Alınan Tarih: ${borrowDate.toLocal().toString().split(' ').first}',
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: dueDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => dueDate = picked);
                      }
                    },
                    child: Text(
                      'Vade: ${dueDate.toLocal().toString().split(' ').first}',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: employerId == null || amountController.text.isEmpty
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
                            .addDebt(
                              Debt(
                                employerId: employerId!,
                                projectId: projectId,
                                amount: amount.toInt(),
                                borrowDate: borrowDate,
                                dueDate: dueDate,
                                status: 'pending',
                                description: descriptionController.text,
                              ),
                            );
                        Navigator.pop(context);
                      },
                child: const Text('Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
