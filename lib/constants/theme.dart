import 'package:flutter/material.dart';
import 'package:gofund/constants/radius.dart';
import 'package:gofund/constants/text_styles.dart';

export './colors.dart';
export './radius.dart';
export './spacing.dart';
export './text_styles.dart';

class AppTheme {
  static final light = ThemeData(
    colorSchemeSeed: colorSchemeSeed,
    appBarTheme: AppBarTheme(
      titleTextStyle: AppTextStyles.headline.copyWith(
        color: Colors.black,
      ),
      // foregroundColor: Colors.black,
    ),
    cardTheme: cardTheme,
  );

  static const Color colorSchemeSeed = Colors.blue;
  static const CardTheme cardTheme = CardTheme(
    margin: EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.mediumRadius,
    ),
  );
}
