import 'package:drift/drift.dart';
import 'projects.dart';
import 'employers.dart';

class IncomeExpense extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer().references(Projects, #id).nullable()();
  IntColumn get employerId => integer().references(Employers, #id).nullable()();
  TextColumn get type => text()();
  TextColumn get category => text()();
  IntColumn get amount => integer()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get txDate => dateTime()();
}
