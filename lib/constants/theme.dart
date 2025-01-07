import 'package:flutter/material.dart';

export './colors.dart';
export './radius.dart';
export './spacing.dart';
export './text_styles.dart';

class AppTheme {
  static final light = ThemeData(
    colorSchemeSeed: Colors.blue,
    cardTheme: const CardTheme(
      margin: EdgeInsets.all(0),
    ),
  );
}
