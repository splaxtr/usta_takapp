import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard/application/dashboard_notifier.dart';
import '../../employers/application/employer_notifier.dart';
import '../../projects/application/project_notifier.dart';
import '../application/finance_notifier.dart';
import '../domain/income_expense.dart';
import 'finance_categories.dart';

class AddTransactionModal extends ConsumerStatefulWidget {
  const AddTransactionModal({
    super.key,
    this.initialProjectId,
    this.initialEmployerId,
  });

  final int? initialProjectId;
  final int? initialEmployerId;

  @override
  ConsumerState<AddTransactionModal> createState() =>
      _AddTransactionModalState();
}

class _AddTransactionModalState extends ConsumerState<AddTransactionModal> {
  String type = 'income';
  String category = financeCategories.first;
  int? employerId;
  int? projectId;
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  DateTime txDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    employerId = widget.initialEmployerId;
    projectId = widget.initialProjectId;
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employers = ref.watch(employerNotifierProvider).employers;
    final projects = ref.watch(projectNotifierProvider).projects;

    final filteredProjects = employerId == null
        ? projects
        : projects.where((p) => p.employerId == employerId).toList();

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
            Text('Yeni İşlem', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: [type == 'income', type == 'expense'],
              onPressed: (index) =>
                  setState(() => type = index == 0 ? 'income' : 'expense'),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Gelir'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Gider'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: financeCategories
                  .map(
                    (cat) => ChoiceChip(
                      label: Text(cat),
                      selected: category == cat,
                      onSelected: (_) => setState(() => category = cat),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'İşveren'),
              value: employerId,
              items: employers
                  .map(
                    (e) => DropdownMenuItem(value: e.id, child: Text(e.name)),
                  )
                  .toList(),
              onChanged: (value) => setState(() {
                employerId = value;
                projectId = null;
              }),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Proje'),
              value: projectId,
              items: filteredProjects
                  .map(
                    (p) => DropdownMenuItem(value: p.id, child: Text(p.title)),
                  )
                  .toList(),
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
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: txDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => txDate = picked);
                }
              },
              child: Text(
                'Tarih: ${txDate.toLocal().toString().split(' ').first}',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    employerId == null ||
                        projectId == null ||
                        amountController.text.isEmpty
                    ? null
                    : () async {
                        final amount =
                            (double.tryParse(
                                  amountController.text.replaceAll(',', '.'),
                                ) ??
                                0) *
                            100;
                        final model = IncomeExpenseModel(
                          employerId: employerId!,
                          projectId: projectId!,
                          type: type,
                          category: category,
                          amount: amount.toInt(),
                          description: noteController.text,
                          txDate: txDate,
                        );
                        await ref
                            .read(financeNotifierProvider.notifier)
                            .addTransaction(model);
                        await ref
                            .read(projectNotifierProvider.notifier)
                            .loadProjectDetail(projectId!);
                        await ref
                            .read(dashboardProvider.notifier)
                            .loadDashboard();
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
