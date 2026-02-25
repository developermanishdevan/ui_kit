import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

/// Central theme accessor.
class AppTheme {
  const AppTheme._();

  static final ThemeData light = buildLightTheme();
  static final ThemeData dark = buildDarkTheme();

  /// Create a custom light theme with your own colors.
  static ThemeData customLight({
    Color? primary,
    Color? secondary,
    Color? surface,
    String? fontFamily,
  }) =>
      buildLightTheme(
        primary: primary,
        secondary: secondary,
        surface: surface,
        fontFamily: fontFamily,
      );

  /// Create a custom dark theme with your own colors.
  static ThemeData customDark({
    Color? primary,
    Color? secondary,
    Color? surface,
    String? fontFamily,
  }) =>
      buildDarkTheme(
        primary: primary,
        secondary: secondary,
        surface: surface,
        fontFamily: fontFamily,
      );

  /// Returns light or dark theme based on brightness.
  static ThemeData of(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;
}
