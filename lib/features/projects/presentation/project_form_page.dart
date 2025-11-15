import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/validation/validators.dart';
import '../../../core/router/route_args.dart';
import '../../../core/widgets/form_scaffold.dart';
import '../../employers/application/employer_notifier.dart';
import '../application/project_form_notifier.dart';
import '../application/project_form_state.dart';

class ProjectFormPage extends ConsumerStatefulWidget {
  final ProjectFormArgs? args;

  const ProjectFormPage({super.key, this.args});

  @override
  ConsumerState<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends ConsumerState<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  ProviderListenable<ProjectFormState> get _provider =>
      projectFormNotifierProvider(widget.args?.projectId);

  Future<void> _pickDate({
    required DateTime initial,
    required ValueChanged<DateTime> onChanged,
  }) async {
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

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
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
    final employers = ref
        .watch(employerNotifierProvider)
        .employers
        .where((e) => e.id != null);

    return FormScaffold(
      title: state.id == null ? 'Proje Oluştur' : 'Projeyi Düzenle',
      onSave: state.canSubmit && !state.loading ? _save : null,
      errorText: state.error,
      child: state.loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    key: ValueKey('project-title-${state.revision}'),
                    initialValue: state.title,
                    decoration: const InputDecoration(labelText: 'Başlık'),
                    validator: Validators.required,
                    onChanged: notifier.setTitle,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    value: state.employerId,
                    decoration:
                        const InputDecoration(labelText: 'İşveren Seçin'),
                    validator: (value) =>
                        value == null ? 'İşveren seçmelisiniz' : null,
                    items: employers
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
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Başlangıç Tarihi'),
                          subtitle: Text(
                            state.startDate
                                .toLocal()
                                .toString()
                                .split(' ')
                                .first,
                          ),
                          onTap: () => _pickDate(
                            initial: state.startDate,
                            onChanged: notifier.setStartDate,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Bitiş Tarihi'),
                          subtitle: Text(
                            state.endDate == null
                                ? '-'
                                : state.endDate!
                                    .toLocal()
                                    .toString()
                                    .split(' ')
                                    .first,
                          ),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: state.endDate ?? state.startDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );
                            notifier.setEndDate(picked);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('project-budget-${state.revision}'),
                    initialValue: state.budget,
                    decoration: const InputDecoration(labelText: 'Bütçe (₺)'),
                    validator: Validators.positiveDouble,
                    keyboardType: TextInputType.number,
                    onChanged: notifier.setBudget,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('project-desc-${state.revision}'),
                    initialValue: state.description,
                    decoration: const InputDecoration(
                        labelText: 'Açıklama (opsiyonel)'),
                    maxLines: 3,
                    onChanged: notifier.setDescription,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}
