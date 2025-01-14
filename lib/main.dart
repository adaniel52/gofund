import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/screens/main_screen.dart';
import 'package:gofund/services/navigation_service.dart';

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
      // darkTheme: AppTheme.dark,
      navigatorKey: NavigationService.instance.navigatorKey,
      home: const MainScreen(),
    );
  }
}
