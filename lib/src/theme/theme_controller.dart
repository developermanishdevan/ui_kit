import 'package:flutter/material.dart';

/// Simple ValueNotifier-based theme controller.
/// Wrap your MaterialApp with a ValueListenableBuilder to react to changes.
///
/// Usage:
/// ```dart
/// ValueListenableBuilder<ThemeMode>(
///   valueListenable: AppThemeController.instance,
///   builder: (context, mode, _) => MaterialApp(
///     themeMode: mode,
///     theme: AppTheme.light,
///     darkTheme: AppTheme.dark,
///     ...
///   ),
/// )
/// ```
class AppThemeController extends ValueNotifier<ThemeMode> {
  AppThemeController._() : super(ThemeMode.system);

  static final AppThemeController instance = AppThemeController._();

  bool get isDark => value == ThemeMode.dark;
  bool get isLight => value == ThemeMode.light;
  bool get isSystem => value == ThemeMode.system;

  void setLight() => value = ThemeMode.light;
  void setDark() => value = ThemeMode.dark;
  void setSystem() => value = ThemeMode.system;

  void toggle() {
    value = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
