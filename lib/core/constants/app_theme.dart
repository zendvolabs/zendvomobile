import 'package:flutter/material.dart';

class AppTheme {
  static const String fontFamily = 'BR Firma';

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF5E49E2),
        primary: const Color(0xFF5E49E2),
      ),
      textTheme: const TextTheme(
        // You can customize specific text styles here if needed
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF5E49E2),
        brightness: Brightness.dark,
      ),
    );
  }
}
