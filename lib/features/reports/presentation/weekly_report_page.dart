import 'package:flutter/material.dart';

class WeeklyReportPage extends StatelessWidget {
  const WeeklyReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Haftalık Rapor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Placeholder(fallbackHeight: 80),
            SizedBox(height: 16),
            Expanded(child: Placeholder()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.ios_share),
        label: const Text('Export'),
      ),
    );
  }
}
