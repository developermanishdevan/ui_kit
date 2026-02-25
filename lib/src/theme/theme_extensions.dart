import 'package:flutter/material.dart';
import '../foundation/tokens/colors/app_colors.dart';
import '../foundation/tokens/spacing/app_spacing.dart';

// ─────────────────────────────────────────────────────────
// AppColorsExtension — custom colors beyond ColorScheme
// ─────────────────────────────────────────────────────────
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.success,
    required this.successLight,
    required this.warning,
    required this.warningLight,
    required this.info,
    required this.infoLight,
    required this.textTertiary,
    required this.surfaceVariant,
    required this.borderDefault,
    required this.overlayLight,
    required this.overlayDark,
  });

  final Color success;
  final Color successLight;
  final Color warning;
  final Color warningLight;
  final Color info;
  final Color infoLight;
  final Color textTertiary;
  final Color surfaceVariant;
  final Color borderDefault;
  final Color overlayLight;
  final Color overlayDark;

  @override
  AppColorsExtension copyWith({
    Color? success,
    Color? successLight,
    Color? warning,
    Color? warningLight,
    Color? info,
    Color? infoLight,
    Color? textTertiary,
    Color? surfaceVariant,
    Color? borderDefault,
    Color? overlayLight,
    Color? overlayDark,
  }) {
    return AppColorsExtension(
      success: success ?? this.success,
      successLight: successLight ?? this.successLight,
      warning: warning ?? this.warning,
      warningLight: warningLight ?? this.warningLight,
      info: info ?? this.info,
      infoLight: infoLight ?? this.infoLight,
      textTertiary: textTertiary ?? this.textTertiary,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      borderDefault: borderDefault ?? this.borderDefault,
      overlayLight: overlayLight ?? this.overlayLight,
      overlayDark: overlayDark ?? this.overlayDark,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      successLight: Color.lerp(successLight, other.successLight, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningLight: Color.lerp(warningLight, other.warningLight, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoLight: Color.lerp(infoLight, other.infoLight, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      overlayLight: Color.lerp(overlayLight, other.overlayLight, t)!,
      overlayDark: Color.lerp(overlayDark, other.overlayDark, t)!,
    );
  }

  // ── Default light instance ────────────────────────
  static const AppColorsExtension light = AppColorsExtension(
    success: AppColors.success,
    successLight: AppColors.successLight,
    warning: AppColors.warning,
    warningLight: AppColors.warningLight,
    info: AppColors.info,
    infoLight: AppColors.infoLight,
    textTertiary: AppColors.textTertiary,
    surfaceVariant: AppColors.surfaceVariant,
    borderDefault: AppColors.borderDefault,
    overlayLight: AppColors.overlayLight,
    overlayDark: AppColors.overlayDark,
  );

  // ── Default dark instance ─────────────────────────
  static const AppColorsExtension dark = AppColorsExtension(
    success: AppColors.green500,
    successLight: Color(0xFF14532D),
    warning: AppColors.amber500,
    warningLight: Color(0xFF451A03),
    info: AppColors.blue400,
    infoLight: Color(0xFF1E3A5F),
    textTertiary: AppColors.grey500,
    surfaceVariant: AppColors.darkSurfaceVariant,
    borderDefault: AppColors.darkBorderDefault,
    overlayLight: Color(0x1AFFFFFF),
    overlayDark: AppColors.overlayDark,
  );
}

// ─────────────────────────────────────────────────────────
// AppSpacingExtension
// ─────────────────────────────────────────────────────────
@immutable
class AppSpacingExtension extends ThemeExtension<AppSpacingExtension> {
  const AppSpacingExtension({
    required this.pagePadding,
    required this.sectionGap,
    required this.cardPadding,
    required this.inputPadding,
    required this.buttonPaddingH,
    required this.buttonPaddingV,
  });

  final double pagePadding;
  final double sectionGap;
  final double cardPadding;
  final double inputPadding;
  final double buttonPaddingH;
  final double buttonPaddingV;

  @override
  AppSpacingExtension copyWith({
    double? pagePadding,
    double? sectionGap,
    double? cardPadding,
    double? inputPadding,
    double? buttonPaddingH,
    double? buttonPaddingV,
  }) =>
      AppSpacingExtension(
        pagePadding: pagePadding ?? this.pagePadding,
        sectionGap: sectionGap ?? this.sectionGap,
        cardPadding: cardPadding ?? this.cardPadding,
        inputPadding: inputPadding ?? this.inputPadding,
        buttonPaddingH: buttonPaddingH ?? this.buttonPaddingH,
        buttonPaddingV: buttonPaddingV ?? this.buttonPaddingV,
      );

  @override
  AppSpacingExtension lerp(AppSpacingExtension? other, double t) => this;

  static const AppSpacingExtension defaults = AppSpacingExtension(
    pagePadding: AppSpacing.base,
    sectionGap: AppSpacing.xl2,
    cardPadding: AppSpacing.base,
    inputPadding: AppSpacing.sm,
    buttonPaddingH: AppSpacing.xl,
    buttonPaddingV: AppSpacing.md,
  );

  static const AppSpacingExtension compact = AppSpacingExtension(
    pagePadding: AppSpacing.sm,
    sectionGap: AppSpacing.xl,
    cardPadding: AppSpacing.sm,
    inputPadding: AppSpacing.xs,
    buttonPaddingH: AppSpacing.base,
    buttonPaddingV: AppSpacing.sm,
  );
}

// ─────────────────────────────────────────────────────────
// Context extension — easy access
// ─────────────────────────────────────────────────────────
extension AppThemeContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Size get screenSize => MediaQuery.sizeOf(this);

  AppColorsExtension get appColors =>
      Theme.of(this).extension<AppColorsExtension>()!;

  AppSpacingExtension get appSpacing =>
      Theme.of(this).extension<AppSpacingExtension>()!;
}
