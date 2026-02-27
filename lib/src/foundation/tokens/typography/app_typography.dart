import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'Play';

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Font Sizes
  static const double sizeXs = 11.0;
  static const double sizeSm = 12.6;
  static const double sizeBase = 14.0;
  static const double sizeLg = 16.0;

  static const double h1Size = 36.0;
  static const double h2Size = 30.0;
  static const double h3Size = 24.0;
  static const double h4Size = 18.0;
  static const double h5Size = 15.0;
  static const double h6Size = 12.0;

  // Line Heights
  static const double lineHeightBase = 1.5;
  static const double lineHeightSm = 1.25;
  static const double lineHeightLg = 2.0;
  static const double lineHeightHeadings = 1.1;

  // Text Styles
  static TextStyle get h1 => const TextStyle(
    fontFamily: fontFamily,
    fontSize: h1Size,
    fontWeight: semiBold,
    height: lineHeightHeadings,
  );

  static TextStyle get h2 => const TextStyle(
    fontFamily: fontFamily,
    fontSize: h2Size,
    fontWeight: semiBold,
    height: lineHeightHeadings,
  );

  static TextStyle get h3 => const TextStyle(
    fontFamily: fontFamily,
    fontSize: h3Size,
    fontWeight: semiBold,
    height: lineHeightHeadings,
  );

  static TextStyle get h4 => const TextStyle(
    fontFamily: fontFamily,
    fontSize: h4Size,
    fontWeight: semiBold,
    height: lineHeightHeadings,
  );

  static TextStyle get h5 => const TextStyle(
    fontFamily: fontFamily,
    fontSize: h5Size,
    fontWeight: semiBold,
    height: lineHeightHeadings,
  );

  static TextStyle get h6 => const TextStyle(
    fontFamily: fontFamily,
    fontSize: h6Size,
    fontWeight: semiBold,
    height: lineHeightHeadings,
  );

  static TextStyle get bodyXs => const TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeXs,
    fontWeight: regular,
    height: lineHeightSm,
  );

  static TextStyle get bodyBase => const TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeBase,
    fontWeight: regular,
    height: lineHeightBase,
  );

  static TextStyle get bodySm => const TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeSm,
    fontWeight: regular,
    height: lineHeightSm,
  );

  static TextStyle get bodyLg => const TextStyle(
    fontFamily: fontFamily,
    fontSize: sizeLg,
    fontWeight: regular,
    height: lineHeightLg,
  );
}
