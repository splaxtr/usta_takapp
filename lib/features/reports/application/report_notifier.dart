import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/report_repository.dart';
import '../domain/weekly_snapshot.dart';
import '../services/export_service.dart';
import 'report_state.dart';

final reportNotifierProvider =
    StateNotifierProvider<ReportNotifier, ReportState>((ref) {
  final repo = ref.read(reportRepositoryProvider);
  final export = ref.read(exportServiceProvider);
  final notifier = ReportNotifier(repo, export);
  notifier.loadWeekData();
  return notifier;
});

class ReportNotifier extends StateNotifier<ReportState> {
  ReportNotifier(this._repository, this._exportService)
      : super(ReportState.initial());

  final ReportRepository _repository;
  final ExportService _exportService;

  Future<void> setWeek(DateTime date) async {
    final start = _startOfWeek(date);
    state = state.copyWith(
      weekStart: start,
      weekEnd: start.add(const Duration(days: 6)),
      clearSnapshot: true,
    );
    await loadWeekData();
  }

  Future<void> loadWeekData() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final start = state.weekStart;
      final end = state.weekEnd;
      final snapshot = await _repository.ensureSnapshot(start);
      final debtPaid = await _repository.getWeeklyDebtPayments(start, end);
      final transactions = await _repository.getTransactionsForWeek(start, end);
      final assignments = await _repository.getAssignmentsForWeek(start, end);
      final debts = await _repository.getDebtsForWeek(start, end);
      final debtPayments = await _repository.getDebtPaymentsForWeek(start, end);
      final activeProjects = await _repository.fetchActiveProjects();
      state = state.copyWith(
        loading: false,
        snapshot: snapshot,
        debtPaid: debtPaid,
        transactions: transactions,
        assignments: assignments,
        debts: debts,
        debtPayments: debtPayments,
        activeProjects: activeProjects,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<WeeklySnapshot> _snapshotForExport() async {
    var snapshot = state.snapshot;
    snapshot ??= await _repository.ensureSnapshot(state.weekStart);
    return snapshot.copyWith(
      transactions: state.transactions,
      assignments: state.assignments,
      debts: state.debts,
      debtPayments: state.debtPayments,
      activeProjects: state.activeProjects,
    );
  }

  Future<String> generatePdf() async {
    final snapshot = await _snapshotForExport();
    return _exportService.generateWeeklyPdf(snapshot);
  }

  Future<String> generateExcel() async {
    final snapshot = await _snapshotForExport();
    return _exportService.generateWeeklyExcel(snapshot);
  }
}

DateTime _startOfWeek(DateTime date) {
  final startOfDay = DateTime(date.year, date.month, date.day);
  return startOfDay.subtract(Duration(days: date.weekday - DateTime.monday));
}
