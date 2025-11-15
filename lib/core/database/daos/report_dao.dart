part of '../app_database.dart';

@DriftAccessor(tables: [WeeklySnapshots])
class ReportDao extends DatabaseAccessor<AppDatabase> with _$ReportDaoMixin {
  ReportDao(AppDatabase db) : super(db);

  Future<List<WeeklySnapshot>> fetchAll() => select(weeklySnapshots).get();

  Stream<WeeklySnapshot?> watchWeek(DateTime weekStart) {
    return (select(weeklySnapshots)..where((w) => w.weekStart.equals(weekStart))).watchSingleOrNull();
  }

  Future<int> upsertSnapshot(WeeklySnapshotsCompanion entry) {
    return into(weeklySnapshots).insertOnConflictUpdate(entry);
  }

  Future<int> deleteWeek(DateTime weekStart) {
    return (delete(weeklySnapshots)..where((w) => w.weekStart.equals(weekStart))).go();
  }
}
