import 'package:flutter/material.dart';

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employer.name, style: Theme.of(context).textTheme.headlineSmall),
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
  const EmployerProjectTile({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                project.title,
                style: Theme.of(context).textTheme.titleMedium,
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: remaining <= 3 ? Colors.redAccent : Colors.orangeAccent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${(debt.amount / 100).toStringAsFixed(2)} ₺',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text('Vade: ${debt.dueDate.toLocal().toString().split(' ').first}'),
          Text('Durum: ${debt.status}'),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onTap,
              child: const Text('Detaya git'),
            ),
          ),
        ],
      ),
    );
  }
}
