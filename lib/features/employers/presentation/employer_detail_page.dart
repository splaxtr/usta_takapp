import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/common_app_bar.dart';
import '../application/employer_notifier.dart';
import '../domain/employer.dart';
import '../../projects/domain/project.dart';
import '../../debts/domain/debt.dart';
import 'widgets.dart';

class EmployerDetailPage extends ConsumerStatefulWidget {
  const EmployerDetailPage({super.key, required this.employerId});

  final int employerId;

  @override
  ConsumerState<EmployerDetailPage> createState() => _EmployerDetailPageState();
}

class _EmployerDetailPageState extends ConsumerState<EmployerDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(employerNotifierProvider.notifier)
          .loadEmployerDetail(widget.employerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(employerNotifierProvider);
    final employer = state.selectedEmployer;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CommonAppBar(
          title: employer?.name ?? 'İşveren Detayı',
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Projeler'),
              Tab(text: 'Borçlar'),
              Tab(text: 'İletişim'),
            ],
          ),
        ),
        body: state.loading && employer == null
            ? const Center(child: CircularProgressIndicator())
            : state.error != null
            ? Center(child: Text(state.error!))
            : Column(
                children: [
                  if (employer != null)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: EmployerHeaderCard(
                        employer: employer,
                        totalDebt: state.totalDebt,
                      ),
                    ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _EmployerProjectsTab(projects: state.projects),
                        _EmployerDebtsTab(debts: state.debts),
                        _EmployerContactTab(employer: employer),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _EmployerProjectsTab extends StatelessWidget {
  const _EmployerProjectsTab({required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return const Center(child: Text('Bu işverene ait proje yok'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: projects.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) => EmployerProjectTile(
        project: projects[index],
        onTap: projects[index].id == null
            ? null
            : () => Navigator.pushNamed(
                context,
                '/project/detail',
                arguments: projects[index].id,
              ),
      ),
    );
  }
}

class _EmployerDebtsTab extends StatelessWidget {
  const _EmployerDebtsTab({required this.debts});

  final List<Debt> debts;

  @override
  Widget build(BuildContext context) {
    if (debts.isEmpty) {
      return const Center(child: Text('Borç kaydı bulunmuyor'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: debts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) => EmployerDebtTile(
        debt: debts[index],
        onTap: debts[index].id == null
            ? null
            : () => Navigator.pushNamed(
                context,
                '/debt/detail',
                arguments: debts[index].id,
              ),
      ),
    );
  }
}

class _EmployerContactTab extends StatelessWidget {
  const _EmployerContactTab({required this.employer});

  final Employer? employer;

  @override
  Widget build(BuildContext context) {
    if (employer == null) {
      return const Center(child: Text('İşveren bulunamadı'));
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Telefon: ${employer.contact ?? '-'}'),
          const SizedBox(height: 12),
          Text('Notlar:'),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.03),
            ),
            child: Text(employer.note ?? 'Not bulunmuyor'),
          ),
        ],
      ),
    );
  }
}
