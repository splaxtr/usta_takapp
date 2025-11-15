import 'package:flutter/material.dart';

class EmployerListPage extends StatelessWidget {
  const EmployerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İşverenler'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Placeholder(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_business),
      ),
    );
  }
}
