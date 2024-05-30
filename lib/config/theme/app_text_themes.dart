import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  TextTheme baseTextTheme = Theme.of(context).textTheme;

  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);

  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
    bodyMedium:
        bodyTextTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
    bodySmall: bodyTextTheme.bodySmall?.copyWith(color: colorScheme.onSurface),
    labelLarge:
        bodyTextTheme.labelLarge?.copyWith(color: colorScheme.onSurface),
    labelMedium:
        bodyTextTheme.labelMedium?.copyWith(color: colorScheme.onSurface),
    labelSmall:
        bodyTextTheme.labelSmall?.copyWith(color: colorScheme.onSurface),
    headlineLarge:
        displayTextTheme.headlineLarge?.copyWith(color: colorScheme.onSurface),
    headlineMedium:
        displayTextTheme.headlineMedium?.copyWith(color: colorScheme.onSurface),
    headlineSmall:
        displayTextTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
    titleLarge:
        displayTextTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
    titleMedium:
        displayTextTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
    titleSmall:
        displayTextTheme.titleSmall?.copyWith(color: colorScheme.onSurface),
  );

  return textTheme;
}
