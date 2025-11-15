import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../employers/application/employer_notifier.dart';
import '../../projects/application/project_notifier.dart';
import '../application/debt_notifier.dart';
import '../domain/debt.dart';
import 'add_debt_modal.dart';
import 'debt_detail_page.dart';
import 'widgets.dart';

class DebtListPage extends ConsumerStatefulWidget {
  const DebtListPage({super.key});

  @override
  ConsumerState<DebtListPage> createState() => _DebtListPageState();
}

class _DebtListPageState extends ConsumerState<DebtListPage> {
  String filter = 'all';

  @override
  Widget build(BuildContext context) {
    final debtState = ref.watch(debtNotifierProvider);
    final employerState = ref.watch(employerNotifierProvider);
    final projectState = ref.watch(projectNotifierProvider);

    final displayedDebts = debtState.debts.where((debt) {
      switch (filter) {
        case 'pending':
          return debt.status == 'pending' || debt.status == 'partial';
        case 'paid':
          return debt.status == 'paid';
        default:
          return true;
      }
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Borçlar')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Tümü'),
                  selected: filter == 'all',
                  onSelected: (_) => setState(() => filter = 'all'),
                ),
                ChoiceChip(
                  label: const Text('Bekleyen'),
                  selected: filter == 'pending',
                  onSelected: (_) => setState(() => filter = 'pending'),
                ),
                ChoiceChip(
                  label: const Text('Ödenmiş'),
                  selected: filter == 'paid',
                  onSelected: (_) => setState(() => filter = 'paid'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (debtState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (debtState.error != null) {
                  return Center(child: Text(debtState.error!));
                }
                if (displayedDebts.isEmpty) {
                  return const Center(child: Text('Borç kaydı yok'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: displayedDebts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, index) {
                    final debt = displayedDebts[index];
                    final employerMatch = employerState.employers
                        .where((e) => e.id == debt.employerId)
                        .toList();
                    final employerName = employerMatch.isNotEmpty
                        ? employerMatch.first.name
                        : 'İşveren';
                    final projectMatch = projectState.projects
                        .where((p) => p.id == debt.projectId)
                        .toList();
                    final projectName = projectMatch.isNotEmpty
                        ? projectMatch.first.title
                        : null;
                    return DebtTile(
                      debt: debt,
                      employerName: employerName,
                      projectName: projectName,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DebtDetailPage(debtId: debt.id!),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddDebtModal(),
          );
        },
        child: const Icon(Icons.add_alert),
      ),
    );
  }
}
