import 'package:flutter/material.dart';

class AddTransactionModal extends StatelessWidget {
  const AddTransactionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text('Yeni İşlem', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          TextField(decoration: InputDecoration(labelText: 'Kategori')),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Tutar'), keyboardType: TextInputType.number),
          SizedBox(height: 12),
          TextField(decoration: InputDecoration(labelText: 'Açıklama')),
          SizedBox(height: 12),
          Placeholder(fallbackHeight: 80),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
