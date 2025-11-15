import 'package:flutter/material.dart';

import '../../features/dashboard/presentation/dashboard_page.dart';
import '../../features/debts/presentation/debt_detail_page.dart';
import '../../features/debts/presentation/debt_form_page.dart';
import '../../features/debts/presentation/debt_list_page.dart';
import '../../features/employers/presentation/employer_detail_page.dart';
import '../../features/employers/presentation/employer_form_page.dart';
import '../../features/employers/presentation/employer_list_page.dart';
import '../../features/finance/presentation/transaction_form_page.dart';
import '../../features/finance/presentation/transaction_list_page.dart';
import '../../features/projects/presentation/project_detail_page.dart';
import '../../features/projects/presentation/project_form_page.dart';
import '../../features/projects/presentation/project_list_page.dart';
import '../../features/reports/presentation/weekly_report_page.dart';
import '../../features/workers/presentation/payment_form_page.dart';
import '../../features/workers/presentation/worker_detail_page.dart';
import '../../features/workers/presentation/worker_form_page.dart';
import '../../features/workers/presentation/worker_list_page.dart';
import 'route_args.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case '/projects':
        return MaterialPageRoute(builder: (_) => const ProjectListPage());
      case '/project/detail':
        final detailArgs = _projectDetailArgs(args);
        return MaterialPageRoute(
          builder: (_) => ProjectDetailPage(args: detailArgs),
        );
      case '/employers':
        return MaterialPageRoute(builder: (_) => const EmployerListPage());
      case '/employer/detail':
        final detailArgs = _employerDetailArgs(args);
        return MaterialPageRoute(
          builder: (_) => EmployerDetailPage(args: detailArgs),
        );
      case '/debts':
        return MaterialPageRoute(builder: (_) => const DebtListPage());
      case '/debt/detail':
        final detailArgs = _debtDetailArgs(args);
        return MaterialPageRoute(
          builder: (_) => DebtDetailPage(args: detailArgs),
        );
      case '/workers':
        return MaterialPageRoute(builder: (_) => const WorkerListPage());
      case '/worker/detail':
        final detailArgs = _workerDetailArgs(args);
        return MaterialPageRoute(
          builder: (_) => WorkerDetailPage(args: detailArgs),
        );
      case '/finance':
        return MaterialPageRoute(builder: (_) => const TransactionListPage());
      case '/reports/weekly':
        return MaterialPageRoute(builder: (_) => const WeeklyReportPage());
      case '/report/weekly':
        return MaterialPageRoute(builder: (_) => const WeeklyReportPage());
      case '/employer/form':
        final formArgs =
            args is EmployerFormArgs ? args : const EmployerFormArgs();
        return MaterialPageRoute(
          builder: (_) => EmployerFormPage(args: formArgs),
        );
      case '/project/form':
        final formArgs =
            args is ProjectFormArgs ? args : const ProjectFormArgs();
        return MaterialPageRoute(
          builder: (_) => ProjectFormPage(args: formArgs),
        );
      case '/worker/form':
        final formArgs = args is WorkerFormArgs ? args : const WorkerFormArgs();
        return MaterialPageRoute(
          builder: (_) => WorkerFormPage(args: formArgs),
        );
      case '/transaction/form':
        final formArgs =
            args is TransactionFormArgs ? args : const TransactionFormArgs();
        return MaterialPageRoute(
          builder: (_) => TransactionFormPage(args: formArgs),
        );
      case '/debt/form':
        final formArgs = args is DebtFormArgs ? args : const DebtFormArgs();
        return MaterialPageRoute(
          builder: (_) => DebtFormPage(args: formArgs),
        );
      case '/payment/form':
        if (args is! PaymentFormArgs) {
          return _errorRoute('Ödeme formu için workerId gereklidir');
        }
        return MaterialPageRoute(
          builder: (_) => PaymentFormPage(args: args),
        );
      default:
        return _errorRoute('Route bulunamadı: ${settings.name}');
    }
  }

  static EmployerDetailArgs _employerDetailArgs(Object? raw) {
    if (raw is EmployerDetailArgs) return raw;
    if (raw is int) return EmployerDetailArgs(employerId: raw);
    throw ArgumentError('EmployerDetailPage argümanı eksik');
  }

  static ProjectDetailArgs _projectDetailArgs(Object? raw) {
    if (raw is ProjectDetailArgs) return raw;
    if (raw is int) return ProjectDetailArgs(projectId: raw);
    throw ArgumentError('ProjectDetailPage argümanı eksik');
  }

  static DebtDetailArgs _debtDetailArgs(Object? raw) {
    if (raw is DebtDetailArgs) return raw;
    if (raw is int) return DebtDetailArgs(debtId: raw);
    throw ArgumentError('DebtDetailPage argümanı eksik');
  }

  static WorkerDetailArgs _workerDetailArgs(Object? raw) {
    if (raw is WorkerDetailArgs) return raw;
    if (raw is int) return WorkerDetailArgs(workerId: raw);
    throw ArgumentError('WorkerDetailPage argümanı eksik');
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text(message)),
      ),
    );
  }
}
