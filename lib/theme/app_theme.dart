import 'package:flutter/material.dart';

class AppTheme {
  static const textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(fontSize: 14),
    labelMedium: TextStyle(fontSize: 13),
    labelSmall: TextStyle(fontSize: 12),
    bodyLarge: TextStyle(fontSize: 14),
    bodyMedium: TextStyle(fontSize: 13),
    bodySmall: TextStyle(fontSize: 12),
  );

  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );

  static final tooltipThemeData = TooltipThemeData(
    textStyle: const TextStyle(color: Colors.white),
    decoration: const BoxDecoration(color: Colors.black38),
  );

  static final elevatedButtonStyleAuthSocial = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  );

  static final lightColorScheme = const ColorScheme.light(
    primary: Color.fromARGB(255, 30, 58, 138),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    secondary: Color.fromARGB(255, 34, 166, 179),
    onSecondary: Color.fromARGB(255, 255, 255, 255),
    error: Color.fromARGB(255, 211, 47, 47),
    onError: Color.fromARGB(255, 255, 255, 255),
    surface: Color.fromARGB(255, 247, 249, 252),
    onSurface: Color.fromARGB(255, 15, 23, 42),
  );

  static final ColorScheme darkColorScheme = const ColorScheme.dark(
    primary: Color.fromARGB(255, 30, 58, 138),
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    secondary: Color.fromARGB(255, 34, 166, 179),
    onSecondary: Color.fromARGB(255, 255, 255, 255),
    error: Color.fromARGB(255, 239, 68, 68),
    onError: Color.fromARGB(255, 15, 23, 42),
    surface: Color.fromARGB(255, 20, 24, 35),
    onSurface: Color.fromARGB(255, 226, 232, 240),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: const Color.fromARGB(255, 247, 249, 252),
    shadowColor: const Color.fromARGB(255, 15, 23, 42),
    elevatedButtonTheme: elevatedButtonTheme,
    tooltipTheme: tooltipThemeData,
    textTheme: textTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: const Color.fromARGB(255, 16, 19, 29),
    shadowColor: const Color.fromARGB(255, 0, 0, 0),
    elevatedButtonTheme: elevatedButtonTheme,
    tooltipTheme: tooltipThemeData,
    textTheme: textTheme,
  );
}
