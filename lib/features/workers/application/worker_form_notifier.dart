import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/worker_repository.dart';
import '../domain/worker.dart';
import 'worker_form_state.dart';
import 'worker_notifier.dart';

final workerFormNotifierProvider = StateNotifierProvider.autoDispose
    .family<WorkerFormNotifier, WorkerFormState, int?>((ref, workerId) {
  final repo = ref.read(workerRepositoryProvider);
  return WorkerFormNotifier(ref, repo, workerId);
});

class WorkerFormNotifier extends StateNotifier<WorkerFormState> {
  WorkerFormNotifier(this._ref, this._repo, this._workerId)
      : super(WorkerFormState.initial()) {
    if (_workerId != null) {
      _load();
    }
  }

  final Ref _ref;
  final WorkerRepository _repo;
  final int? _workerId;

  void setName(String value) =>
      state = state.copyWith(fullName: value, clearError: true);

  void setDailyRate(String value) =>
      state = state.copyWith(dailyRate: value, clearError: true);

  void setPhone(String value) =>
      state = state.copyWith(phone: value, clearError: true);

  void setNote(String value) =>
      state = state.copyWith(note: value, clearError: true);

  void setActive(bool value) =>
      state = state.copyWith(active: value, clearError: true);

  Future<void> _load() async {
    try {
      state = state.copyWith(loading: true, clearError: true);
      final worker = await _repo.fetchById(_workerId!);
      if (worker == null) {
        state = state.copyWith(
          loading: false,
          error: 'Çalışan bulunamadı',
        );
        return;
      }
      state = state.copyWith(
        loading: false,
        id: worker.id,
        fullName: worker.fullName,
        dailyRate: (worker.dailyRate / 100).toStringAsFixed(2),
        phone: worker.phone ?? '',
        note: worker.note ?? '',
        active: worker.active,
        revision: state.revision + 1,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  String? _validate(double rate) {
    if (state.fullName.trim().isEmpty) {
      return 'İsim zorunludur';
    }
    if (rate <= 0) {
      return 'Günlük ücret pozitif olmalı';
    }
    return null;
  }

  Future<bool> save() async {
    if (!state.canSubmit) return false;
    try {
      state = state.copyWith(saving: true, clearError: true);
      final rate = (double.tryParse(
                state.dailyRate.replaceAll(',', '.'),
              ) ??
              0) *
          100;
      final validation = _validate(rate);
      if (validation != null) {
        state = state.copyWith(saving: false, error: validation);
        return false;
      }
      final worker = WorkerModel(
        id: state.id,
        fullName: state.fullName.trim(),
        dailyRate: rate.toInt(),
        phone: state.phone.trim().isEmpty ? null : state.phone.trim(),
        note: state.note.trim().isEmpty ? null : state.note.trim(),
        active: state.active,
      );
      if (state.id == null) {
        await _repo.insertWorker(worker);
      } else {
        await _repo.updateWorker(worker);
      }
      await _ref.read(workerNotifierProvider.notifier).loadWorkers();
      state = state.copyWith(saving: false);
      return true;
    } catch (e) {
      state = state.copyWith(saving: false, error: e.toString());
      return false;
    }
  }
}
