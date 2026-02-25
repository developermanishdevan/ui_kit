import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';

enum AppTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
  caption,
  overline,
  code,
}

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.align,
    this.overflow,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.letterSpacing,
    this.decoration,
    this.softWrap,
  });

  final String data;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? height;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final bool? softWrap;

  static const _styles = {
    AppTextVariant.displayLarge: AppTypography.displayLarge,
    AppTextVariant.displayMedium: AppTypography.displayMedium,
    AppTextVariant.displaySmall: AppTypography.displaySmall,
    AppTextVariant.headlineLarge: AppTypography.headlineLarge,
    AppTextVariant.headlineMedium: AppTypography.headlineMedium,
    AppTextVariant.headlineSmall: AppTypography.headlineSmall,
    AppTextVariant.titleLarge: AppTypography.titleLarge,
    AppTextVariant.titleMedium: AppTypography.titleMedium,
    AppTextVariant.titleSmall: AppTypography.titleSmall,
    AppTextVariant.bodyLarge: AppTypography.bodyLarge,
    AppTextVariant.bodyMedium: AppTypography.bodyMedium,
    AppTextVariant.bodySmall: AppTypography.bodySmall,
    AppTextVariant.labelLarge: AppTypography.labelLarge,
    AppTextVariant.labelMedium: AppTypography.labelMedium,
    AppTextVariant.labelSmall: AppTypography.labelSmall,
    AppTextVariant.caption: AppTypography.caption,
    AppTextVariant.overline: AppTypography.overline,
    AppTextVariant.code: AppTypography.code,
  };

  @override
  Widget build(BuildContext context) {
    final base = _styles[variant] ?? AppTypography.bodyMedium;
    return Text(
      data,
      style: base.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
        decoration: decoration,
      ),
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
