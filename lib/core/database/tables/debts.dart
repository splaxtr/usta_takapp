import 'package:drift/drift.dart';
import 'employers.dart';
import 'projects.dart';

class Debts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get employerId => integer().references(Employers, #id)();
  IntColumn get projectId => integer().references(Projects, #id).nullable()();
  IntColumn get amount => integer()();
  DateTimeColumn get borrowDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get status => text()();
  TextColumn get description => text().nullable()();
}
