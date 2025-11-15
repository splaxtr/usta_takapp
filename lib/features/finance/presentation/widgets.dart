import 'package:flutter/material.dart';

import '../../../core/widgets/app_tile.dart';
import '../domain/income_expense.dart';

class AmountText extends StatelessWidget {
  const AmountText({super.key, required this.amount, required this.type});

  final int amount;
  final String type;

  @override
  Widget build(BuildContext context) {
    final isIncome = type == 'income';
    final color = isIncome ? Colors.greenAccent : Colors.redAccent;
    final sign = isIncome ? '+' : '-';
    return Text(
      '$sign${(amount / 100).toStringAsFixed(2)} ₺',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.model,
    required this.projectName,
    required this.employerName,
  });

  final IncomeExpenseModel model;
  final String? projectName;
  final String? employerName;

  @override
  Widget build(BuildContext context) {
    final typeLabel = model.type == 'income' ? 'Gelir' : 'Gider';
    final subtitleLines = <String>[
      if (projectName != null) 'Proje: $projectName',
      if (employerName != null) 'İşveren: $employerName',
      if (model.description != null && model.description!.isNotEmpty)
        model.description!,
      'Tarih: ${model.txDate.toLocal().toString().split(' ').first}',
    ];

    final subtitle = subtitleLines.isEmpty ? null : subtitleLines.join('\n');

    final iconColor = model.type == 'income'
        ? Colors.greenAccent
        : Colors.redAccent;

    return AppTile(
      leading: Icon(Icons.account_balance_wallet_outlined, color: iconColor),
      title: '${model.category} • $typeLabel',
      subtitle: subtitle,
      trailing: AmountText(amount: model.amount, type: model.type),
    );
  }
}

class DateFilterBar extends StatelessWidget {
  const DateFilterBar({
    super.key,
    required this.range,
    required this.onClear,
    required this.onPick,
  });

  final DateTimeRange? range;
  final VoidCallback onClear;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.date_range),
            label: Text(
              range == null
                  ? 'Tarih Seç'
                  : '${range!.start.toLocal().toString().split(' ').first} - ${range!.end.toLocal().toString().split(' ').first}',
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(onPressed: onClear, icon: const Icon(Icons.clear)),
      ],
    );
  }
}
