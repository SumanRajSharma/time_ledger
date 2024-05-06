import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFD7EC79);
  static const Color secondaryColor = Color(0xFF161616);
  static const Color tertiaryColor = Color(0xFFffc4ac);

  static const Color onPrimary = Color(0xFF161616);
  static const Color onSecondary = Colors.white;
  static const Color onTertiary = Color(0xFF161616);

  static const Color errorColor = Color(0xFFFF4C54);
  static const Color background = Color.fromARGB(255, 245, 245, 245);
  static const Color surface = Colors.white;

  static const Color onError = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF1A1A1F);
  static const Color onSurface = Color(0xFF1A1A1F);

  static const Color navBar = Color(0xFFFDFEF2);
  static const Color blue = Color(0xFF007AFF);

  static ColorScheme myCustomColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: onPrimary,
    secondary: secondaryColor,
    onSecondary: onSecondary,
    tertiary: tertiaryColor,
    onTertiary: onTertiary,
    error: errorColor,
    onError: onError,
    background: background,
    onBackground: onBackground,
    surface: surface,
    onSurface: onSurface,
    surfaceVariant: tertiaryColor,
    onSurfaceVariant: onTertiary,
    primaryContainer: navBar,
    outline: blue,
  );
}
