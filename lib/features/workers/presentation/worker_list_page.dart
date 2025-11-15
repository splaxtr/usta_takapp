import 'package:flutter/material.dart';

class WorkerListPage extends StatelessWidget {
  const WorkerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Çalışanlar')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Placeholder(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add_alt),
      ),
    );
  }
}
