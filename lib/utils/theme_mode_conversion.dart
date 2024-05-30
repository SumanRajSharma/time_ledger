import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/presentation/pages/profile/profile_screen.dart';

ThemeMode mapThemeOptionsToThemeMode(ThemeOptions themeOption) {
  switch (themeOption) {
    case ThemeOptions.light:
      return ThemeMode.light;
    case ThemeOptions.dark:
      return ThemeMode.dark;
    case ThemeOptions.system:
    default:
      return ThemeMode.system;
  }
}

ThemeOptions mapThemeModeToThemeOptions(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.light:
      return ThemeOptions.light;
    case ThemeMode.dark:
      return ThemeOptions.dark;
    case ThemeMode.system:
    default:
      return ThemeOptions.system;
  }
}
