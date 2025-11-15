import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/route_args.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../finance/presentation/add_transaction_modal.dart';
import '../../debts/domain/debt.dart';
import '../../projects/domain/project.dart';
import '../application/dashboard_notifier.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: CommonAppBar(
        title: 'Dashboard',
        actions: [
          PopupMenuButton<String>(
            onSelected: (route) {
              Navigator.pushNamed(context, route);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: '/projects', child: Text('Projeler')),
              PopupMenuItem(value: '/employers', child: Text('İşverenler')),
              PopupMenuItem(value: '/debts', child: Text('Borçlar')),
              PopupMenuItem(value: '/workers', child: Text('Çalışanlar')),
              PopupMenuItem(value: '/finance', child: Text('Finans')),
              PopupMenuItem(
                value: '/reports/weekly',
                child: Text('Haftalık Rapor'),
              ),
            ],
          ),
        ],
      ),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            StatCard(
                              title: 'Toplam Gelir',
                              amount: state.totalIncome,
                              color: Colors.green,
                            ),
                            StatCard(
                              title: 'Toplam Gider',
                              amount: state.totalExpense,
                              color: Colors.red,
                            ),
                            StatCard(
                              title: 'Net Bakiye',
                              amount: state.totalIncome - state.totalExpense,
                              color: Colors.blue,
                            ),
                            StatCard(
                              title: 'Toplam Borç',
                              amount: state.totalDebt,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Aktif Projeler',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 140,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              final project = state.activeProjects[index];
                              return ProjectMiniCard(
                                project: project,
                                onTap: project.id == null
                                    ? null
                                    : () => Navigator.pushNamed(
                                          context,
                                          '/project/detail',
                                          arguments: ProjectDetailArgs(
                                            projectId: project.id!,
                                          ),
                                        ),
                              );
                            },
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemCount: state.activeProjects.length,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Yaklaşan Vadeler',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: state.upcomingDebts
                              .map(
                                (d) => UpcomingDebtTile(
                                  debt: d,
                                  onTap: d.id == null
                                      ? null
                                      : () => Navigator.pushNamed(
                                            context,
                                            '/debt/detail',
                                            arguments: DebtDetailArgs(
                                              debtId: d.id!,
                                            ),
                                          ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTransactionModal(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  final String title;
  final int amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Text(
            '${amount / 100} ₺',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}

class ProjectMiniCard extends StatelessWidget {
  const ProjectMiniCard({super.key, required this.project, this.onTap});

  final Project project;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 220,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text('Durum: ${project.status}'),
              const Spacer(),
              Text('Bütçe: ${(project.budget / 100).toStringAsFixed(2)} ₺'),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingDebtTile extends StatelessWidget {
  const UpcomingDebtTile({super.key, required this.debt, this.onTap});

  final Debt debt;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final remainingDays = debt.dueDate.difference(DateTime.now()).inDays;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(debt.amount / 100).toStringAsFixed(2)} ₺',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Vade: ${debt.dueDate.toLocal().toString().split(' ').first}',
                    ),
                  ],
                ),
              ),
              Chip(
                label: Text('$remainingDays gün'),
                backgroundColor:
                    remainingDays <= 2 ? Colors.redAccent : Colors.orangeAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
