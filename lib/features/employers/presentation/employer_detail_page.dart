import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/router/route_args.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/section_scaffold.dart';
import '../../debts/domain/debt.dart';
import '../../projects/domain/project.dart';
import '../application/employer_notifier.dart';
import '../domain/employer.dart';
import 'widgets.dart';

class EmployerDetailPage extends ConsumerStatefulWidget {
  const EmployerDetailPage({super.key, required this.args});

  final EmployerDetailArgs args;

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
          .loadEmployerDetail(widget.args.employerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(employerNotifierProvider);
    final employer = state.selectedEmployer;
    return Scaffold(
      appBar: CommonAppBar(title: employer?.name ?? 'İşveren Detayı'),
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
                      child: SectionScaffold(
                        tabs: const [
                          Tab(text: 'Projeler'),
                          Tab(text: 'Borçlar'),
                          Tab(text: 'İletişim'),
                        ],
                        children: [
                          EmployerProjectsSection(projects: state.projects),
                          EmployerDebtsSection(debts: state.debts),
                          EmployerContactSection(employer: employer),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}

class EmployerProjectsSection extends StatelessWidget {
  const EmployerProjectsSection({required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (projects.isEmpty)
              const Text('Bu işverene ait proje yok')
            else
              ...projects.map(
                (project) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: EmployerProjectTile(
                    project: project,
                    onTap: project.id == null
                        ? null
                        : () => Navigator.pushNamed(
                              context,
                              '/project/detail',
                              arguments: ProjectDetailArgs(
                                projectId: project.id!,
                              ),
                            ),
                  ),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class EmployerDebtsSection extends StatelessWidget {
  const EmployerDebtsSection({required this.debts});

  final List<Debt> debts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (debts.isEmpty)
              const Text('Borç kaydı bulunmuyor')
            else
              ...debts.map(
                (debt) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: EmployerDebtTile(
                    debt: debt,
                    onTap: debt.id == null
                        ? null
                        : () => Navigator.pushNamed(
                              context,
                              '/debt/detail',
                              arguments: DebtDetailArgs(
                                debtId: debt.id!,
                              ),
                            ),
                  ),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class EmployerContactSection extends StatelessWidget {
  const EmployerContactSection({required this.employer});

  final Employer? employer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (employer == null)
              const Text('İşveren bulunamadı')
            else ...[
              Text('Telefon: ${employer!.contact ?? '-'}'),
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
                child: Text(employer!.note ?? 'Not bulunmuyor'),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
