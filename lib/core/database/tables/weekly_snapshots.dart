import 'package:drift/drift.dart';

class WeeklySnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get weekStart => dateTime()();
  IntColumn get incomeTotal => integer()();
  IntColumn get expenseTotal => integer()();
  IntColumn get debtTotal => integer()();
  IntColumn get payrollTotal => integer()();
  DateTimeColumn get generatedAt => dateTime().withDefault(currentDateAndTime)();
}
