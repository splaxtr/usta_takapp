import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_tile.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../debts/domain/debt.dart' as debt_model;
import '../../debts/domain/debt_payment.dart' as debt_payment_model;
import '../../finance/domain/income_expense.dart';
import '../../workers/domain/worker_assignment.dart';
import '../application/report_notifier.dart';
import '../application/report_state.dart';

class WeeklyReportPage extends ConsumerWidget {
  const WeeklyReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportNotifierProvider);
    final notifier = ref.read(reportNotifierProvider.notifier);

    if (state.loading && state.transactions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.error != null) {
      return Scaffold(body: Center(child: Text(state.error!)));
    }

    return Scaffold(
      appBar: const CommonAppBar(title: 'Haftalık Rapor'),
      body: RefreshIndicator(
        onRefresh: notifier.loadWeekData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeekPicker(
                start: state.weekStart,
                onPrevious: () => notifier.setWeek(
                  state.weekStart.subtract(const Duration(days: 7)),
                ),
                onNext: () => notifier.setWeek(
                  state.weekStart.add(const Duration(days: 7)),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ReportStatCard(
                    title: 'Gelir',
                    amount: state.income,
                    color: Colors.green,
                  ),
                  ReportStatCard(
                    title: 'Gider',
                    amount: state.expense,
                    color: Colors.redAccent,
                  ),
                  ReportStatCard(
                    title: 'Net',
                    amount: state.income - state.expense,
                    color: Colors.blueAccent,
                  ),
                  ReportStatCard(
                    title: 'Maaş',
                    amount: state.payroll,
                    color: Colors.orangeAccent,
                  ),
                  ReportStatCard(
                    title: 'Alınan Borç',
                    amount: state.debtTaken,
                    color: Colors.purpleAccent,
                  ),
                  ReportStatCard(
                    title: 'Ödenen Borç',
                    amount: state.debtPaid,
                    color: Colors.teal,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ReportSectionTitle(title: 'İşlemler'),
              if (state.transactions.isEmpty)
                const Text('İşlem yok')
              else
                ...state.transactions.map((tx) => TransactionTile(model: tx)),
              const SizedBox(height: 24),
              ReportSectionTitle(title: 'Çalışma Günleri'),
              if (state.assignments.isEmpty)
                const Text('Çalışma kaydı yok')
              else
                ...state.assignments.map((a) => AssignmentTile(model: a)),
              const SizedBox(height: 24),
              ReportSectionTitle(title: 'Borçlar'),
              if (state.debts.isEmpty)
                const Text('Borç kaydı yok')
              else
                ...state.debts.map((d) => DebtTile(model: d)),
              const SizedBox(height: 24),
              ReportSectionTitle(title: 'Borç Ödemeleri'),
              if (state.debtPayments.isEmpty)
                const Text('Borç ödemesi yok')
              else
                ...state.debtPayments.map((p) => DebtPaymentTile(model: p)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: state.loading
                          ? null
                          : () async {
                              final path = await notifier.generatePdf();
                              _showSnack(context, 'PDF oluşturuldu: $path');
                            },
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text('PDF Oluştur'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: state.loading
                          ? null
                          : () async {
                              final path = await notifier.generateExcel();
                              _showSnack(context, 'Excel oluşturuldu: $path');
                            },
                      icon: const Icon(Icons.table_chart),
                      label: const Text('Excel Oluştur'),
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

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class WeekPicker extends StatelessWidget {
  const WeekPicker({
    super.key,
    required this.start,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime start;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final end = start.add(const Duration(days: 6));
    return Row(
      children: [
        IconButton(onPressed: onPrevious, icon: const Icon(Icons.chevron_left)),
        Expanded(
          child: Column(
            children: [
              Text(
                '${_format(start)} - ${_format(end)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('Hafta ${start.weekday ~/ 7 + 1}'),
            ],
          ),
        ),
        IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }

  String _format(DateTime date) => date.toLocal().toString().split(' ').first;
}

class ReportStatCard extends StatelessWidget {
  const ReportStatCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  final String title;
  final int amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Text(
            '${(amount / 100).toStringAsFixed(2)} ₺',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class ReportSectionTitle extends StatelessWidget {
  const ReportSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.model});

  final IncomeExpenseModel model;

  @override
  Widget build(BuildContext context) {
    final isIncome = model.type == 'income';
    final color = isIncome ? Colors.greenAccent : Colors.redAccent;
    final subtitleLines = <String>[
      if (model.description != null && model.description!.isNotEmpty)
        model.description!,
      'Tarih: ${model.txDate.toLocal().toString().split(' ').first}',
    ];
    final subtitle = subtitleLines.isEmpty ? null : subtitleLines.join('\n');
    return AppTile(
      leading: Icon(Icons.bar_chart, color: color),
      title: '${model.category} • ${isIncome ? 'Gelir' : 'Gider'}',
      subtitle: subtitle,
      trailing: Text(
        '${isIncome ? '+' : '-'}${(model.amount / 100).toStringAsFixed(2)} ₺',
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AssignmentTile extends StatelessWidget {
  const AssignmentTile({super.key, required this.model});

  final WorkerAssignmentModel model;

  @override
  Widget build(BuildContext context) {
    return AppTile(
      leading: const Icon(Icons.bar_chart),
      title: 'Proje: ${model.projectId}',
      subtitle:
          'Gün/Saat: ${model.hours} • Tarih: ${model.workDate.toLocal().toString().split(' ').first}',
    );
  }
}

class DebtTile extends StatelessWidget {
  const DebtTile({super.key, required this.model});

  final debt_model.Debt model;

  @override
  Widget build(BuildContext context) {
    return AppTile(
      leading: const Icon(Icons.attach_money),
      title: 'Tutar: ${(model.amount / 100).toStringAsFixed(2)} ₺',
      subtitle:
          'Tarih: ${model.borrowDate.toLocal().toString().split(' ').first} • Durum: ${model.status}',
    );
  }
}

class DebtPaymentTile extends StatelessWidget {
  const DebtPaymentTile({super.key, required this.model});

  final debt_payment_model.DebtPayment model;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          const Icon(Icons.attach_money),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${(model.amount / 100).toStringAsFixed(2)} ₺'),
                Text(model.paymentDate.toLocal().toString().split(' ').first),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
