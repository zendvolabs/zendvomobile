import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF5E49E2);
  static const Color primaryLight = Color(0xFFF3F2FF);
  static const Color activeBorder = primary;
  static const Color background = lightBackground; // Fallback for legacy code

  // Semantic Colors
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);

  // Light Mode Colors
  static const Color lightBackground = Colors.white;
  static const Color lightTextHeading = Color(0xFF1A1A1A);
  static const Color lightTextBody = Color(0xFF4A4A4A);
  static const Color lightFieldBackground = Color(0xFFF9F9F9);
  static const Color lightInactiveBorder = Color(0xFFE0E0E0);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkTextHeading = Color(0xFFFFFFFF);
  static const Color darkTextBody = Color(0xFFB0B0B0);
  static const Color darkFieldBackground = Color(0xFF1E1E1E);
  static const Color darkInactiveBorder = Color(0xFF333333);

  // Theme Helpers
  static Color getBackgroundColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkBackground
      : lightBackground;

  static Color getHeadingTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkTextHeading
      : lightTextHeading;

  static Color getBodyTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkTextBody
      : lightTextBody;

  static Color getFieldBackgroundColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkFieldBackground
      : lightFieldBackground;

  static Color getInactiveBorderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkInactiveBorder
      : lightInactiveBorder;
}
