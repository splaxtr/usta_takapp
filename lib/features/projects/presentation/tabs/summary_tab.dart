import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/project_notifier.dart';

class ProjectSummaryTab extends ConsumerWidget {
  const ProjectSummaryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectNotifierProvider);
    final project = state.selectedProject;
    if (project == null) {
      return const Center(child: Text('Proje seçili değil'));
    }

    final budget = project.budget.toDouble();
    final spent = state.expenseTotal.toDouble();
    final progress = budget == 0 ? 0.0 : (spent / budget).clamp(0, 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SummaryStatCard(
                label: 'Gelir',
                amount: state.incomeTotal,
                color: Colors.greenAccent,
              ),
              SummaryStatCard(
                label: 'Gider',
                amount: state.expenseTotal,
                color: Colors.redAccent,
              ),
              SummaryStatCard(
                label: 'Net',
                amount: state.netBalance,
                color: Colors.blueAccent,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Bütçe Kullanımı',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor: Colors.white12,
            color: Colors.orangeAccent,
          ),
          const SizedBox(height: 8),
          Text(
            'Harcanan: ${(spent / 100).toStringAsFixed(2)} ₺ / ${(budget / 100).toStringAsFixed(2)} ₺',
          ),
          const SizedBox(height: 24),
          Text(
            'Son Güncellemeler',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.04),
            ),
            child: const Text('Zaman çizelgesi gelecek görevlerde eklenecek.'),
          ),
        ],
      ),
    );
  }
}

class SummaryStatCard extends StatelessWidget {
  const SummaryStatCard({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final int amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(
              '${(amount / 100).toStringAsFixed(2)} ₺',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
