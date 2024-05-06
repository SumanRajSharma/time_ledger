import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    // Larger display text gets a lighter font weight
    displayLarge: GoogleFonts.urbanist(
      fontSize: 57,
      fontWeight: FontWeight.w300, // Lighter weight for large text
      color: Colors.black87,
    ),
    displayMedium: GoogleFonts.urbanist(
      fontSize: 45,
      fontWeight: FontWeight.w400, // Normal weight for medium size display
      color: Colors.black87,
    ),
    displaySmall: GoogleFonts.urbanist(
      fontSize: 36,
      fontWeight: FontWeight.w500, // Medium weight for smaller display text
      color: Colors.black87,
    ),
    // Headline styles usually benefit from a bit more weight to stand out
    headlineLarge: GoogleFonts.urbanist(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headlineMedium: GoogleFonts.urbanist(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headlineSmall: GoogleFonts.urbanist(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    ),
    // Title styles typically use medium weights
    titleLarge: GoogleFonts.urbanist(
      color: Colors.black54,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.urbanist(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.urbanist(
      color: Colors.black54,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    // Body styles should be easily readable at smaller sizes
    bodyLarge: GoogleFonts.urbanist(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.urbanist(
      color: Colors.black54,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.urbanist(
      color: Colors.black54,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    // Label styles can be slightly bold to enhance readability at small sizes
    labelLarge: GoogleFonts.urbanist(
      color: Colors.black54,
      fontSize: 18,
      fontWeight: FontWeight.w200,
    ),
    labelMedium: GoogleFonts.urbanist(
      color: Colors.black54,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.urbanist(
      color: Colors.black54,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),
  );
}
