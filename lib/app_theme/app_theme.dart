import 'package:flutter/material.dart';
import 'package:pms/app_theme/app_colors.dart';

class AppTheme {
  static ThemeData kLightTheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.kwhiteColor,
    // splashColor: AppColors.kPrimaryColor.withOpacity(0.1),
    dividerTheme: DividerThemeData(
      color: AppColors.kPrimaryColor,
      space: 0,
      thickness: 0.8,
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.kPrimaryColor,
        foregroundColor: AppColors.kwhiteColor,
        centerTitle: false,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ))),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.kPrimaryColor,
    ),
  );
  static ThemeData kDarkTheme = ThemeData.dark(useMaterial3: true).copyWith();
}
