import 'package:flutter/material.dart';

class AppTheme {
  static const Color gradientStart = Color(0xFF004D61);
  static const Color gradientEnd = Colors.white;
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF004D61), // color-bg-blue
    scaffoldBackgroundColor: const Color(
      0xFFE4EDE3,
    ), // color-bg-green
    fontFamily: 'Inter',

    colorScheme: const ColorScheme.light(
      primary: Color(0xFF004D61), // azul mais escuro
      secondary: Color(0xFFFF5031), // laranja
      surface: Color(0xFFF5F5F5), // branco de fundo
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF444444), // texto escuro
      onError: Colors.white,
      brightness: Brightness.light,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ), // h1
      displayMedium: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ), // h2
      displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ), // h3
      bodyLarge: TextStyle(fontSize: 18.0),
      bodyMedium: TextStyle(fontSize: 16.0),
      bodySmall: TextStyle(fontSize: 13.0),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF47A138), // verde (quinary)
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF47A138),
        side: const BorderSide(color: Color(0xFF47A138)),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF004D61)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF004D61),
          width: 2,
        ),
      ),
      labelStyle: const TextStyle(color: Color(0xFF004D61)),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}
