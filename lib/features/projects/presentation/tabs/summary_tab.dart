import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/project_notifier.dart';
import '../../domain/project_summary.dart';

class ProjectSummaryTab extends ConsumerWidget {
  const ProjectSummaryTab({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectNotifierProvider);
    final project = state.selectedProject;
    if (project == null || project.id != projectId) {
      return const Center(child: Text('Proje seçili değil'));
    }

    final summary = state.summary ?? state.projectSummaries[projectId];
    if (summary == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final budget = project.budget.toDouble();
    final spent = summary.totalCost.toDouble();
    final progress = budget == 0 ? 0.0 : (spent / budget).clamp(0, 1);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatsGrid(summary: summary),
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
          if (budget > 0)
            Text(
              'Harcanan: ${(spent / 100).toStringAsFixed(2)} ₺ / ${(budget / 100).toStringAsFixed(2)} ₺',
            )
          else
            const Text('Bütçe tanımlı değil'),
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
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.summary});

  final ProjectSummary summary;

  @override
  Widget build(BuildContext context) {
    final cards = [
      ('Toplam Gelir', summary.income, Colors.greenAccent),
      ('Toplam Gider', summary.expense, Colors.redAccent),
      ('Çalışan Maliyeti', summary.workerCost, Colors.orangeAccent),
      ('Hakediş Ödemeleri', summary.payrollPaid, Colors.blueGrey),
      ('Toplam Borç', summary.debt, Colors.purpleAccent),
      ('Net Kâr', summary.net, Colors.blueAccent),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 500;
        final itemWidth =
            isNarrow ? constraints.maxWidth : (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards
              .map(
                (card) => SizedBox(
                  width: itemWidth,
                  child: SummaryStatCard(
                    label: card.$1,
                    amount: card.$2,
                    color: card.$3,
                  ),
                ),
              )
              .toList(),
        );
      },
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
    return Container(
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
    );
  }
}
