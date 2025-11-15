import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../employers/application/employer_notifier.dart';
import '../../projects/application/project_notifier.dart';
import '../application/finance_notifier.dart';
import '../presentation/finance_categories.dart';
import 'add_transaction_modal.dart';
import 'widgets.dart';

class TransactionListPage extends ConsumerStatefulWidget {
  const TransactionListPage({super.key});

  @override
  ConsumerState<TransactionListPage> createState() =>
      _TransactionListPageState();
}

class _TransactionListPageState extends ConsumerState<TransactionListPage> {
  String filter = 'all';
  String? category;
  DateTimeRange? range;

  @override
  Widget build(BuildContext context) {
    final financeState = ref.watch(financeNotifierProvider);
    final employerState = ref.watch(employerNotifierProvider);
    final projectState = ref.watch(projectNotifierProvider);

    Future<void> loadFilter(String mode) async {
      final notifier = ref.read(financeNotifierProvider.notifier);
      switch (mode) {
        case 'income':
          await notifier.loadIncome();
          break;
        case 'expense':
          await notifier.loadExpense();
          break;
        default:
          await notifier.loadAll();
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Gelir & Gider')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Tümü'),
                      selected: filter == 'all',
                      onSelected: (_) {
                        setState(() => filter = 'all');
                        loadFilter('all');
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Gelir'),
                      selected: filter == 'income',
                      onSelected: (_) {
                        setState(() => filter = 'income');
                        loadFilter('income');
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Gider'),
                      selected: filter == 'expense',
                      onSelected: (_) {
                        setState(() => filter = 'expense');
                        loadFilter('expense');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  value: category,
                  decoration: const InputDecoration(labelText: 'Kategori'),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Tümü'),
                    ),
                    ...financeCategories.map(
                      (e) =>
                          DropdownMenuItem<String?>(value: e, child: Text(e)),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => category = value);
                    if (value == null) {
                      ref.read(financeNotifierProvider.notifier).loadAll();
                    } else {
                      ref
                          .read(financeNotifierProvider.notifier)
                          .loadByCategory(value);
                    }
                  },
                ),
                const SizedBox(height: 12),
                DateFilterBar(
                  range: range,
                  onPick: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => range = picked);
                      ref
                          .read(financeNotifierProvider.notifier)
                          .loadByDateRange(picked);
                    }
                  },
                  onClear: () {
                    if (range != null) {
                      setState(() => range = null);
                      ref.read(financeNotifierProvider.notifier).loadAll();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (financeState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (financeState.error != null) {
                  return Center(child: Text(financeState.error!));
                }
                if (financeState.transactions.isEmpty) {
                  return const Center(child: Text('İşlem bulunmuyor'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: financeState.transactions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, index) {
                    final tx = financeState.transactions[index];
                    final employerName = employerState.employers
                        .firstWhere(
                          (e) => e.id == tx.employerId,
                          orElse: () => employerState.employers.isNotEmpty
                              ? employerState.employers.first
                              : null,
                        )
                        ?.name;
                    final projectName = projectState.projects
                        .firstWhere(
                          (p) => p.id == tx.projectId,
                          orElse: () => null,
                        )
                        ?.title;
                    return TransactionTile(
                      model: tx,
                      employerName: employerName,
                      projectName: projectName,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => const AddTransactionModal(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
