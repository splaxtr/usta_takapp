import 'package:flutter/material.dart';

class DebtListPage extends StatelessWidget {
  const DebtListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Borçlar')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Placeholder(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_alert),
      ),
    );
  }
}
