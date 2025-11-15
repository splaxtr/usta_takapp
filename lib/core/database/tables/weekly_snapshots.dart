import 'package:drift/drift.dart';

class WeeklySnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get weekStart => dateTime()();
  IntColumn get incomeTotal => integer().withDefault(const Constant(0))();
  IntColumn get expenseTotal => integer().withDefault(const Constant(0))();
  IntColumn get debtTotal => integer().withDefault(const Constant(0))();
  IntColumn get payrollTotal => integer().withDefault(const Constant(0))();
  DateTimeColumn get generatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
