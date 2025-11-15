import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'tables/debt_payments.dart';
import 'tables/debts.dart';
import 'tables/employers.dart';
import 'tables/income_expense.dart';
import 'tables/payments.dart';
import 'tables/projects.dart';
import 'tables/weekly_snapshots.dart';
import 'tables/worker_assignments.dart';
import 'tables/workers.dart';

part 'app_database.g.dart';
part 'daos/employer_dao.dart';
part 'daos/project_dao.dart';
part 'daos/finance_dao.dart';
part 'daos/debt_dao.dart';
part 'daos/worker_dao.dart';
part 'daos/report_dao.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = File('app.db');
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
  tables: [
    Employers,
    Projects,
    IncomeExpense,
    Debts,
    DebtPayments,
    Workers,
    WorkerAssignments,
    Payments,
    WeeklySnapshots,
  ],
  daos: [
    EmployerDao,
    ProjectDao,
    FinanceDao,
    DebtDao,
    WorkerDao,
    ReportDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
