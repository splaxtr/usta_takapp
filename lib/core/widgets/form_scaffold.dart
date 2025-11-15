import 'package:flutter/material.dart';

class FormScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onSave;

  const FormScaffold({
    super.key,
    required this.title,
    required this.child,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (onSave != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: onSave,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: child),
      ),
    );
  }
}
