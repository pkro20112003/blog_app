import 'package:flutter/material.dart';
import 'package:zidiointernshipblogapp/core/theme/app_pallete.dart';

class AppTheme {
  static final _border = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppPallete.borderColor,
      width: 3,
    ),
    borderRadius: BorderRadius.circular(10),
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border,
      focusedBorder: _border,
    ),
  );
}
