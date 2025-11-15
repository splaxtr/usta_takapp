import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/employer_repository.dart';
import '../domain/employer.dart';
import 'employer_state.dart';

final employerNotifierProvider = StateNotifierProvider<EmployerNotifier, EmployerState>((ref) {
  final repo = ref.watch(employerRepositoryProvider);
  return EmployerNotifier(repo)..load();
});

class EmployerNotifier extends StateNotifier<EmployerState> {
  EmployerNotifier(this._repo) : super(EmployerState.initial());

  final EmployerRepository _repo;

  Future<void> load() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final result = await _repo.fetchAll();
      state = state.copyWith(loading: false, data: result);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> addEmployer(Employer employer) async {
    await _repo.insert(employer);
    await load();
  }

  Future<void> updateEmployer(Employer employer) async {
    await _repo.update(employer);
    await load();
  }

  Future<void> deleteEmployer(int id) async {
    await _repo.delete(id);
    await load();
  }
}
