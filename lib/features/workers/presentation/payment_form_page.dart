import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/form_scaffold.dart';
import '../../projects/application/project_notifier.dart';
import '../application/payment_form_notifier.dart';
import '../application/payment_form_state.dart';
import '../application/worker_notifier.dart';

class PaymentFormPage extends ConsumerStatefulWidget {
  final int? workerId;
  final int? projectId;

  const PaymentFormPage({super.key, this.workerId, this.projectId});

  @override
  ConsumerState<PaymentFormPage> createState() => _PaymentFormPageState();
}

class _PaymentFormPageState extends ConsumerState<PaymentFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final ProviderListenable<PaymentFormState> _provider =
      paymentFormNotifierProvider(
    PaymentFormArgs(
      workerId: widget.workerId,
      projectId: widget.projectId,
    ),
  );

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
    final workers = ref
        .watch(workerNotifierProvider)
        .workers
        .where((w) => w.id != null)
        .toList();
    final projects = ref
        .watch(projectNotifierProvider)
        .projects
        .where((p) => p.id != null)
        .toList();

    return FormScaffold(
      title: 'Ödeme Kaydı',
      onSave: state.canSubmit ? _save : null,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Çalışan'),
              value: state.workerId,
              items: workers
                  .map(
                    (worker) => DropdownMenuItem(
                      value: worker.id,
                      child: Text(worker.fullName),
                    ),
                  )
                  .toList(),
              onChanged: notifier.setWorker,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Proje'),
              value: state.projectId,
              items: projects
                  .map(
                    (project) => DropdownMenuItem(
                      value: project.id,
                      child: Text(project.title),
                    ),
                  )
                  .toList(),
              onChanged: notifier.setProject,
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: ValueKey('payment-amount-${state.revision}'),
              initialValue: state.amount,
              decoration: const InputDecoration(labelText: 'Tutar (₺)'),
              keyboardType: TextInputType.number,
              onChanged: notifier.setAmount,
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: ValueKey('payment-note-${state.revision}'),
              initialValue: state.note,
              decoration: const InputDecoration(labelText: 'Not (opsiyonel)'),
              maxLines: 3,
              onChanged: notifier.setNote,
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Ödeme Tarihi'),
              subtitle: Text(
                state.paymentDate.toLocal().toString().split(' ').first,
              ),
              onTap: () => _pickDate(state.paymentDate, notifier.setDate),
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
