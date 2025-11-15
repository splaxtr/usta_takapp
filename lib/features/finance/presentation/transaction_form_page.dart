import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/form_scaffold.dart';
import '../../employers/application/employer_notifier.dart';
import '../../projects/application/project_notifier.dart';
import '../application/transaction_form_notifier.dart';
import '../application/transaction_form_state.dart';
import 'finance_categories.dart';

class TransactionFormPage extends ConsumerStatefulWidget {
  final int? transactionId;

  const TransactionFormPage({super.key, this.transactionId});

  @override
  ConsumerState<TransactionFormPage> createState() =>
      _TransactionFormPageState();
}

class _TransactionFormPageState extends ConsumerState<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();

  ProviderListenable<TransactionFormState> get _provider =>
      transactionFormNotifierProvider(widget.transactionId);

  Future<void> _pickDate(
      TransactionFormNotifier notifier, DateTime initial) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      notifier.setDate(picked);
    }
  }

  Future<void> _save() async {
    final notifier = ref.read(_provider.notifier);
    final success = await notifier.save();
    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_provider);
    final notifier = ref.read(_provider.notifier);
    final employers = ref.watch(employerNotifierProvider).employers;
    final projects = ref.watch(projectNotifierProvider).projects;

    final availableProjects = state.employerId == null
        ? <int, String>{}
        : {
            for (final project
                in projects.where((p) => p.employerId == state.employerId))
              project.id!: project.title,
          };

    return FormScaffold(
      title: state.id == null ? 'Yeni İşlem' : 'İşlemi Düzenle',
      onSave: state.canSubmit && !state.loading ? _save : null,
      child: state.loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToggleButtons(
                    isSelected: [
                      state.type == 'income',
                      state.type == 'expense',
                    ],
                    onPressed: (index) =>
                        notifier.setType(index == 0 ? 'income' : 'expense'),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Gelir'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Gider'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('transaction-amount-${state.revision}'),
                    initialValue: state.amount,
                    decoration: const InputDecoration(labelText: 'Tutar (₺)'),
                    keyboardType: TextInputType.number,
                    onChanged: notifier.setAmount,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: financeCategories
                        .map(
                          (cat) => ChoiceChip(
                            label: Text(cat),
                            selected: state.category == cat,
                            onSelected: (_) => notifier.setCategory(cat),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'İşveren'),
                    value: state.employerId,
                    items: employers
                        .where((e) => e.id != null)
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: notifier.setEmployer,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Proje'),
                    value: state.projectId,
                    items: availableProjects.entries
                        .map(
                          (entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(entry.value),
                          ),
                        )
                        .toList(),
                    onChanged: notifier.setProject,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('transaction-desc-${state.revision}'),
                    initialValue: state.description,
                    decoration: const InputDecoration(
                        labelText: 'Açıklama (opsiyonel)'),
                    maxLines: 3,
                    onChanged: notifier.setDescription,
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Tarih'),
                    subtitle: Text(
                      state.txDate.toLocal().toString().split(' ').first,
                    ),
                    onTap: () => _pickDate(notifier, state.txDate),
                  ),
                  if (state.error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      state.error!,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}
