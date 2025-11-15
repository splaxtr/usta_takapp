import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_tile.dart';
import '../../../workers/domain/worker.dart';
import '../../application/project_notifier.dart';
import '../../domain/project_metrics.dart';

class ProjectWorkersTab extends ConsumerWidget {
  const ProjectWorkersTab({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectNotifierProvider);
    final project = state.selectedProject;
    if (project == null || project.id != projectId) {
      return const Center(child: CircularProgressIndicator());
    }
    final workers = state.workers;
    final stats = state.workerStats;

    if (workers.isEmpty) {
      return const Center(child: Text('Çalışan kaydı yok'));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (workers.isEmpty)
              const Text('Çalışan kaydı yok')
            else
              ...workers.map(
                (worker) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: WorkerTile(
                    worker: worker,
                    stats: stats[worker.id ?? -1],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Çalışan gün ekleme çalışan modülünden yapılabilir.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text('Gün Ekle'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class WorkerTile extends StatelessWidget {
  const WorkerTile({super.key, required this.worker, this.stats});

  final WorkerModel worker;
  final WorkerProjectStats? stats;

  @override
  Widget build(BuildContext context) {
    final totalDays = stats?.totalDays ?? 0;
    final totalCost = stats?.totalCost ?? 0;
    final subtitle =
        'Günlük Ücret: ${(worker.dailyRate / 100).toStringAsFixed(2)} ₺ • Gün: $totalDays';
    return AppTile(
      leading: const Icon(Icons.person),
      title: worker.fullName,
      subtitle: subtitle,
      trailing: Text('${(totalCost / 100).toStringAsFixed(2)} ₺'),
    );
  }
}
