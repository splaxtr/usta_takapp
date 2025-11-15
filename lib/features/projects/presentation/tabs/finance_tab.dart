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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (items.isEmpty)
              const Text('Bu projede işlem yok')
            else
              ...items.map(
                (tx) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TransactionTile(
                    model: tx,
                    employerName: null,
                    projectName: project.title,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
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
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
