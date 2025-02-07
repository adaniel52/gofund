import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: _colorSchemeSeed,
        textTheme: _textTheme,
        filledButtonTheme: _filledButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        dialogTheme: _dialogThemeData,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: _colorSchemeSeed,
        textTheme: _textTheme,
        filledButtonTheme: _filledButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        dialogTheme: _dialogThemeData,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      );

  static const _colorSchemeSeed = Colors.blue;

  static const _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
  );

  static final _filledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.largeRadius,
      ),
    ),
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: AppRadius.largeRadius,
    ),
  );

  static const _dialogThemeData = DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.largeRadius,
    ),
  );
}

class AppSpacing {
  static const small = 8.0;
  static const medium = 12.0;
  static const large = 16.0;

  static const smallPadding = EdgeInsets.all(small);
  static const mediumPadding = EdgeInsets.all(medium);
  static const largePadding = EdgeInsets.all(large);
}

class AppRadius {
  static const _small = 4.0;
  static const _medium = 8.0;
  static const _large = 12.0;

  static const smallRadius = BorderRadius.all(Radius.circular(_small));
  static const mediumRadius = BorderRadius.all(Radius.circular(_medium));
  static const largeRadius = BorderRadius.all(Radius.circular(_large));
}
