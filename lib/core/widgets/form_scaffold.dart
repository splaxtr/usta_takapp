import 'package:flutter/material.dart';

class FormScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onSave;
  final String? errorText;

  const FormScaffold({
    super.key,
    required this.title,
    required this.child,
    this.onSave,
    this.errorText,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (errorText != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    errorText!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
