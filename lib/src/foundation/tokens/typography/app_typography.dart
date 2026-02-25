import 'package:flutter/material.dart';

/// Font size and weight constants.
abstract final class AppTypography {
  // ── Font Family ──────────────────────────────────────────────────────────
  static const String fontFamily = 'Inter'; // or your chosen font

  // ── Font Sizes ───────────────────────────────────────────────────────────
  static const double size2xs = 10.0;
  static const double sizeXs = 12.0;
  static const double sizeSm = 14.0;
  static const double sizeMd = 16.0;
  static const double sizeLg = 18.0;
  static const double sizeXl = 20.0;
  static const double size2xl = 24.0;
  static const double size3xl = 30.0;
  static const double size4xl = 36.0;
  static const double size5xl = 48.0;
  static const double size6xl = 60.0;
  static const double size7xl = 72.0;

  // ── Font Weights ─────────────────────────────────────────────────────────
  static const FontWeight weightThin = FontWeight.w100;
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightExtraBold = FontWeight.w800;
  static const FontWeight weightBlack = FontWeight.w900;

  // ── Line Heights ─────────────────────────────────────────────────────────
  static const double lineHeightTight = 1.2;
  static const double lineHeightSnug = 1.375;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.625;
  static const double lineHeightLoose = 2.0;

  // ── Letter Spacing ───────────────────────────────────────────────────────
  static const double trackingTight = -0.05;
  static const double trackingNormal = 0.0;
  static const double trackingWide = 0.025;
  static const double trackingWider = 0.05;
  static const double trackingWidest = 0.1;

  // ── Semantic Text Styles ─────────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontSize: size5xl,
    fontWeight: weightBold,
    height: lineHeightTight,
    letterSpacing: trackingTight,
  );
  static const TextStyle displayMedium = TextStyle(
    fontSize: size4xl,
    fontWeight: weightBold,
    height: lineHeightTight,
  );
  static const TextStyle displaySmall = TextStyle(
    fontSize: size3xl,
    fontWeight: weightSemiBold,
    height: lineHeightTight,
  );
  static const TextStyle headlineLarge = TextStyle(
    fontSize: size2xl,
    fontWeight: weightSemiBold,
    height: lineHeightSnug,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontSize: sizeXl,
    fontWeight: weightSemiBold,
    height: lineHeightSnug,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontSize: sizeLg,
    fontWeight: weightSemiBold,
    height: lineHeightSnug,
  );
  static const TextStyle titleLarge = TextStyle(
    fontSize: sizeMd,
    fontWeight: weightSemiBold,
    height: lineHeightNormal,
  );
  static const TextStyle titleMedium = TextStyle(
    fontSize: sizeSm,
    fontWeight: weightSemiBold,
    height: lineHeightNormal,
  );
  static const TextStyle titleSmall = TextStyle(
    fontSize: sizeXs,
    fontWeight: weightSemiBold,
    height: lineHeightNormal,
    letterSpacing: trackingWide,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: sizeMd,
    fontWeight: weightRegular,
    height: lineHeightRelaxed,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: sizeSm,
    fontWeight: weightRegular,
    height: lineHeightRelaxed,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: sizeXs,
    fontWeight: weightRegular,
    height: lineHeightRelaxed,
  );
  static const TextStyle labelLarge = TextStyle(
    fontSize: sizeSm,
    fontWeight: weightMedium,
    height: lineHeightNormal,
    letterSpacing: trackingWide,
  );
  static const TextStyle labelMedium = TextStyle(
    fontSize: sizeXs,
    fontWeight: weightMedium,
    height: lineHeightNormal,
    letterSpacing: trackingWide,
  );
  static const TextStyle labelSmall = TextStyle(
    fontSize: size2xs,
    fontWeight: weightMedium,
    height: lineHeightNormal,
    letterSpacing: trackingWider,
  );
  static const TextStyle caption = TextStyle(
    fontSize: sizeXs,
    fontWeight: weightRegular,
    height: lineHeightNormal,
    letterSpacing: trackingWide,
  );
  static const TextStyle overline = TextStyle(
    fontSize: size2xs,
    fontWeight: weightSemiBold,
    height: lineHeightNormal,
    letterSpacing: trackingWidest,
  );
  static const TextStyle code = TextStyle(
    fontSize: sizeSm,
    fontWeight: weightRegular,
    fontFamily: 'monospace',
    height: lineHeightRelaxed,
  );
}
