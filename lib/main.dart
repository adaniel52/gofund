import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/pages/main_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoFund',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // themeMode: ThemeMode.dark,
      home: const MainPage(),
    );
  }
}
