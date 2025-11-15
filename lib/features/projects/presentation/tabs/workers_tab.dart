import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../workers/domain/worker.dart';
import '../../application/project_notifier.dart';
import '../../domain/project_metrics.dart';

class ProjectWorkersTab extends ConsumerWidget {
  const ProjectWorkersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectNotifierProvider);
    final workers = state.workers;
    final stats = state.workerStats;

    if (workers.isEmpty) {
      return const Center(child: Text('Çalışan kaydı yok'));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) => WorkerTile(
              worker: workers[index],
              stats: stats[workers[index].id ?? -1],
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: workers.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () {
              // Gün ekleme modalı ileride eklenecek
            },
            icon: const Icon(Icons.calendar_today),
            label: const Text('Gün Ekle'),
          ),
        ),
      ],
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.03),
      ),
      child: Row(
        children: [
          CircleAvatar(child: Text(worker.fullName.characters.first)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker.fullName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Günlük Ücret: ${(worker.dailyRate / 100).toStringAsFixed(2)} ₺',
                ),
                Text('Toplam Gün: $totalDays'),
              ],
            ),
          ),
          Text('${(totalCost / 100).toStringAsFixed(2)} ₺'),
        ],
      ),
    );
  }
}
