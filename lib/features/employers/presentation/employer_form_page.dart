import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/validation/validators.dart';
import '../../../core/widgets/form_scaffold.dart';
import '../application/employer_form_notifier.dart';
import '../application/employer_form_state.dart';

class EmployerFormPage extends ConsumerStatefulWidget {
  final int? employerId;

  const EmployerFormPage({super.key, this.employerId});

  @override
  ConsumerState<EmployerFormPage> createState() => _EmployerFormPageState();
}

class _EmployerFormPageState extends ConsumerState<EmployerFormPage> {
  final _formKey = GlobalKey<FormState>();

  ProviderListenable<EmployerFormState> get _provider =>
      employerFormNotifierProvider(widget.employerId);

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

    return FormScaffold(
      title: state.id == null ? 'İşveren Oluştur' : 'İşvereni Düzenle',
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
                    key: ValueKey('employer-name-${state.revision}'),
                    initialValue: state.name,
                    decoration: const InputDecoration(labelText: 'Ad / Firma'),
                    validator: Validators.required,
                    onChanged: notifier.setName,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('employer-phone-${state.revision}'),
                    initialValue: state.phone,
                    decoration:
                        const InputDecoration(labelText: 'Telefon (opsiyonel)'),
                    onChanged: notifier.setPhone,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('employer-note-${state.revision}'),
                    initialValue: state.note,
                    decoration:
                        const InputDecoration(labelText: 'Not (opsiyonel)'),
                    maxLines: 3,
                    onChanged: notifier.setNote,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('employer-limit-${state.revision}'),
                    initialValue: state.totalCreditLimit,
                    decoration: const InputDecoration(
                      labelText: 'Toplam Kredi Limiti',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return null;
                      final parsed = int.tryParse(value);
                      if (parsed == null || parsed < 0) {
                        return 'Limit negatif olamaz';
                      }
                      return null;
                    },
                    onChanged: notifier.setTotalCreditLimit,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}
