import 'package:flutter/material.dart';

class ColorTheme {
  static final _kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 196, 59, 59),
  );

  static final _kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(1, 1, 1, 1),
  );

  static ThemeData fetchColorScheme() {
    return ThemeData(useMaterial3: true).copyWith(
      colorScheme: _kColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: _kColorScheme.primary,
        titleTextStyle: TextStyle(
          color: _kColorScheme.background,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: _kColorScheme.background),
      ),
      cardTheme: const CardTheme().copyWith(
        color: _kColorScheme.onSecondary,
      ),
      textTheme: const TextTheme().copyWith(
        bodySmall: TextStyle(
          color: _kColorScheme.inverseSurface,
          fontSize: 13,
        ),
        bodyMedium: TextStyle(
          color: _kColorScheme.inverseSurface,
          fontSize: 14,
        ),
        titleMedium: TextStyle(
          color: _kColorScheme.background,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData().copyWith(
        color: _kColorScheme.inverseSurface,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
        backgroundColor: _kColorScheme.primary,
        foregroundColor: _kColorScheme.background,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _kColorScheme.primary,
          foregroundColor: _kColorScheme.background,
        ),
      ),
    );
  }

  static ThemeData fetchDarkColorScheme() {
    return ThemeData(useMaterial3: true).copyWith(
      colorScheme: _kDarkColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: _kDarkColorScheme.background,
        titleTextStyle: TextStyle(
          color: _kDarkColorScheme.inverseSurface,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: _kDarkColorScheme.inverseSurface),
      ),
      cardTheme: const CardTheme().copyWith(
        color: _kDarkColorScheme.onInverseSurface,
      ),
      textTheme: const TextTheme().copyWith(
        bodySmall: TextStyle(
          color: _kDarkColorScheme.background,
          fontSize: 13,
        ),
        bodyMedium: TextStyle(
          color: _kDarkColorScheme.inverseSurface,
          fontSize: 14,
        ),
        titleMedium: TextStyle(
          color: _kDarkColorScheme.inverseSurface,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: const IconThemeData().copyWith(
        color: _kDarkColorScheme.inverseSurface,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
        backgroundColor: _kDarkColorScheme.background,
        foregroundColor: _kDarkColorScheme.inverseSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _kDarkColorScheme.background,
          foregroundColor: _kDarkColorScheme.secondary,
        ),
      ),
    );
  }
}
