import 'package:flutter/material.dart';

class WorkerDetailPage extends StatelessWidget {
  const WorkerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Çalışan Detay')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Placeholder(),
      ),
    );
  }
}
