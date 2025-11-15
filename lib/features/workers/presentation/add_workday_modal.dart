import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/validation/validators.dart';
import '../../projects/application/project_notifier.dart';
import '../application/worker_notifier.dart';
import '../domain/worker_assignment.dart';

class AddWorkdayModal extends ConsumerStatefulWidget {
  const AddWorkdayModal({super.key, required this.workerId});

  final int workerId;

  @override
  ConsumerState<AddWorkdayModal> createState() => _AddWorkdayModalState();
}

class _AddWorkdayModalState extends ConsumerState<AddWorkdayModal> {
  int? projectId;
  DateTime workDate = DateTime.now();
  final hoursController = TextEditingController(text: '1');
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  void dispose() {
    hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projects = ref
        .watch(projectNotifierProvider)
        .projects
        .where((p) => p.id != null)
        .toList();

    Future<void> submit() async {
      if (!(_formKey.currentState?.validate() ?? false)) return;
      final selectedProject = projectId;
      if (selectedProject == null) return;
      final hours = int.tryParse(hoursController.text) ?? 0;
      final assignment = WorkerAssignmentModel(
        workerId: widget.workerId,
        projectId: selectedProject,
        workDate: DateTime(workDate.year, workDate.month, workDate.day),
        hours: hours,
        overtimeHours: 0,
      );
      setState(() => _saving = true);
      final error =
          await ref.read(workerNotifierProvider.notifier).addAssignment(
                assignment,
              );
      if (!mounted) return;
      setState(() => _saving = false);
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
        return;
      }
      Navigator.pop(context);
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              value: projectId,
              items: projects
                  .map(
                    (p) => DropdownMenuItem(
                      value: p.id,
                      child: Text(p.title),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(labelText: 'Proje'),
              validator: (value) => value == null ? 'Proje seçmelisiniz' : null,
              onChanged: (value) => setState(() => projectId = value),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: workDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => workDate = picked);
                  }
                },
                child: Text(
                  'Tarih: ${workDate.toLocal().toString().split(' ').first}',
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: hoursController,
              decoration: const InputDecoration(labelText: 'Gün/Saat'),
              keyboardType: TextInputType.number,
              validator: Validators.positiveInt,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : submit,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
