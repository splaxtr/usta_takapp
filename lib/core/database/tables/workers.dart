import 'package:drift/drift.dart';

class Workers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fullName => text()();
  IntColumn get dailyRate => integer()();
  TextColumn get phone => text().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
}
