import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../finance/application/finance_notifier.dart';
import '../../../finance/presentation/add_transaction_modal.dart';
import '../../../finance/presentation/widgets.dart';
import '../../application/project_notifier.dart';

class ProjectFinanceTab extends ConsumerStatefulWidget {
  const ProjectFinanceTab({super.key, required this.projectId});

  final int projectId;

  @override
  ConsumerState<ProjectFinanceTab> createState() => _ProjectFinanceTabState();
}

class _ProjectFinanceTabState extends ConsumerState<ProjectFinanceTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(financeNotifierProvider.notifier)
          .loadByProject(widget.projectId),
    );
  }

  @override
  void didUpdateWidget(covariant ProjectFinanceTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.projectId != widget.projectId) {
      Future.microtask(
        () => ref
            .read(financeNotifierProvider.notifier)
            .loadByProject(widget.projectId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectNotifierProvider);
    final financeState = ref.watch(financeNotifierProvider);
    final project = projectState.selectedProject;
    if (project == null || project.id != widget.projectId) {
      return const Center(child: Text('Proje seçilmedi'));
    }

    if (financeState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final items = financeState.transactions;
    return Column(
      children: [
        Expanded(
          child: items.isEmpty
              ? const Center(child: Text('Bu projede işlem yok'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, index) => TransactionTile(
                    model: items[index],
                    employerName: null,
                    projectName: project.title,
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => AddTransactionModal(
                initialProjectId: project.id,
                initialEmployerId: project.employerId,
              ),
            ),
            icon: const Icon(Icons.add),
            label: const Text('İşlem Ekle'),
          ),
        ),
      ],
    );
  }
}
