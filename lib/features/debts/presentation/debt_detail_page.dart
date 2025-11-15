import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../employers/application/employer_notifier.dart';
import '../../projects/application/project_notifier.dart';
import '../application/debt_notifier.dart';
import '../domain/debt.dart';
import 'add_debt_payment_modal.dart';
import 'widgets.dart';

class DebtDetailPage extends ConsumerStatefulWidget {
  const DebtDetailPage({super.key, required this.debtId});

  final int debtId;

  @override
  ConsumerState<DebtDetailPage> createState() => _DebtDetailPageState();
}

class _DebtDetailPageState extends ConsumerState<DebtDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          ref.read(debtNotifierProvider.notifier).loadDebtDetail(widget.debtId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(debtNotifierProvider);
    final employerState = ref.watch(employerNotifierProvider);
    final projectState = ref.watch(projectNotifierProvider);
    final debt = state.selectedDebt;

    if (state.loading && debt == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.error != null) {
      return Scaffold(body: Center(child: Text(state.error!)));
    }

    if (debt == null) {
      return const Scaffold(body: Center(child: Text('Borç bulunamadı')));
    }

    final employerMatch = employerState.employers
        .where((e) => e.id == debt.employerId)
        .toList();
    final employerName = employerMatch.isNotEmpty
        ? employerMatch.first.name
        : 'İşveren';
    final projectMatch = projectState.projects
        .where((p) => p.id == debt.projectId)
        .toList();
    final projectName = projectMatch.isNotEmpty
        ? projectMatch.first.title
        : null;
    final paidAmount = debt.amount - state.remainingAmount;

    return Scaffold(
      appBar: AppBar(title: const Text('Borç Detayı')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DebtSummaryCard(
                employerName: employerName,
                projectName: projectName,
                debt: debt,
                paidAmount: paidAmount,
                remainingAmount: state.remainingAmount,
              ),
              const SizedBox(height: 24),
              Text('Ödemeler', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              if (state.payments.isEmpty)
                const Text('Ödeme kaydı bulunmuyor')
              else
                ...state.payments.map(
                  (payment) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DebtPaymentTile(payment: payment),
                  ),
                ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => AddDebtPaymentModal(debtId: debt.id!),
                      ),
                      child: const Text('Kısmi Ödeme Ekle'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: state.remainingAmount == 0
                          ? () => ref
                                .read(debtNotifierProvider.notifier)
                                .closeDebtIfFullyPaid(debt.id!)
                          : null,
                      child: const Text('Borcu Kapat'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DebtSummaryCard extends StatelessWidget {
  const _DebtSummaryCard({
    required this.employerName,
    required this.projectName,
    required this.debt,
    required this.paidAmount,
    required this.remainingAmount,
  });

  final String employerName;
  final String? projectName;
  final Debt debt;
  final int paidAmount;
  final int remainingAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employerName, style: Theme.of(context).textTheme.titleLarge),
          if (projectName != null) Text('Proje: $projectName'),
          const SizedBox(height: 8),
          Text('Toplam: ${(debt.amount / 100).toStringAsFixed(2)} ₺'),
          Text('Ödenen: ${(paidAmount / 100).toStringAsFixed(2)} ₺'),
          Text('Kalan: ${(remainingAmount / 100).toStringAsFixed(2)} ₺'),
          Text('Vade: ${debt.dueDate.toLocal().toString().split(' ').first}'),
          const SizedBox(height: 8),
          Row(
            children: [
              StatusBadge(status: debt.status),
              const SizedBox(width: 12),
              DueBadge(days: debt.dueDate.difference(DateTime.now()).inDays),
            ],
          ),
        ],
      ),
    );
  }
}
