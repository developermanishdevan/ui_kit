import 'package:flutter/material.dart';
import '../foundation/tokens/colors/app_colors.dart';
import '../foundation/tokens/typography/app_typography.dart';
import '../foundation/tokens/radius/app_radius.dart';
import '../foundation/tokens/elevation/app_elevation.dart';
import 'theme_extensions.dart';

ThemeData buildDarkTheme({
  String? fontFamily,
  Color? primary,
  Color? secondary,
  Color? surface,
}) {
  final colorScheme = ColorScheme.dark(
    primary: primary ?? AppColors.darkPrimary,
    onPrimary: AppColors.grey900,
    primaryContainer: (primary ?? AppColors.darkPrimary).withValues(alpha: 0.1),
    onPrimaryContainer: primary ?? AppColors.blue100,
    secondary: secondary ?? AppColors.secondary,
    onSecondary: AppColors.white,
    error: AppColors.error,
    onError: AppColors.white,
    errorContainer: AppColors.errorLight,
    surface: surface ?? AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    onSurfaceVariant: AppColors.darkTextSecondary,
    outline: AppColors.darkBorderDefault,
    shadow: AppColors.black,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    fontFamily: fontFamily ?? AppTypography.fontFamily,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: AppTypography.titleLarge.copyWith(
        color: colorScheme.onSurface,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: AppElevation.low,
      color: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: BorderSide(color: AppColors.darkBorderDefault),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceVariant,
      hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.grey500),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: const OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: AppColors.darkBorderDefault),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: AppColors.darkBorderDefault),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: AppColors.red500, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      showDragHandle: true,
      dragHandleColor: AppColors.grey600,
      elevation: AppElevation.lg,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      elevation: AppElevation.modal,
    ),
    extensions: [
      AppColorsExtension.dark.copyWith(
        surfaceVariant: colorScheme.surfaceContainerHighest,
        borderDefault: colorScheme.outline,
      ),
      AppSpacingExtension.defaults,
    ],
  );
}
