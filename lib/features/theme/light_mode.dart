import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFF2F7FF),
    primary: Color(0xFF0D47A1), // deep blue
    secondary: Color(0xFFE3F2FD), // light blue surface for cards
    tertiary: Colors.white,
    inversePrimary: Color(0xFFBBDEFB),
  ),
  scaffoldBackgroundColor: const Color(0xFFF2F7FF),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xFF0D47A1),
    elevation: 0,
  ),
  cardColor: const Color(0xFFFFFFFF),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0D47A1),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
);
