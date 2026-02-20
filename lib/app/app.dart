import 'package:flutter/material.dart';

/// Minimal App widget. Use this as the entry point for the feature-driven app.
/// This file purposely keeps logic small so it can be composed into the
/// existing `main.dart` in the project (don't remove the current main).
class MyApp extends StatelessWidget {
  final Widget home;
  final ThemeMode themeMode;

  const MyApp({Key? key, required this.home, this.themeMode = ThemeMode.system}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VikiTalkie',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      ),
      themeMode: themeMode,
      home: home,
    );
  }
}
