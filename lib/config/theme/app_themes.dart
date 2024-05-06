import 'package:flutter/material.dart';
import 'package:time_ledger/config/theme/app_text_themes.dart';
import 'app_colors.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: AppColors.myCustomColorScheme,
      fontFamily: 'Muli',
      textTheme: AppTextTheme.lightTextTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.secondaryColor,
      ),
      appBarTheme: appBarTheme(),
      elevatedButtonTheme: elevatedButtonTheme());
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: AppColors.background,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.secondaryColor),
    titleTextStyle: TextStyle(color: AppColors.secondaryColor, fontSize: 18),
  );
}

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
      foregroundColor: MaterialStateProperty.all(AppColors.onSecondary),
    ),
  );
}
