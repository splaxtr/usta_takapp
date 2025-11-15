import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/report_repository.dart';
import '../domain/weekly_report.dart';
import '../services/export_service.dart';
import 'report_state.dart';

final reportNotifierProvider =
    StateNotifierProvider<ReportNotifier, ReportState>((ref) {
      final repo = ref.read(reportRepositoryProvider);
      final export = ref.read(exportServiceProvider);
      return ReportNotifier(repo, export)..loadWeekData();
    });

class ReportNotifier extends StateNotifier<ReportState> {
  ReportNotifier(this._repository, this._exportService)
    : super(ReportState.initial());

  final ReportRepository _repository;
  final ExportService _exportService;

  Future<void> setWeek(DateTime date) async {
    final start = _startOfWeek(date);
    final end = start.add(const Duration(days: 6));
    state = state.copyWith(weekStart: start, weekEnd: end);
    await loadWeekData();
  }

  Future<void> loadWeekData() async {
    try {
      state = state.copyWith(loading: true, error: null);
      final start = state.weekStart;
      final end = state.weekEnd;
      final snapshot = await _repository.getOrCreateSnapshot(start, end);
      final debtPaid = await _repository.getWeeklyDebtPayments(start, end);
      final transactions = await _repository.getTransactionsForWeek(start, end);
      final assignments = await _repository.getAssignmentsForWeek(start, end);
      final debts = await _repository.getDebtsForWeek(start, end);
      final debtPayments = await _repository.getDebtPaymentsForWeek(start, end);
      state = state.copyWith(
        loading: false,
        income: snapshot.incomeTotal,
        expense: snapshot.expenseTotal,
        payroll: snapshot.payrollTotal,
        debtTaken: snapshot.debtTotal,
        debtPaid: debtPaid,
        transactions: transactions,
        assignments: assignments,
        debts: debts,
        debtPayments: debtPayments,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<WeeklyReportData> loadSnapshotOrCalculate() async {
    final start = state.weekStart;
    final end = state.weekEnd;
    final snapshot = await _repository.getOrCreateSnapshot(start, end);
    final debtPaid = await _repository.getWeeklyDebtPayments(start, end);
    return WeeklyReportData(snapshot: snapshot, debtPaid: debtPaid);
  }

  Future<String> generatePdf() async {
    final path = await _exportService.generateWeeklyPdf(state);
    return path;
  }

  Future<String> generateExcel() async {
    final path = await _exportService.generateWeeklyExcel(state);
    return path;
  }
}

class WeeklyReportData {
  WeeklyReportData({required this.snapshot, required this.debtPaid});
  final WeeklyReport snapshot;
  final int debtPaid;
}

DateTime _startOfWeek(DateTime date) {
  final weekday = date.weekday;
  return DateTime(
    date.year,
    date.month,
    date.day,
  ).subtract(Duration(days: weekday - 1));
}
