import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/dashboard/presentation/dashboard_page.dart';
import 'features/employers/presentation/employer_list_page.dart';
import 'features/projects/presentation/project_list_page.dart';

class UstaTakipApp extends StatelessWidget {
  const UstaTakipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Usta Takip',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark(),
        home: const DashboardPage(),
        routes: {
          '/employers': (_) => const EmployerListPage(),
          '/projects': (_) => const ProjectListPage(),
        },
      ),
    );
  }
}
