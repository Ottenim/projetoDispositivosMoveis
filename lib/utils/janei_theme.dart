import 'package:flutter/material.dart';

class JaneiTheme {
  static ThemeData theme() {
    return ThemeData(
      primaryColor: const Color(0xff131313),
      scaffoldBackgroundColor: const Color(0xff131313),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          decoration: TextDecoration.none,
          decorationStyle: null,
          decorationThickness: 0,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: 'Urbanist',
          fontSize: 12.8,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: Color(0xff8e8e8e),
          fontWeight: FontWeight.w500,
          fontFamily: 'Urbanist',
          fontSize: 12.8,
        ),
      ),
    );
  }
}
