import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/route_args.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../application/worker_notifier.dart';
import '../domain/worker.dart';
import 'worker_widgets.dart';

class WorkerListPage extends ConsumerStatefulWidget {
  const WorkerListPage({super.key});

  @override
  ConsumerState<WorkerListPage> createState() => _WorkerListPageState();
}

class _WorkerListPageState extends ConsumerState<WorkerListPage> {
  String filter = 'all';
  String query = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workerNotifierProvider);
    List<WorkerModel> workers = state.workers;
    if (filter == 'active') {
      workers = workers.where((w) => w.active).toList();
    } else if (filter == 'inactive') {
      workers = workers.where((w) => !w.active).toList();
    }
    if (query.isNotEmpty) {
      workers = workers
          .where((w) => w.fullName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    return Scaffold(
      appBar: const CommonAppBar(title: 'Çalışanlar'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Çalışan ara',
                  ),
                  onChanged: (value) => setState(() => query = value),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Hepsi'),
                      selected: filter == 'all',
                      onSelected: (_) => setState(() => filter = 'all'),
                    ),
                    ChoiceChip(
                      label: const Text('Aktif'),
                      selected: filter == 'active',
                      onSelected: (_) => setState(() => filter = 'active'),
                    ),
                    ChoiceChip(
                      label: const Text('Pasif'),
                      selected: filter == 'inactive',
                      onSelected: (_) => setState(() => filter = 'inactive'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (state.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.error != null) {
                  return Center(child: Text(state.error!));
                }
                if (workers.isEmpty) {
                  return const Center(child: Text('Çalışan bulunamadı'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: workers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, index) {
                    final worker = workers[index];
                    return WorkerTile(
                      worker: worker,
                      onTap: () {
                        if (worker.id == null) return;
                        Navigator.pushNamed(
                          context,
                          '/worker/detail',
                          arguments: WorkerDetailArgs(workerId: worker.id!),
                        );
                      },
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
          Navigator.pushNamed(context, '/worker/form');
        },
        child: const Icon(Icons.person_add_alt),
      ),
    );
  }
}
