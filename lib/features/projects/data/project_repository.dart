import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart' as db;
import '../../debts/domain/debt.dart';
import '../../finance/domain/income_expense.dart';
import '../../projects/domain/project_summary.dart';
import '../../workers/domain/payment.dart';
import '../../workers/domain/worker.dart';
import '../domain/project.dart';

class ProjectMapper {
  static Project toDomain(db.Project row) => Project(
        id: row.id,
        employerId: row.employerId,
        title: row.title,
        startDate: row.startDate,
        endDate: row.endDate,
        status: row.status,
        budget: row.budget,
        description: row.description,
      );

  static db.ProjectsCompanion toInsert(Project model) => db.ProjectsCompanion(
        employerId: Value(model.employerId),
        title: Value(model.title),
        startDate: Value(model.startDate),
        endDate: Value(model.endDate),
        status: Value(model.status),
        budget: Value(model.budget),
        description: Value(model.description),
      );

  static db.ProjectsCompanion toUpdate(Project model) => db.ProjectsCompanion(
        id: Value(model.id!),
        employerId: Value(model.employerId),
        title: Value(model.title),
        startDate: Value(model.startDate),
        endDate: Value(model.endDate),
        status: Value(model.status),
        budget: Value(model.budget),
        description: Value(model.description),
      );

  static void sanityCheck(db.Project row) {
    final model = ProjectMapper.toDomain(row);
    ProjectMapper.toInsert(model);
  }
}

class ProjectWorkersResult {
  ProjectWorkersResult({required this.workers, required this.stats});
  final List<WorkerModel> workers;
  final Map<int, WorkerProjectStats> stats;
}

class ProjectRepository {
  ProjectRepository(this._db) : _dao = _db.projectDao;

  final db.AppDatabase _db;
  final db.ProjectDao _dao;

  Future<List<Project>> fetchAll() async {
    final rows = await _dao.fetchAll();
    return rows.map(ProjectMapper.toDomain).toList();
  }

  Future<List<Project>> fetchActive() async {
    final rows = await (_db.select(
      _db.projects,
    )..where((tbl) => tbl.status.equals('active')))
        .get();
    return rows.map(ProjectMapper.toDomain).toList();
  }

  Future<Project?> fetchById(int id) async {
    final row = await _dao.fetchById(id);
    return row == null ? null : ProjectMapper.toDomain(row);
  }

  Future<int> getProjectIncome(int projectId) =>
      _sumIncomeExpense(projectId, 'income');

  Future<int> getProjectExpense(int projectId) =>
      _sumIncomeExpense(projectId, 'expense');

  Future<int> getProjectDebt(int projectId) async {
    final row = await _db.customSelect(
      '''
        SELECT COALESCE(SUM(d.amount - COALESCE((
          SELECT SUM(dp.amount) FROM debt_payments dp WHERE dp.debt_id = d.id
        ), 0)), 0) AS total
        FROM debts d
        WHERE d.project_id = ?1 AND d.status IN ('pending','partial')
      ''',
      variables: [Variable<int>(projectId)],
      readsFrom: {_db.debts, _db.debtPayments},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> getProjectWorkerCost(int projectId) async {
    final row = await _db.customSelect(
      '''
      SELECT COALESCE(SUM(w.daily_rate * wa.hours), 0) AS total
      FROM worker_assignments wa
      INNER JOIN workers w ON w.id = wa.worker_id
      WHERE wa.project_id = ?1
      ''',
      variables: [Variable<int>(projectId)],
      readsFrom: {_db.workerAssignments, _db.workers},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<int> getProjectPayroll(int projectId) async {
    final row = await _db.customSelect(
      'SELECT COALESCE(SUM(amount), 0) AS total FROM payments WHERE project_id = ?1',
      variables: [Variable<int>(projectId)],
      readsFrom: {_db.payments},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<ProjectSummary> getProjectSummary(int projectId) async {
    final project = await fetchById(projectId);
    final results = await Future.wait([
      getProjectIncome(projectId),
      getProjectExpense(projectId),
      getProjectWorkerCost(projectId),
      getProjectPayroll(projectId),
      getProjectDebt(projectId),
    ]);
    return ProjectSummary(
      income: results[0] as int,
      expense: results[1] as int,
      workerCost: results[2] as int,
      payrollPaid: results[3] as int,
      debt: results[4] as int,
      budget: project?.budget ?? 0,
    );
  }

  Future<int> _sumIncomeExpense(int projectId, String type) async {
    final row = await _db.customSelect(
      'SELECT COALESCE(SUM(amount), 0) AS total FROM income_expense WHERE project_id = ?1 AND type = ?2',
      variables: [
        Variable<int>(projectId),
        Variable<String>(type),
      ],
      readsFrom: {_db.incomeExpense},
    ).getSingle();
    return row.read<int>('total');
  }

  Future<List<IncomeExpenseModel>> getTransactionsForProject(
    int projectId,
  ) async {
    final rows = await (_db.select(_db.incomeExpense)
          ..where((tbl) => tbl.projectId.equals(projectId))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.txDate,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return rows
        .map(
          (row) => IncomeExpenseModel(
            id: row.id,
            projectId: row.projectId,
            employerId: row.employerId,
            type: row.type,
            category: row.category,
            amount: row.amount,
            description: row.description,
            txDate: row.txDate,
          ),
        )
        .toList();
  }

  Future<List<Debt>> getDebtsForProject(int projectId) async {
    final rows = await (_db.select(
      _db.debts,
    )..where((tbl) => tbl.projectId.equals(projectId)))
        .get();
    return rows
        .map(
          (row) => Debt(
            id: row.id,
            employerId: row.employerId,
            projectId: row.projectId,
            amount: row.amount,
            borrowDate: row.borrowDate,
            dueDate: row.dueDate,
            status: DebtStatusX.fromString(row.status),
            description: row.description,
            createdAt: row.createdAt,
          ),
        )
        .toList();
  }

  Future<ProjectWorkersResult> getWorkersForProject(int projectId) async {
    final result = await _db.customSelect(
      '''
      SELECT w.id, w.full_name, w.daily_rate, w.phone, w.note, w.active,
             COUNT(wa.id) AS totalDays
      FROM workers w
      INNER JOIN worker_assignments wa ON wa.worker_id = w.id
      WHERE wa.project_id = ?1
      GROUP BY w.id, w.full_name, w.daily_rate, w.phone, w.note, w.active
      ''',
      variables: [Variable<int>(projectId)],
      readsFrom: {_db.workers, _db.workerAssignments},
    ).get();

    final workers = <WorkerModel>[];
    final stats = <int, WorkerProjectStats>{};

    for (final row in result) {
      final id = row.read<int>('id');
      final dailyRate = row.read<int>('daily_rate');
      final totalDays = row.read<int>('totalDays');

      workers.add(
        WorkerModel(
          id: id,
          fullName: row.read<String>('full_name'),
          dailyRate: dailyRate,
          phone: row.read<String?>('phone'),
          note: row.read<String?>('note'),
          active: row.read<bool>('active'),
        ),
      );

      stats[id] = WorkerProjectStats(
        totalDays: totalDays,
        totalCost: totalDays * dailyRate,
      );
    }

    return ProjectWorkersResult(workers: workers, stats: stats);
  }

  Future<List<PaymentModel>> getPaymentsForProject(int projectId) async {
    final rows = await (_db.select(_db.payments)
          ..where((tbl) => tbl.projectId.equals(projectId))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.paymentDate,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return rows
        .map(
          (row) => PaymentModel(
            id: row.id,
            workerId: row.workerId,
            projectId: row.projectId,
            amount: row.amount,
            paymentDate: row.paymentDate,
            method: row.method,
            note: row.note,
          ),
        )
        .toList();
  }

  Future<int> insert(Project project) =>
      _dao.insertProject(ProjectMapper.toInsert(project));

  Future<bool> update(Project project) {
    if (project.id == null) return Future.value(false);
    return _dao.updateProject(ProjectMapper.toUpdate(project));
  }

  Future<int> delete(int id) => _dao.deleteById(id);

  Future<void> repositorySanityCheck() async {
    final rows = await _dao.fetchAll();
    debugPrint('ProjectRepository OK: ${rows.length} kayıt');
  }
}
