import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/dashboard/presentation/dashboard_page.dart';
import 'features/debts/presentation/debt_detail_page.dart';
import 'features/debts/presentation/debt_list_page.dart';
import 'features/employers/presentation/employer_detail_page.dart';
import 'features/employers/presentation/employer_list_page.dart';
import 'features/finance/presentation/transaction_list_page.dart';
import 'features/projects/presentation/project_detail_page.dart';
import 'features/projects/presentation/project_list_page.dart';
import 'features/reports/presentation/weekly_report_page.dart';
import 'features/workers/presentation/worker_detail_page.dart';
import 'features/workers/presentation/worker_list_page.dart';

class UstaTakipApp extends StatelessWidget {
  const UstaTakipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Usta Takip',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark(),
        initialRoute: '/',
        routes: {
          '/': (_) => const DashboardPage(),
          '/projects': (_) => const ProjectListPage(),
          '/employers': (_) => const EmployerListPage(),
          '/debts': (_) => const DebtListPage(),
          '/workers': (_) => const WorkerListPage(),
          '/finance': (_) => const TransactionListPage(),
          '/reports/weekly': (_) => const WeeklyReportPage(),
        },
        onGenerateRoute: (settings) {
          final args = settings.arguments;
          switch (settings.name) {
            case '/project/detail':
              final id = args as int?;
              if (id == null) break;
              return MaterialPageRoute(
                builder: (_) => ProjectDetailPage(projectId: id),
              );
            case '/employer/detail':
              final id = args as int?;
              if (id == null) break;
              return MaterialPageRoute(
                builder: (_) => EmployerDetailPage(employerId: id),
              );
            case '/debt/detail':
              final id = args as int?;
              if (id == null) break;
              return MaterialPageRoute(
                builder: (_) => DebtDetailPage(debtId: id),
              );
            case '/worker/detail':
              final id = args as int?;
              if (id == null) break;
              return MaterialPageRoute(
                builder: (_) => WorkerDetailPage(workerId: id),
              );
          }
          return MaterialPageRoute(builder: (_) => const DashboardPage());
        },
      ),
    );
  }
}
