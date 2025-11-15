import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_tile.dart';
import '../../debts/domain/debt.dart';
import '../../projects/domain/project.dart';
import '../domain/employer.dart';

class DebtBadge extends StatelessWidget {
  const DebtBadge({super.key, required this.amount});

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: amount > 0
            ? Colors.redAccent.withOpacity(0.2)
            : Colors.green.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('${(amount / 100).toStringAsFixed(2)} ₺'),
    );
  }
}

class EmployerHeaderCard extends StatelessWidget {
  const EmployerHeaderCard({
    super.key,
    required this.employer,
    required this.totalDebt,
  });

  final Employer employer;
  final int totalDebt;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.business),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  employer.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(employer.contact ?? 'İletişim bilgisi yok'),
          const SizedBox(height: 8),
          Text('Toplam Borç: ${(totalDebt / 100).toStringAsFixed(2)} ₺'),
        ],
      ),
    );
  }
}

class EmployerProjectTile extends StatelessWidget {
  const EmployerProjectTile({super.key, required this.project, this.onTap});

  final Project project;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspaces_outline),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  project.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Chip(label: Text(project.status)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Başlangıç: ${project.startDate.toLocal().toString().split(' ').first}',
          ),
          if (project.endDate != null)
            Text(
              'Bitiş: ${project.endDate!.toLocal().toString().split(' ').first}',
            ),
        ],
      ),
    );
  }
}

class EmployerDebtTile extends StatelessWidget {
  const EmployerDebtTile({super.key, required this.debt, this.onTap});

  final Debt debt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final remaining = debt.dueDate.difference(DateTime.now()).inDays;
    final badgeColor = remaining <= 3
        ? Colors.orangeAccent
        : remaining <= 7
            ? Colors.blueAccent
            : Colors.grey;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.attach_money),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${(debt.amount / 100).toStringAsFixed(2)} ₺',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Chip(label: Text(debt.status.label)),
            ],
          ),
          const SizedBox(height: 8),
          Text('Vade: ${debt.dueDate.toLocal().toString().split(' ').first}'),
          Text('Durum: ${debt.status.label}'),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('$remaining gün'),
              ),
              TextButton(onPressed: onTap, child: const Text('Detaya git')),
            ],
          ),
        ],
      ),
    );
  }
}

class EmployerListTile extends StatelessWidget {
  const EmployerListTile({
    super.key,
    required this.employer,
    required this.projectCount,
    required this.debtAmount,
    required this.onTap,
  });

  final Employer employer;
  final int projectCount;
  final int debtAmount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppTile(
      onTap: onTap,
      leading: const Icon(Icons.business),
      title: employer.name,
      subtitle: 'Toplam Proje: $projectCount',
      trailing: DebtBadge(amount: debtAmount),
    );
  }
}
