import 'package:flutter/material.dart';

class DebtDetailPage extends StatelessWidget {
  const DebtDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borç Detay')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Placeholder(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_task),
      ),
    );
  }
}
