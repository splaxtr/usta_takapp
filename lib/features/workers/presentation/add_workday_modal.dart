import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  void dispose() {
    hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(projectNotifierProvider).projects;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<int>(
            value: projectId,
            items: projects
                .map((p) => DropdownMenuItem(value: p.id, child: Text(p.title)))
                .toList(),
            decoration: const InputDecoration(labelText: 'Proje'),
            onChanged: (value) => setState(() => projectId = value),
          ),
          const SizedBox(height: 12),
          TextButton(
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
          const SizedBox(height: 12),
          TextField(
            controller: hoursController,
            decoration: const InputDecoration(labelText: 'Gün/Saat'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: projectId == null
                  ? null
                  : () async {
                      final hours = int.tryParse(hoursController.text) ?? 1;
                      final assignment = WorkerAssignmentModel(
                        workerId: widget.workerId,
                        projectId: projectId!,
                        workDate: workDate,
                        hours: hours,
                        overtimeHours: 0,
                      );
                      await ref
                          .read(workerNotifierProvider.notifier)
                          .addAssignment(assignment);
                      Navigator.pop(context);
                    },
              child: const Text('Kaydet'),
            ),
          ),
        ],
      ),
    );
  }
}
