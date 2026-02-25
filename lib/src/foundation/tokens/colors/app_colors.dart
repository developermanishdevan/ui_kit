import 'package:flutter/material.dart';

/// Central color palette for the UI Kit.
/// Use semantic aliases (e.g. [AppColors.primary]) in components,
/// and raw palette values (e.g. [AppColors.blue500]) only in token definitions.
abstract final class AppColors {
  // ── Raw Palette ──────────────────────────────────────────────────────────
  // Blue
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue200 = Color(0xFFBFDBFE);
  static const Color blue300 = Color(0xFF93C5FD);
  static const Color blue400 = Color(0xFF60A5FA);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue600 = Color(0xFF2563EB);
  static const Color blue700 = Color(0xFF1D4ED8);
  static const Color blue800 = Color(0xFF1E40AF);
  static const Color blue900 = Color(0xFF1E3A8A);

  // Neutral / Grey
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // Green
  static const Color green50 = Color(0xFFF0FDF4);
  static const Color green500 = Color(0xFF22C55E);
  static const Color green600 = Color(0xFF16A34A);
  static const Color green700 = Color(0xFF15803D);

  // Red
  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red500 = Color(0xFFEF4444);
  static const Color red600 = Color(0xFFDC2626);
  static const Color red700 = Color(0xFFB91C1C);

  // Amber / Warning
  static const Color amber50 = Color(0xFFFFFBEB);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber600 = Color(0xFFD97706);

  // Purple
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color purple600 = Color(0xFF7C3AED);

  // Transparent
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ── Semantic Aliases (Light) ─────────────────────────────────────────────
  static const Color primary = blue600;
  static const Color primaryLight = blue100;
  static const Color primaryDark = blue800;

  static const Color secondary = purple600;
  static const Color secondaryLight = Color(0xFFEDE9FE);

  static const Color success = green600;
  static const Color successLight = green50;

  static const Color error = red600;
  static const Color errorLight = red50;

  static const Color warning = amber600;
  static const Color warningLight = amber50;

  static const Color info = blue500;
  static const Color infoLight = blue50;

  // Surfaces
  static const Color surface = white;
  static const Color surfaceVariant = grey50;
  static const Color surfaceDark = grey900;

  // Text
  static const Color textPrimary = grey900;
  static const Color textSecondary = grey600;
  static const Color textTertiary = grey400;
  static const Color textOnPrimary = white;
  static const Color textOnDark = grey100;

  // Border
  static const Color borderDefault = grey200;
  static const Color borderFocused = blue500;
  static const Color borderError = red500;

  // Overlay
  static const Color overlayLight = Color(0x1A000000); // 10%
  static const Color overlayMedium = Color(0x4D000000); // 30%
  static const Color overlayDark = Color(0x80000000); // 50%

  // ── Semantic Aliases (Dark) ──────────────────────────────────────────────
  static const Color darkPrimary = blue400;
  static const Color darkSurface = grey900;
  static const Color darkSurfaceVariant = grey800;
  static const Color darkTextPrimary = grey50;
  static const Color darkTextSecondary = grey400;
  static const Color darkBorderDefault = grey700;
}
