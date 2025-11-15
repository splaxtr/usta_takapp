import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/form_scaffold.dart';
import '../application/worker_form_notifier.dart';
import '../application/worker_form_state.dart';

class WorkerFormPage extends ConsumerStatefulWidget {
  final int? workerId;

  const WorkerFormPage({super.key, this.workerId});

  @override
  ConsumerState<WorkerFormPage> createState() => _WorkerFormPageState();
}

class _WorkerFormPageState extends ConsumerState<WorkerFormPage> {
  final _formKey = GlobalKey<FormState>();

  ProviderListenable<WorkerFormState> get _provider =>
      workerFormNotifierProvider(widget.workerId);

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

    return FormScaffold(
      title: state.id == null ? 'Çalışan Oluştur' : 'Çalışanı Düzenle',
      onSave: state.canSubmit && !state.loading ? _save : null,
      child: state.loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    key: ValueKey('worker-name-${state.revision}'),
                    initialValue: state.fullName,
                    decoration: const InputDecoration(labelText: 'Ad Soyad'),
                    onChanged: notifier.setName,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('worker-rate-${state.revision}'),
                    initialValue: state.dailyRate,
                    decoration:
                        const InputDecoration(labelText: 'Günlük Ücret'),
                    keyboardType: TextInputType.number,
                    onChanged: notifier.setDailyRate,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('worker-phone-${state.revision}'),
                    initialValue: state.phone,
                    decoration:
                        const InputDecoration(labelText: 'Telefon (opsiyonel)'),
                    onChanged: notifier.setPhone,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: ValueKey('worker-note-${state.revision}'),
                    initialValue: state.note,
                    decoration:
                        const InputDecoration(labelText: 'Not (opsiyonel)'),
                    maxLines: 3,
                    onChanged: notifier.setNote,
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Aktif'),
                    value: state.active,
                    onChanged: notifier.setActive,
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
