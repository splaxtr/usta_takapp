import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/report_repository.dart';
import '../domain/weekly_report.dart';
import 'report_state.dart';

final reportNotifierProvider = StateNotifierProvider<ReportNotifier, ReportState>((ref) {
  final repo = ref.watch(reportRepositoryProvider);
  return ReportNotifier(repo)..load();
});

class ReportNotifier extends StateNotifier<ReportState> {
  ReportNotifier(this._repo) : super(ReportState.initial());

  final ReportRepository _repo;

  Future<void> load() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final result = await _repo.fetchAll();
      state = state.copyWith(loading: false, data: result);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> refreshWeek(DateTime weekStart) async {
    final report = await _repo.fetchByWeek(weekStart);
    final updated = List<WeeklyReport>.from(state.data);
    final index = updated.indexWhere((r) => r.weekStart == weekStart);
    if (report != null) {
      if (index >= 0) {
        updated[index] = report;
      } else {
        updated.add(report);
      }
    } else if (index >= 0) {
      updated.removeAt(index);
    }
    state = state.copyWith(data: updated);
  }

  Future<void> upsert(WeeklyReport report) async {
    await _repo.upsert(report);
    await refreshWeek(report.weekStart);
  }

  Future<void> deleteWeek(DateTime weekStart) async {
    await _repo.deleteWeek(weekStart);
    await refreshWeek(weekStart);
  }
}
