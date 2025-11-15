import 'package:drift/drift.dart';
import 'package:usta_takapp/core/database/app_database.dart' as db;
import '../domain/weekly_report.dart';

class WeeklyReportMapper {
  static WeeklyReport toDomain(db.WeeklySnapshot row) => WeeklyReport(
        id: row.id,
        weekStart: row.weekStart,
        incomeTotal: row.incomeTotal,
        expenseTotal: row.expenseTotal,
        debtTotal: row.debtTotal,
        payrollTotal: row.payrollTotal,
        generatedAt: row.generatedAt,
      );

  static db.WeeklySnapshotsCompanion toInsert(WeeklyReport model) => db.WeeklySnapshotsCompanion(
        id: model.id != null ? Value(model.id!) : const Value.absent(),
        weekStart: Value(model.weekStart),
        incomeTotal: Value(model.incomeTotal),
        expenseTotal: Value(model.expenseTotal),
        debtTotal: Value(model.debtTotal),
        payrollTotal: Value(model.payrollTotal),
        generatedAt: Value(model.generatedAt),
      );
}

class ReportRepository {
  final db.ReportDao _dao;
  ReportRepository(this._dao);

  Future<List<WeeklyReport>> fetchAll() async {
    final rows = await _dao.fetchAll();
    return rows.map(WeeklyReportMapper.toDomain).toList();
  }

  Future<WeeklyReport?> fetchByWeek(DateTime weekStart) async {
    final row = await _dao.fetchByWeek(weekStart);
    return row == null ? null : WeeklyReportMapper.toDomain(row);
  }

  Future<int> upsert(WeeklyReport report) => _dao.upsertSnapshot(WeeklyReportMapper.toInsert(report));

  Future<int> deleteWeek(DateTime weekStart) => _dao.deleteWeek(weekStart);
}
