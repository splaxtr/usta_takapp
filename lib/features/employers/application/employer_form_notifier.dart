import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/employer_repository.dart';
import '../domain/employer.dart';
import 'employer_form_state.dart';
import 'employer_notifier.dart';

final employerFormNotifierProvider = StateNotifierProvider.autoDispose
    .family<EmployerFormNotifier, EmployerFormState, int?>((ref, employerId) {
  final repo = ref.read(employerRepositoryProvider);
  return EmployerFormNotifier(ref, repo, employerId);
});

class EmployerFormNotifier extends StateNotifier<EmployerFormState> {
  EmployerFormNotifier(this._ref, this._repo, this._employerId)
      : super(EmployerFormState.initial()) {
    if (_employerId != null) {
      _load();
    }
  }

  final Ref _ref;
  final EmployerRepository _repo;
  final int? _employerId;

  void setName(String value) {
    state = state.copyWith(name: value, clearError: true);
  }

  void setPhone(String value) {
    state = state.copyWith(phone: value, clearError: true);
  }

  void setNote(String value) {
    state = state.copyWith(note: value, clearError: true);
  }

  void setTotalCreditLimit(String value) {
    state = state.copyWith(totalCreditLimit: value, clearError: true);
  }

  Future<void> _load() async {
    try {
      state = state.copyWith(loading: true, clearError: true);
      final employer = await _repo.fetchById(_employerId!);
      if (employer == null) {
        state = state.copyWith(
          loading: false,
          error: 'İşveren bulunamadı',
        );
        return;
      }
      state = state.copyWith(
        loading: false,
        id: employer.id,
        name: employer.name,
        phone: employer.contact ?? '',
        note: employer.note ?? '',
        totalCreditLimit: employer.totalCreditLimit.toString(),
        createdAt: employer.createdAt,
        revision: state.revision + 1,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  String? _validate() {
    if (state.name.trim().isEmpty) {
      return 'Ad zorunludur';
    }
    final limit = int.tryParse(state.totalCreditLimit) ?? 0;
    if (limit < 0) {
      return 'Limit negatif olamaz';
    }
    final phone = state.phone.trim();
    if (phone.isNotEmpty && !RegExp(r'^\+?[0-9 ]+$').hasMatch(phone)) {
      return 'Telefon formatı geçersiz';
    }
    return null;
  }

  Future<bool> save() async {
    if (!state.canSubmit) return false;
    final validation = _validate();
    if (validation != null) {
      state = state.copyWith(error: validation);
      return false;
    }
    try {
      state = state.copyWith(saving: true, clearError: true);
      final limit = int.tryParse(state.totalCreditLimit) ?? 0;
      final employer = Employer(
        id: state.id,
        name: state.name.trim(),
        contact: state.phone.trim().isEmpty ? null : state.phone.trim(),
        note: state.note.trim().isEmpty ? null : state.note.trim(),
        totalCreditLimit: limit,
        createdAt: state.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
      if (state.id == null) {
        await _repo.insert(employer);
      } else {
        await _repo.update(employer);
      }
      await _ref.read(employerNotifierProvider.notifier).loadEmployers();
      state = state.copyWith(saving: false);
      return true;
    } catch (e) {
      state = state.copyWith(saving: false, error: e.toString());
      return false;
    }
  }
}
