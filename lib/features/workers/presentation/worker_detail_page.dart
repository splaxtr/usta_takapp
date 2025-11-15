import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/common_app_bar.dart';
import '../../projects/application/project_notifier.dart';
import '../application/worker_notifier.dart';
import '../application/worker_state.dart';
import 'add_workday_modal.dart';
import 'add_worker_payment_modal.dart';
import 'worker_widgets.dart';

class WorkerDetailPage extends ConsumerStatefulWidget {
  const WorkerDetailPage({super.key, required this.workerId});

  final int workerId;

  @override
  ConsumerState<WorkerDetailPage> createState() => _WorkerDetailPageState();
}

class _WorkerDetailPageState extends ConsumerState<WorkerDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(workerNotifierProvider.notifier)
          .loadWorkerDetail(widget.workerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workerNotifierProvider);
    final projectState = ref.watch(projectNotifierProvider);
    final worker = state.selectedWorker;

    if (state.loading && worker == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (state.error != null) {
      return Scaffold(body: Center(child: Text(state.error!)));
    }
    if (worker == null) {
      return const Scaffold(body: Center(child: Text('Çalışan bulunamadı')));
    }

    String projectNameFor(int projectId) {
      final match = projectState.projects
          .where((p) => p.id == projectId)
          .toList();
      return match.isNotEmpty ? match.first.title : 'Proje';
    }

    return Scaffold(
      appBar: CommonAppBar(title: worker.fullName),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WorkerSummaryCard(state: state),
              const SizedBox(height: 24),
              Text(
                'Çalışma Günleri',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (state.assignments.isEmpty)
                const Text('Henüz kayıt yok')
              else
                ...state.assignments.map(
                  (a) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AssignmentTile(
                      assignment: a,
                      projectName: projectNameFor(a.projectId),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => AddWorkdayModal(workerId: worker.id!),
                ),
                icon: const Icon(Icons.calendar_today),
                label: const Text('Gün Ekle'),
              ),
              const SizedBox(height: 24),
              Text('Ödemeler', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              if (state.payments.isEmpty)
                const Text('Ödeme kaydı yok')
              else
                ...state.payments.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: WorkerPaymentTile(payment: p),
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => AddWorkerPaymentModal(workerId: worker.id!),
                ),
                icon: const Icon(Icons.payments),
                label: const Text('Ödeme Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkerSummaryCard extends StatelessWidget {
  const _WorkerSummaryCard({required this.state});

  final WorkerState state;

  @override
  Widget build(BuildContext context) {
    final remainingColor = state.remainingAmount > 0
        ? Colors.redAccent
        : Colors.greenAccent;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Toplam Gün: ${state.totalWorkedDays}'),
          Text(
            'Toplam Hakediş: ${(state.totalWorkedAmount / 100).toStringAsFixed(2)} ₺',
          ),
          Text('Ödenen: ${(state.totalPaidAmount / 100).toStringAsFixed(2)} ₺'),
          const SizedBox(height: 8),
          Text(
            'Kalan: ${(state.remainingAmount / 100).toStringAsFixed(2)} ₺',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: remainingColor),
          ),
        ],
      ),
    );
  }
}
