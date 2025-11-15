import 'package:drift/drift.dart';
import 'debts.dart';

class DebtPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get debtId => integer().references(Debts, #id)();
  IntColumn get amount => integer()();
  DateTimeColumn get paymentDate => dateTime()();
  TextColumn get note => text().nullable()();
}
