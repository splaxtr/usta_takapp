import 'package:drift/drift.dart';
import 'workers.dart';
import 'projects.dart';

class WorkerAssignments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workerId => integer().references(Workers, #id)();
  IntColumn get projectId => integer().references(Projects, #id)();
  DateTimeColumn get workDate => dateTime()();
  IntColumn get hours => integer()();
  IntColumn get overtimeHours => integer().nullable()();
}
