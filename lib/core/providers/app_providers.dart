import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../../features/debts/data/debt_repository.dart';
import '../../features/employers/data/employer_repository.dart';
import '../../features/finance/data/finance_repository.dart';
import '../../features/projects/data/project_repository.dart';
import '../../features/reports/data/report_repository.dart';
import '../../features/reports/services/export_service.dart';
import '../../features/workers/data/worker_repository.dart';
import '../../features/dashboard/data/dashboard_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final employerRepositoryProvider = Provider<EmployerRepository>((ref) {
  final db = ref.read(databaseProvider);
  return EmployerRepository(db);
});

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final db = ref.read(databaseProvider);
  return ProjectRepository(db);
});

final financeRepositoryProvider = Provider<FinanceRepository>((ref) {
  final db = ref.read(databaseProvider);
  return FinanceRepository(db);
});

final debtRepositoryProvider = Provider<DebtRepository>((ref) {
  final db = ref.read(databaseProvider);
  return DebtRepository(db);
});

final workerRepositoryProvider = Provider<WorkerRepository>((ref) {
  final db = ref.read(databaseProvider);
  return WorkerRepository(db);
});

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  final db = ref.read(databaseProvider);
  return ReportRepository(db);
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final db = ref.read(databaseProvider);
  return DashboardRepository(db);
});

final exportServiceProvider = Provider<ExportService>((ref) => ExportService());
