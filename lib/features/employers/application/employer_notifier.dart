import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../debts/data/debt_repository.dart';
import '../../debts/domain/debt.dart';
import '../../projects/data/project_repository.dart';
import '../../projects/domain/project.dart';
import '../data/employer_repository.dart';
import '../domain/employer.dart';
import 'employer_state.dart';

final employerNotifierProvider =
    StateNotifierProvider<EmployerNotifier, EmployerState>((ref) {
  final repo = ref.read(employerRepositoryProvider);
  final projectRepo = ref.read(projectRepositoryProvider);
  final debtRepo = ref.read(debtRepositoryProvider);
  return EmployerNotifier(repo, projectRepo, debtRepo)..loadEmployers();
});

class EmployerNotifier extends StateNotifier<EmployerState> {
  EmployerNotifier(this._repo, this._projectRepo, this._debtRepo)
      : super(EmployerState.initial());

  final EmployerRepository _repo;
  final ProjectRepository _projectRepo;
  final DebtRepository _debtRepo;

  Future<void> loadEmployers() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final employers = await _repo.fetchAll();
      final projects = await _projectRepo.fetchAll();
      final debts = await _debtRepo.fetchAll();

      final projectCounts = <int, int>{};
      for (final project in projects) {
        projectCounts.update(
          project.employerId,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }

      final debtTotals = <int, int>{};
      for (final debt in debts) {
        if (debt.status == DebtStatus.paid) continue;
        debtTotals.update(
          debt.employerId,
          (value) => value + debt.amount,
          ifAbsent: () => debt.amount,
        );
      }

      state = state.copyWith(
        loading: false,
        employers: employers,
        projectCounts: projectCounts,
        debtTotals: debtTotals,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loadEmployerDetail(int employerId) async {
    try {
      state = state.copyWith(loading: true, error: null);
      final employer = await _repo.fetchById(employerId);
      if (employer == null) {
        state = state.copyWith(loading: false, error: 'İşveren bulunamadı');
        return;
      }
      await Future.wait([
        loadProjects(employerId),
        loadDebts(employerId),
        loadTotalDebt(employerId),
      ]);
      state = state.copyWith(loading: false, selectedEmployer: employer);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> loadProjects(int employerId) async {
    final projects = (await _projectRepo.fetchAll())
        .where((p) => p.employerId == employerId)
        .toList();
    state = state.copyWith(projects: projects);
  }

  Future<void> loadDebts(int employerId) async {
    final debts = (await _debtRepo.fetchAll())
        .where((d) => d.employerId == employerId)
        .toList();
    state = state.copyWith(debts: debts);
  }

  Future<void> loadTotalDebt(int employerId) async {
    final totalDebt = await _repo.getTotalDebtForEmployer(employerId);
    state = state.copyWith(totalDebt: totalDebt);
  }

  Future<void> addEmployer(Employer employer) async {
    await _repo.insert(employer);
    await loadEmployers();
  }

  Future<void> updateEmployer(Employer employer) async {
    await _repo.update(employer);
    await loadEmployers();
  }

  Future<void> deleteEmployer(int id) async {
    await _repo.delete(id);
    await loadEmployers();
  }
}
