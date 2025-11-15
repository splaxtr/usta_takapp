import 'package:drift/drift.dart';
import 'employers.dart';

class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get employerId => integer().references(Employers, #id)();
  TextColumn get title => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get status => text()();
  IntColumn get budget => integer()();
  TextColumn get description => text().nullable()();
}
