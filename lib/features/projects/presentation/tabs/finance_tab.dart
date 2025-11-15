import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/project_notifier.dart';
import '../../../finance/domain/income_expense.dart';

class ProjectFinanceTab extends ConsumerWidget {
  const ProjectFinanceTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectNotifierProvider);
    final items = state.transactions;

    if (items.isEmpty) {
      return const Center(child: Text('Bu projeye ait işlem bulunmuyor'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) => FinanceTile(model: items[index]),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: items.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: bağlanacak modal görevleri ileride yapılacak
            },
            icon: const Icon(Icons.add),
            label: const Text('İşlem Ekle'),
          ),
        ),
      ],
    );
  }
}

class FinanceTile extends StatelessWidget {
  const FinanceTile({super.key, required this.model});

  final IncomeExpenseModel model;

  @override
  Widget build(BuildContext context) {
    final isIncome = model.type == 'income';
    final color = isIncome ? Colors.greenAccent : Colors.redAccent;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.03),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.category,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(model.txDate.toLocal().toString().split(' ').first),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}${(model.amount / 100).toStringAsFixed(2)} ₺',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
