import 'package:flutter/material.dart';

class EmployerDetailPage extends StatelessWidget {
  const EmployerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('İşveren Detay'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Projeler'),
              Tab(text: 'Borçlar'),
              Tab(text: 'İletişim'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Placeholder()),
            Center(child: Placeholder()),
            Center(child: Placeholder()),
          ],
        ),
      ),
    );
  }
}
