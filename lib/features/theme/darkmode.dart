import 'package:flutter/material.dart';

ThemeData darkmode = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF0B2545),
    primary: Color(0xFF90CAF9), // light blue accent
    secondary: Color(0xFF1B3658), // card surface
    tertiary: Color(0xFF0B2545),
    inversePrimary: Color(0xFF0D47A1),
  ),
  scaffoldBackgroundColor: const Color(0xFF0B2545),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xFF90CAF9),
    elevation: 0,
  ),
  cardColor: const Color(0xFF10293F),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF90CAF9),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
);
