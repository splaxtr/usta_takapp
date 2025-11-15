import 'package:flutter/material.dart';

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

class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(category),
      backgroundColor: Colors.white.withOpacity(0.08),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.02),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(model.category.characters.first.toUpperCase()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      model.category,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 8),
                    CategoryChip(
                      category: model.type == 'income' ? 'Gelir' : 'Gider',
                    ),
                  ],
                ),
                if (projectName != null) Text('Proje: $projectName'),
                if (employerName != null) Text('İşveren: $employerName'),
                if (model.description != null && model.description!.isNotEmpty)
                  Text(model.description!),
                Text(
                  'Tarih: ${model.txDate.toLocal().toString().split(' ').first}',
                ),
              ],
            ),
          ),
          AmountText(amount: model.amount, type: model.type),
        ],
      ),
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
