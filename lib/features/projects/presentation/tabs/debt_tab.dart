import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_card.dart';
import '../../../debts/domain/debt.dart';
import '../../application/project_notifier.dart';

class ProjectDebtTab extends ConsumerWidget {
  const ProjectDebtTab({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectNotifierProvider);
    final debts = state.debts;
    final project = state.selectedProject;
    if (project == null || project.id != projectId) {
      return const Center(child: CircularProgressIndicator());
    }
    if (debts.isEmpty) {
      return const Center(child: Text('Bu projeye ait borç bulunmuyor'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, index) => DebtTile(debt: debts[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: debts.length,
    );
  }
}

class DebtTile extends StatelessWidget {
  const DebtTile({super.key, required this.debt});

  final Debt debt;

  @override
  Widget build(BuildContext context) {
    final remaining = debt.dueDate.difference(DateTime.now()).inDays;
    final dueString = debt.dueDate.toLocal().toString().split(' ').first;
    return AppCard(
      child: Row(
        children: [
          const Icon(Icons.attach_money),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${(debt.amount / 100).toStringAsFixed(2)} ₺',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text('Vade: $dueString'),
                Text('Durum: ${debt.status}'),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$remaining gün',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: debt.id == null
                    ? null
                    : () => Navigator.pushNamed(
                        context,
                        '/debt/detail',
                        arguments: debt.id,
                      ),
                icon: const Icon(Icons.open_in_new),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
