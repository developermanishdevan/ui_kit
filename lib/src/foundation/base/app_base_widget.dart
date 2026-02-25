import 'package:flutter/material.dart';

/// Abstract base for all stateless UI Kit widgets.
/// Provides convenience accessors for theme, colors, and text styles.
abstract class AppBaseWidget extends StatelessWidget {
  const AppBaseWidget({super.key});

  // Theme convenience
  ThemeData theme(BuildContext context) => Theme.of(context);
  ColorScheme colors(BuildContext context) => Theme.of(context).colorScheme;
  TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
  bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
