import 'package:flutter/material.dart';

import 'debt_tab.dart';
import 'finance_tab.dart';
import 'payments_tab.dart';
import 'summary_tab.dart';
import 'workers_tab.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Proje Detay'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Özet'),
              Tab(text: 'Finans'),
              Tab(text: 'Borçlar'),
              Tab(text: 'Çalışanlar'),
              Tab(text: 'Ödemeler'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProjectSummaryTab(),
            ProjectFinanceTab(),
            ProjectDebtTab(),
            ProjectWorkersTab(),
            ProjectPaymentsTab(),
          ],
        ),
      ),
    );
  }
}
