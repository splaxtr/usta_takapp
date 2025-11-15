import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart' as db;
import '../domain/debt.dart';
import '../domain/debt_payment.dart';

class DebtRepository {
  DebtRepository(this._db) : _dao = _db.debtDao;

  final db.AppDatabase _db;
  final db.DebtDao _dao;

  Debt _mapDebt(db.Debt row) => Debt(
    id: row.id,
    employerId: row.employerId,
    projectId: row.projectId,
    amount: row.amount,
    borrowDate: row.borrowDate,
    dueDate: row.dueDate,
    status: row.status,
    description: row.description,
  );

  DebtPayment _mapPayment(db.DebtPayment row) => DebtPayment(
    id: row.id,
    debtId: row.debtId,
    amount: row.amount,
    paymentDate: row.paymentDate,
    note: row.note,
  );

  db.DebtsCompanion _toCompanion(Debt model) => db.DebtsCompanion(
    id: model.id != null ? Value(model.id!) : const Value.absent(),
    employerId: Value(model.employerId),
    projectId: Value(model.projectId),
    amount: Value(model.amount),
    borrowDate: Value(model.borrowDate),
    dueDate: Value(model.dueDate),
    status: Value(model.status),
    description: Value(model.description),
  );

  Future<List<Debt>> fetchAll() async {
    final rows = await _dao.fetchAll();
    return rows.map(_mapDebt).toList();
  }

  Future<List<Debt>> fetchPending() async {
    final query =
        await (_db.select(_db.debts)
              ..where((tbl) => tbl.status.isIn(['pending', 'partial']))
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.dueDate)]))
            .get();
    return query.map(_mapDebt).toList();
  }

  Future<List<Debt>> fetchByEmployer(int employerId) async {
    final rows = await (_db.select(
      _db.debts,
    )..where((tbl) => tbl.employerId.equals(employerId))).get();
    return rows.map(_mapDebt).toList();
  }

  Future<List<Debt>> fetchByProject(int projectId) async {
    final rows = await (_db.select(
      _db.debts,
    )..where((tbl) => tbl.projectId.equals(projectId))).get();
    return rows.map(_mapDebt).toList();
  }

  Future<Debt?> fetchById(int id) async {
    final row = await _dao.fetchById(id);
    return row == null ? null : _mapDebt(row);
  }

  Future<int> insertDebt(Debt debt) => _dao.insertDebt(_toCompanion(debt));

  Future<bool> updateDebt(Debt debt) {
    if (debt.id == null) return Future.value(false);
    return _dao.updateDebt(_toCompanion(debt));
  }

  Future<int> deleteDebt(int id) => _dao.deleteDebt(id);

  Future<List<DebtPayment>> getPaymentsForDebt(int debtId) async {
    final rows = await _dao.paymentsForDebt(debtId);
    return rows.map(_mapPayment).toList();
  }

  Future<int> insertDebtPayment(DebtPayment payment) => _dao.addPayment(
    db.DebtPaymentsCompanion(
      id: payment.id != null ? Value(payment.id!) : const Value.absent(),
      debtId: Value(payment.debtId),
      amount: Value(payment.amount),
      paymentDate: Value(payment.paymentDate),
      note: Value(payment.note),
    ),
  );

  Future<int> getRemainingAmount(int debtId) async {
    final result = await _db
        .customSelect(
          '''
      SELECT d.amount - COALESCE(SUM(p.amount), 0) AS remaining
      FROM debts d
      LEFT JOIN debt_payments p ON p.debt_id = d.id
      WHERE d.id = ?1
      GROUP BY d.amount
      ''',
          variables: [Variable<int>(debtId)],
          readsFrom: {_db.debts, _db.debtPayments},
        )
        .getSingleOrNull();
    if (result == null) {
      final debt = await fetchById(debtId);
      return debt?.amount ?? 0;
    }
    final remaining = result.read<int>('remaining');
    return remaining < 0 ? 0 : remaining;
  }

  Future<List<Debt>> getUpcomingDebts() async {
    final now = DateTime.now();
    final horizon = now.add(const Duration(days: 7));
    final rows =
        await (_db.select(_db.debts)
              ..where(
                (tbl) =>
                    tbl.dueDate.isBetweenValues(now, horizon) &
                    tbl.status.isIn(['pending', 'partial']),
              )
              ..orderBy([(tbl) => OrderingTerm(expression: tbl.dueDate)]))
            .get();
    return rows.map(_mapDebt).toList();
  }

  Future<void> setStatus(int debtId, String status) {
    return (_db.update(_db.debts)..where((tbl) => tbl.id.equals(debtId))).write(
      db.DebtsCompanion(status: Value(status)),
    );
  }

  Future<void> repositorySanityCheck() async {
    final rows = await _dao.fetchAll();
    debugPrint('DebtRepository OK: ${rows.length} kayıt');
  }
}
