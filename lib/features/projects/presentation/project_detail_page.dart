import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/common_app_bar.dart';
import '../application/project_notifier.dart';
import 'tabs/debt_tab.dart';
import 'tabs/finance_tab.dart';
import 'tabs/payments_tab.dart';
import 'tabs/summary_tab.dart';
import 'tabs/workers_tab.dart';

class ProjectDetailPage extends ConsumerStatefulWidget {
  const ProjectDetailPage({super.key, required this.projectId});

  final int projectId;

  @override
  ConsumerState<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends ConsumerState<ProjectDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(projectNotifierProvider.notifier)
          .loadProjectDetail(widget.projectId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(projectNotifierProvider);
    final project = state.selectedProject;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CommonAppBar(
          title: project?.title ?? 'Proje Detayı',
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Özet'),
              Tab(text: 'Finans'),
              Tab(text: 'Borçlar'),
              Tab(text: 'Çalışanlar'),
              Tab(text: 'Ödemeler'),
            ],
          ),
        ),
        body: state.loading && project == null
            ? const Center(child: CircularProgressIndicator())
            : state.error != null
            ? Center(child: Text(state.error!))
            : Column(
                children: [
                  ProjectHeader(
                    projectName: project?.title ?? '',
                    status: project?.status ?? '-',
                    employerId: project?.employerId ?? 0,
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ProjectSummaryTab(projectId: widget.projectId),
                        ProjectFinanceTab(projectId: widget.projectId),
                        ProjectDebtTab(projectId: widget.projectId),
                        ProjectWorkersTab(projectId: widget.projectId),
                        ProjectPaymentsTab(projectId: widget.projectId),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ProjectHeader extends StatelessWidget {
  const ProjectHeader({
    super.key,
    required this.projectName,
    required this.status,
    required this.employerId,
  });

  final String projectName;
  final String status;
  final int employerId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white.withOpacity(0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(projectName, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(label: Text(status)),
              const SizedBox(width: 12),
              Text('İşveren ID: $employerId'),
            ],
          ),
        ],
      ),
    );
  }
}
