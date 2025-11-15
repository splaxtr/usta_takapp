import 'package:drift/drift.dart';
import 'workers.dart';
import 'projects.dart';

class Payments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workerId => integer().references(Workers, #id)();
  IntColumn get projectId => integer().references(Projects, #id)();
  IntColumn get amount => integer()();
  DateTimeColumn get paymentDate => dateTime()();
  TextColumn get method => text()();
  TextColumn get note => text().nullable()();
}
