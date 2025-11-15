import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/common_app_bar.dart';
import '../application/employer_notifier.dart';
import '../domain/employer.dart';
import 'widgets.dart';

class EmployerListPage extends ConsumerStatefulWidget {
  const EmployerListPage({super.key});

  @override
  ConsumerState<EmployerListPage> createState() => _EmployerListPageState();
}

class _EmployerListPageState extends ConsumerState<EmployerListPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(employerNotifierProvider);
    final employers = state.employers.where((employer) {
      if (_query.isEmpty) return true;
      return employer.name.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: const CommonAppBar(title: 'İşverenler'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'İşveren ara',
              ),
              onChanged: (value) => setState(() => _query = value),
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
                if (employers.isEmpty) {
                  return const Center(child: Text('İşveren bulunmuyor'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: employers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, index) {
                    final employer = employers[index];
                    final projectCount =
                        state.projectCounts[employer.id ?? -1] ?? 0;
                    final debtAmount = state.debtTotals[employer.id ?? -1] ?? 0;
                    return EmployerListTile(
                      employer: employer,
                      projectCount: projectCount,
                      debtAmount: debtAmount,
                      onTap: () {
                        if (employer.id == null) return;
                        Navigator.pushNamed(
                          context,
                          '/employer/detail',
                          arguments: employer.id,
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
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Yeni İşveren'),
              content: const Text(
                'Form entegrasyonu sonraki sprintte eklenecek.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kapat'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add_business),
      ),
    );
  }
}

class EmployerListTile extends StatelessWidget {
  const EmployerListTile({
    super.key,
    required this.employer,
    required this.projectCount,
    required this.debtAmount,
    required this.onTap,
  });

  final Employer employer;
  final int projectCount;
  final int debtAmount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.white.withOpacity(0.03),
      title: Text(employer.name),
      subtitle: Text('Toplam Proje: $projectCount'),
      trailing: DebtBadge(amount: debtAmount),
    );
  }
}
