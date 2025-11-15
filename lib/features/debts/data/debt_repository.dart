import 'package:drift/drift.dart';
import 'package:usta_takapp/core/database/app_database.dart' as db;
import '../domain/debt.dart';
import '../domain/debt_payment.dart';

class DebtMapper {
  static Debt toDomain(db.Debt row) => Debt(
        id: row.id,
        employerId: row.employerId,
        projectId: row.projectId,
        amount: row.amount,
        borrowDate: row.borrowDate,
        dueDate: row.dueDate,
        status: row.status,
        description: row.description,
      );

  static db.DebtsCompanion toInsert(Debt model) => db.DebtsCompanion(
        employerId: Value(model.employerId),
        projectId: Value(model.projectId),
        amount: Value(model.amount),
        borrowDate: Value(model.borrowDate),
        dueDate: Value(model.dueDate),
        status: Value(model.status),
        description: Value(model.description),
      );

  static db.DebtsCompanion toUpdate(Debt model) => db.DebtsCompanion(
        id: Value(model.id!),
        employerId: Value(model.employerId),
        projectId: Value(model.projectId),
        amount: Value(model.amount),
        borrowDate: Value(model.borrowDate),
        dueDate: Value(model.dueDate),
        status: Value(model.status),
        description: Value(model.description),
      );
}

class DebtPaymentMapper {
  static DebtPayment toDomain(db.DebtPayment row) => DebtPayment(
        id: row.id,
        debtId: row.debtId,
        amount: row.amount,
        paymentDate: row.paymentDate,
        note: row.note,
      );

  static db.DebtPaymentsCompanion toInsert(DebtPayment model) => db.DebtPaymentsCompanion(
        debtId: Value(model.debtId),
        amount: Value(model.amount),
        paymentDate: Value(model.paymentDate),
        note: Value(model.note),
      );
}

class DebtRepository {
  final db.DebtDao _dao;
  DebtRepository(this._dao);

  Future<List<Debt>> fetchAll() async {
    final rows = await _dao.fetchAll();
    return rows.map(DebtMapper.toDomain).toList();
  }

  Future<Debt?> fetchById(int id) async {
    final row = await _dao.fetchById(id);
    return row == null ? null : DebtMapper.toDomain(row);
  }

  Future<int> insert(Debt debt) => _dao.insertDebt(DebtMapper.toInsert(debt));

  Future<bool> update(Debt debt) {
    if (debt.id == null) return Future.value(false);
    return _dao.updateDebt(DebtMapper.toUpdate(debt));
  }

  Future<int> delete(int id) => _dao.deleteDebt(id);

  Future<List<DebtPayment>> payments(int debtId) async {
    final rows = await _dao.paymentsForDebt(debtId);
    return rows.map(DebtPaymentMapper.toDomain).toList();
  }

  Future<int> addPayment(DebtPayment payment) {
    return _dao.addPayment(DebtPaymentMapper.toInsert(payment));
  }
}
