import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
