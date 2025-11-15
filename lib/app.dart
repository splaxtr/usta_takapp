import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

class UstaTakipApp extends StatelessWidget {
  const UstaTakipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usta Takip',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const Scaffold(
        body: Center(child: Text("Usta Takip Başlangıç")),
      ),
    );
  }
}
