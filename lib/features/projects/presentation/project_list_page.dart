import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/router/route_args.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../application/project_notifier.dart';
import '../domain/project.dart';
import '../domain/project_summary.dart';

class ProjectListPage extends ConsumerWidget {
  const ProjectListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectNotifierProvider);

    return Scaffold(
      appBar: CommonAppBar(
        title: 'Projeler',
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text(state.error!))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (_, index) {
                    final project = state.projects[index];
                    final summary = project.id != null
                        ? state.projectSummaries[project.id!]
                        : null;
                    return ProjectCard(
                      project: project,
                      summary: summary,
                      onTap: () {
                        if (project.id == null) return;
                        if (project.id == null) return;
                        Navigator.pushNamed(
                          context,
                          '/project/detail',
                          arguments: ProjectDetailArgs(projectId: project.id!),
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemCount: state.projects.length,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/project/form');
        },
        child: const Icon(Icons.add_box),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.summary,
    required this.onTap,
  });

  final Project project;
  final ProjectSummary? summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final incomeText =
        summary != null ? (summary!.income / 100).toStringAsFixed(2) : '-';
    final expenseText =
        summary != null ? (summary!.expense / 100).toStringAsFixed(2) : '-';
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
          const SizedBox(height: 8),
          Text(
            'Başlangıç: ${project.startDate.toLocal().toString().split(' ').first}',
          ),
          if (project.endDate != null)
            Text(
              'Bitiş: ${project.endDate!.toLocal().toString().split(' ').first}',
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: Text('Gelir: $incomeText ₺')),
              Expanded(child: Text('Gider: $expenseText ₺')),
            ],
          ),
        ],
      ),
    );
  }
}
