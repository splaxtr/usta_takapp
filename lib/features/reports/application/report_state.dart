import '../domain/weekly_report.dart';

class ReportState {
  final bool loading;
  final List<WeeklyReport> data;
  final String? error;

  const ReportState({
    required this.loading,
    required this.data,
    this.error,
  });

  factory ReportState.initial() => const ReportState(loading: true, data: []);

  ReportState copyWith({
    bool? loading,
    List<WeeklyReport>? data,
    String? error,
  }) => ReportState(
        loading: loading ?? this.loading,
        data: data ?? this.data,
        error: error,
      );
}
