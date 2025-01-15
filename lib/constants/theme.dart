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
    appBarTheme: appBarTheme.copyWith(
      titleTextStyle: AppTextStyles.headline.copyWith(
        color: Colors.black,
      ),
    ),
    cardTheme: cardTheme,
  );

  static final dark = ThemeData(
    colorSchemeSeed: colorSchemeSeed,
    brightness: Brightness.dark,
    appBarTheme: appBarTheme,
    cardTheme: cardTheme,
  );

  static const Color colorSchemeSeed = Colors.blue;

  static const AppBarTheme appBarTheme = AppBarTheme(
    centerTitle: true,
    titleTextStyle: AppTextStyles.headline,
  );

  static const CardTheme cardTheme = CardTheme(
    margin: EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.mediumRadius,
    ),
  );
}
