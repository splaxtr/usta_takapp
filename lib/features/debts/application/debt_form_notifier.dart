import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/debt_repository.dart';
import '../../employers/data/employer_repository.dart';
import '../domain/debt.dart';
import 'debt_form_state.dart';
import 'debt_notifier.dart';

final debtFormNotifierProvider = StateNotifierProvider.autoDispose
    .family<DebtFormNotifier, DebtFormState, int?>((ref, debtId) {
  final repo = ref.read(debtRepositoryProvider);
  final employerRepo = ref.read(employerRepositoryProvider);
  return DebtFormNotifier(ref, repo, employerRepo, debtId);
});

class DebtFormNotifier extends StateNotifier<DebtFormState> {
  DebtFormNotifier(this._ref, this._repo, this._employerRepo, this._debtId)
      : super(DebtFormState.initial()) {
    if (_debtId != null) {
      _load();
    }
  }

  final Ref _ref;
  final DebtRepository _repo;
  final EmployerRepository _employerRepo;
  final int? _debtId;

  void setEmployer(int? id) => state = state.copyWith(
        employerId: id,
        clearProject: true,
        clearError: true,
      );

  void setProject(int? id) =>
      state = state.copyWith(projectId: id, clearError: true);

  void setAmount(String value) =>
      state = state.copyWith(amount: value, clearError: true);

  void setBorrowDate(DateTime date) => state = state.copyWith(
        borrowDate: date,
        clearError: true,
      );

  void setDueDate(DateTime date) =>
      state = state.copyWith(dueDate: date, clearError: true);

  void setDescription(String value) =>
      state = state.copyWith(description: value, clearError: true);

  Future<void> _load() async {
    try {
      state = state.copyWith(loading: true, clearError: true);
      final debt = await _repo.fetchById(_debtId!);
      if (debt == null) {
        state = state.copyWith(
          loading: false,
          error: 'Borç bulunamadı',
        );
        return;
      }
      state = state.copyWith(
        loading: false,
        id: debt.id,
        employerId: debt.employerId,
        projectId: debt.projectId,
        amount: (debt.amount / 100).toStringAsFixed(2),
        borrowDate: debt.borrowDate,
        dueDate: debt.dueDate,
        description: debt.description ?? '',
        status: debt.status,
        createdAt: debt.createdAt,
        revision: state.revision + 1,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<String?> _validate(int amount) async {
    if (state.employerId == null) {
      return 'İşveren seçmelisiniz';
    }
    if (amount <= 0) {
      return 'Tutar pozitif olmalı';
    }
    if (state.dueDate.isBefore(state.borrowDate)) {
      return 'Vade tarihi borç tarihinden önce olamaz';
    }
    final employer = await _employerRepo.fetchById(state.employerId!);
    if (employer == null) {
      return 'İşveren bulunamadı';
    }
    final outstanding = await _repo.totalOutstandingForEmployer(
      state.employerId!,
      excludeDebtId: state.id,
    );
    if (employer.totalCreditLimit > 0 &&
        outstanding + amount > employer.totalCreditLimit) {
      return 'Borç limiti aşılamaz';
    }
    return null;
  }

  Future<bool> save() async {
    if (!state.canSubmit) return false;
    try {
      state = state.copyWith(saving: true, clearError: true);
      final amount =
          (double.tryParse(state.amount.replaceAll(',', '.')) ?? 0) * 100;
      final amountValue = amount.toInt();
      final validation = await _validate(amountValue);
      if (validation != null) {
        state = state.copyWith(saving: false, error: validation);
        return false;
      }
      final debt = Debt(
        id: state.id,
        employerId: state.employerId!,
        projectId: state.projectId,
        amount: amountValue,
        borrowDate: state.borrowDate,
        dueDate: state.dueDate,
        status: state.id == null ? DebtStatus.pending : state.status,
        description: state.description.isEmpty ? null : state.description,
        createdAt: state.createdAt ?? DateTime.now(),
      );
      if (state.id == null) {
        await _repo.insertDebt(debt);
      } else {
        await _repo.updateDebt(debt);
      }
      await _ref.read(debtNotifierProvider.notifier).loadDebts();
      state = state.copyWith(saving: false);
      return true;
    } catch (e) {
      state = state.copyWith(saving: false, error: e.toString());
      return false;
    }
  }
}
