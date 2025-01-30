import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/pages/main_page.dart';
import 'package:gofund/providers/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeProvider>(context).theme;
    return MaterialApp(
      title: 'GoFund',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const MainPage(),
    );
  }
}
