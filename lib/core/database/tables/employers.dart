import 'package:drift/drift.dart';

class Employers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get contact => text().nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get totalCreditLimit => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}
