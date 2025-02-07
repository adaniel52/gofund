import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _theme = ThemeMode.system;

  ThemeMode get theme => _theme;

  void setTheme(ThemeMode theme) {
    _theme = theme;
    notifyListeners();
  }
}

String mapThemeModeToString(ThemeMode theme) {
  switch (theme) {
    case ThemeMode.light:
      return 'Light';
    case ThemeMode.dark:
      return 'Dark';
    default:
      return 'System';
  }
}
