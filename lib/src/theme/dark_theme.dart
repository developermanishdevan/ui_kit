import 'package:flutter/material.dart';
import '../foundation/tokens/colors/app_colors.dart';
import '../foundation/tokens/typography/app_typography.dart';
import '../foundation/tokens/radius/app_radius.dart';
import '../foundation/tokens/spacing/app_spacing.dart';
import '../foundation/tokens/shadows/app_shadows.dart';
import '../foundation/tokens/border_styles/app_border_styles.dart';
import '../foundation/tokens/breakpoints/app_breakpoints.dart';
import '../foundation/tokens/durations/app_durations.dart';
import '../foundation/tokens/elevation/app_elevation.dart';
import '../foundation/tokens/gradients/app_gradients.dart';
import '../foundation/tokens/icon_sizes/app_icon_sizes.dart';
import '../foundation/tokens/opacity/app_opacity.dart';
import '../foundation/tokens/z_index/app_z_index.dart';
import '../foundation/config/app_ui_config.dart';
import 'theme_extensions.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: AppUiConfig.useMaterial3,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.bodyBgDark,
  fontFamily: AppTypography.fontFamily,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.gray900,
    error: AppColors.danger,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.bodyColorDark,
    onError: AppColors.white,
  ),
  textTheme: TextTheme(
    displayLarge: AppTypography.h1,
    displayMedium: AppTypography.h2,
    displaySmall: AppTypography.h3,
    headlineMedium: AppTypography.h4,
    headlineSmall: AppTypography.h5,
    titleLarge: AppTypography.h6,
    bodyLarge: AppTypography.bodyLg,
    bodyMedium: AppTypography.bodyBase,
    bodySmall: AppTypography.bodySm,
  ),
  extensions: <ThemeExtension<dynamic>>[
    const AppColorsExtension(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      success: AppColors.success,
      warning: AppColors.warning,
      danger: AppColors.danger,
      info: AppColors.info,
      light: AppColors.light,
      dark: AppColors.dark,
      bodyBg: AppColors.bodyBgDark,
      bodyColor: AppColors.bodyColorDark,
      bodySecondaryColor: AppColors.bodySecondaryColorDark,
      bodySecondaryBg: AppColors.bodySecondaryBgDark,
      borderColor: AppColors.borderColorDark,
      borderColorTranslucent: AppColors.borderColorTranslucentDark,
      textEmphasis: AppColors.gray300,
      bgSubtle: AppColors.gray800,
    ),
    AppTypographyExtension(
      h1: AppTypography.h1,
      h2: AppTypography.h2,
      h3: AppTypography.h3,
      h4: AppTypography.h4,
      h5: AppTypography.h5,
      h6: AppTypography.h6,
      bodyXs: AppTypography.bodyXs,
      bodySm: AppTypography.bodySm,
      bodyBase: AppTypography.bodyBase,
      bodyLg: AppTypography.bodyLg,
    ),
    const AppSpacingExtension(
      s1: AppSpacing.s1,
      s2: AppSpacing.s2,
      s3: AppSpacing.s3,
      s4: AppSpacing.s4,
      s5: AppSpacing.s5,
    ),
    AppRadiusExtension(
      base: AppRadius.baseRadius,
      sm: AppRadius.smRadius,
      lg: AppRadius.lgRadius,
      xl: AppRadius.xlRadius,
      xxl: AppRadius.xxlRadius,
      pill: AppRadius.pillRadius,
    ),
    const AppShadowsExtension(
      base: AppShadows.base, // Can adjust if dark theme shadows should differ
      sm: AppShadows.sm,
      lg: AppShadows.lg,
    ),
    const AppBorderStylesExtension(
      none: AppBorderStyles.none,
      solidThin: AppBorderStyles.solidThin,
      solidMedium: AppBorderStyles.solidMedium,
      solidThick: AppBorderStyles.solidThick,
    ),
    const AppBreakpointsExtension(
      xs: AppBreakpoints.xs,
      sm: AppBreakpoints.sm,
      md: AppBreakpoints.md,
      lg: AppBreakpoints.lg,
      xl: AppBreakpoints.xl,
      xxl: AppBreakpoints.xxl,
    ),
    const AppDurationsExtension(
      quickest: AppDurations.quickest,
      quick: AppDurations.quick,
      normal: AppDurations.normal,
      slow: AppDurations.slow,
      slowest: AppDurations.slowest,
    ),
    const AppElevationExtension(
      none: AppElevation.none,
      level1: AppElevation.level1,
      level2: AppElevation.level2,
      level3: AppElevation.level3,
      level4: AppElevation.level4,
      level5: AppElevation.level5,
    ),
    const AppGradientsExtension(
      brand: AppGradients.brand,
      soft: AppGradients.soft,
      success: AppGradients.success,
      error: AppGradients.error,
    ),
    const AppIconSizesExtension(
      xs: AppIconSizes.xs,
      sm: AppIconSizes.sm,
      md: AppIconSizes.md,
      lg: AppIconSizes.lg,
      xl: AppIconSizes.xl,
      xxl: AppIconSizes.xxl,
    ),
    const AppOpacityExtension(
      transparent: AppOpacity.transparent,
      semiTransparent: AppOpacity.semiTransparent,
      moderate: AppOpacity.moderate,
      distinct: AppOpacity.distinct,
      almostSolid: AppOpacity.almostSolid,
      hover: AppOpacity.hover,
      focus: AppOpacity.focus,
    ),
    const AppZIndexExtension(
      background: AppZIndex.background,
      normal: AppZIndex.normal,
      dropdown: AppZIndex.dropdown,
      sticky: AppZIndex.sticky,
      fixed: AppZIndex.fixed,
      modalBackdrop: AppZIndex.modalBackdrop,
      modal: AppZIndex.modal,
      popover: AppZIndex.popover,
      tooltip: AppZIndex.tooltip,
    ),
  ],
);
