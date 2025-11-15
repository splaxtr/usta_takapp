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
        status: DebtStatusX.fromString(row.status),
        description: row.description,
        createdAt: row.createdAt,
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
        status: Value(model.status.name),
        description: Value(model.description),
      );

  Future<List<Debt>> fetchAll() async {
    final rows = await _dao.fetchAll();
    return rows.map(_mapDebt).toList();
  }

  Future<List<Debt>> fetchPending() async {
    final query = await (_db.select(_db.debts)
          ..where(
            (tbl) => tbl.status.isIn(
              [DebtStatus.pending.name, DebtStatus.partial.name],
            ),
          )
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.dueDate)]))
        .get();
    return query.map(_mapDebt).toList();
  }

  Future<List<Debt>> fetchByEmployer(int employerId) async {
    final rows = await (_db.select(
      _db.debts,
    )..where((tbl) => tbl.employerId.equals(employerId)))
        .get();
    return rows.map(_mapDebt).toList();
  }

  Future<List<Debt>> fetchByProject(int projectId) async {
    final rows = await (_db.select(
      _db.debts,
    )..where((tbl) => tbl.projectId.equals(projectId)))
        .get();
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

  Future<int> insertDebtPayment(DebtPayment payment) async {
    final id = await _dao.addPayment(
      db.DebtPaymentsCompanion(
        id: payment.id != null ? Value(payment.id!) : const Value.absent(),
        debtId: Value(payment.debtId),
        amount: Value(payment.amount),
        paymentDate: Value(payment.paymentDate),
        note: Value(payment.note),
      ),
    );
    await _refreshDebtStatus(payment.debtId);
    return id;
  }

  Future<int> getRemainingAmount(int debtId) async {
    final result = await _db.customSelect(
      '''
      SELECT d.amount - COALESCE(SUM(p.amount), 0) AS remaining
      FROM debts d
      LEFT JOIN debt_payments p ON p.debt_id = d.id
      WHERE d.id = ?1
      GROUP BY d.amount
      ''',
      variables: [Variable<int>(debtId)],
      readsFrom: {_db.debts, _db.debtPayments},
    ).getSingleOrNull();
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
    final rows = await (_db.select(_db.debts)
          ..where(
            (tbl) =>
                tbl.dueDate.isBetweenValues(now, horizon) &
                tbl.status.isIn(
                  [DebtStatus.pending.name, DebtStatus.partial.name],
                ),
          )
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.dueDate)]))
        .get();
    return rows.map(_mapDebt).toList();
  }

  Future<void> setStatus(int debtId, DebtStatus status) {
    return (_db.update(_db.debts)..where((tbl) => tbl.id.equals(debtId))).write(
      db.DebtsCompanion(status: Value(status.name)),
    );
  }

  Future<void> _refreshDebtStatus(int debtId) async {
    final debt = await fetchById(debtId);
    if (debt == null) return;
    final remaining = await getRemainingAmount(debtId);
    if (remaining <= 0) {
      await setStatus(debtId, DebtStatus.paid);
    } else if (remaining < debt.amount) {
      await setStatus(debtId, DebtStatus.partial);
    } else {
      await setStatus(debtId, DebtStatus.pending);
    }
  }

  Future<int> totalOutstandingForEmployer(
    int employerId, {
    int? excludeDebtId,
  }) async {
    final variables = [
      Variable<int>(employerId),
      if (excludeDebtId != null) Variable<int>(excludeDebtId),
    ];
    final whereExclude = excludeDebtId != null ? 'AND id != ?2' : '';
    final row = await _db
        .customSelect(
          '''
        SELECT COALESCE(SUM(amount), 0) AS total
        FROM debts
        WHERE employer_id = ?1
          AND status IN ('pending','partial')
          $whereExclude
      ''',
          variables: variables,
          readsFrom: {_db.debts},
        )
        .getSingle();
    return row.read<int>('total');
  }

  void mapperSanityCheckDebt(db.Debt row) {
    _toCompanion(_mapDebt(row));
  }

  void mapperSanityCheckPayment(db.DebtPayment row) {
    _mapPayment(row);
  }

  Future<void> repositorySanityCheck() async {
    final rows = await _dao.fetchAll();
    debugPrint('DebtRepository OK: ${rows.length} kayıt');
  }
}
