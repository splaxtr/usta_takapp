import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/form_scaffold.dart';
import '../../employers/application/employer_notifier.dart';
import '../../projects/application/project_notifier.dart';
import '../application/debt_form_notifier.dart';
import '../application/debt_form_state.dart';

class DebtFormPage extends ConsumerStatefulWidget {
  final int? debtId;

  const DebtFormPage({super.key, this.debtId});

  @override
  ConsumerState<DebtFormPage> createState() => _DebtFormPageState();
}

class _DebtFormPageState extends ConsumerState<DebtFormPage> {
  final _formKey = GlobalKey<FormState>();

  ProviderListenable<DebtFormState> get _provider =>
      debtFormNotifierProvider(widget.debtId);

  Future<void> _save() async {
    final notifier = ref.read(_provider.notifier);
    final success = await notifier.save();
    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickDate(
    DateTime initial,
    ValueChanged<DateTime> onChanged,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_provider);
    final notifier = ref.read(_provider.notifier);
    final employers = ref.watch(employerNotifierProvider).employers;
    final projects = ref.watch(projectNotifierProvider).projects;
    final filteredProjects = state.employerId == null
        ? <int, String>{}
        : {
            for (final project
                in projects.where((p) => p.employerId == state.employerId))
              project.id!: project.title,
          };

    return FormScaffold(
      title: state.id == null ? 'Borç Oluştur' : 'Borcu Düzenle',
      onSave: state.canSubmit && !state.loading ? _save : null,
      child: state.loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                children: [
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
                    decoration:
                        const InputDecoration(labelText: 'Proje (opsiyonel)'),
                    value: state.projectId,
                    items: filteredProjects.entries
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
                    key: ValueKey('debt-amount-${state.revision}'),
                    initialValue: state.amount,
                    decoration: const InputDecoration(labelText: 'Tutar (₺)'),
                    keyboardType: TextInputType.number,
                    onChanged: notifier.setAmount,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('debt-desc-${state.revision}'),
                    initialValue: state.description,
                    decoration: const InputDecoration(
                        labelText: 'Açıklama (opsiyonel)'),
                    maxLines: 3,
                    onChanged: notifier.setDescription,
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Borç Tarihi'),
                    subtitle: Text(
                      state.borrowDate.toLocal().toString().split(' ').first,
                    ),
                    onTap: () =>
                        _pickDate(state.borrowDate, notifier.setBorrowDate),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Vade Tarihi'),
                    subtitle: Text(
                      state.dueDate.toLocal().toString().split(' ').first,
                    ),
                    onTap: () => _pickDate(state.dueDate, notifier.setDueDate),
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
