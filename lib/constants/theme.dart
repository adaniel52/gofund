import 'package:flutter/material.dart';
import 'package:gofund/constants/text_styles.dart';

export './colors.dart';
export './radius.dart';
export './spacing.dart';
export './text_styles.dart';

class AppTheme {
  static final generic = ThemeData(
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      titleTextStyle: AppTextStyles.headline,
    ),
    cardTheme: const CardTheme(
      margin: EdgeInsets.all(0),
    ),
  );

  // static final light = generic.copyWith(
  //   appBarTheme: AppBarTheme(
  //     titleTextStyle: AppTextStyles.headline.copyWith(
  //       color: Colors.black,
  //     ),
  //   ),
  // );

  // static final dark = generic.copyWith(
  //   brightness: Brightness.dark,
  // );
}
