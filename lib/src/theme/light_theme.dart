import 'package:flutter/material.dart';
import '../foundation/tokens/colors/app_colors.dart';
import '../foundation/tokens/typography/app_typography.dart';
import '../foundation/tokens/radius/app_radius.dart';
import '../foundation/tokens/elevation/app_elevation.dart';
import 'theme_extensions.dart';

ThemeData buildLightTheme({
  String? fontFamily,
  Color? primary,
  Color? secondary,
  Color? surface,
}) {
  final colorScheme = ColorScheme.light(
    primary: primary ?? AppColors.primary,
    onPrimary: AppColors.textOnPrimary,
    primaryContainer: (primary ?? AppColors.primary).withValues(alpha: 0.1),
    onPrimaryContainer: primary ?? AppColors.primaryDark,
    secondary: secondary ?? AppColors.secondary,
    onSecondary: AppColors.white,
    secondaryContainer:
        (secondary ?? AppColors.secondary).withValues(alpha: 0.1),
    error: AppColors.error,
    onError: AppColors.white,
    errorContainer: AppColors.errorLight,
    surface: surface ?? AppColors.surface,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.borderDefault,
    outlineVariant: AppColors.grey100,
    shadow: AppColors.black,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    fontFamily: fontFamily ?? AppTypography.fontFamily,

    // AppBar
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

    // Card
    cardTheme: CardThemeData(
      elevation: AppElevation.low,
      color: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: BorderSide(color: AppColors.borderDefault),
      ),
      margin: EdgeInsets.zero,
    ),

    // InputDecoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceVariant,
      hintStyle:
          AppTypography.bodyMedium.copyWith(color: AppColors.textTertiary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: const OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: AppColors.borderDefault),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: AppColors.borderDefault),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: AppColors.borderFocused, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: AppColors.borderError, width: 1.5),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: BorderSide(color: AppColors.borderError, width: 2),
      ),
    ),

    // ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: AppElevation.low,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // OutlinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // TextButton
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // Chip
    chipTheme: const ChipThemeData(
      backgroundColor: AppColors.grey100,
      selectedColor: AppColors.primaryLight,
      labelStyle: AppTypography.labelMedium,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.fullAll),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      side: BorderSide.none,
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.borderDefault,
      thickness: 1.0,
      space: 0,
    ),

    // SnackBar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grey900,
      contentTextStyle:
          AppTypography.bodyMedium.copyWith(color: AppColors.white),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
      behavior: SnackBarBehavior.floating,
    ),

    // BottomSheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      showDragHandle: true,
      dragHandleColor: AppColors.grey300,
      elevation: AppElevation.lg,
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      elevation: AppElevation.modal,
      titleTextStyle: AppTypography.headlineMedium,
      contentTextStyle: AppTypography.bodyMedium,
    ),

    // ListTile
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: AppTypography.bodyMedium,
      subtitleTextStyle:
          AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.white;
        return AppColors.grey400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colorScheme.primary;
        return AppColors.grey200;
      }),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colorScheme.primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.xsAll),
      side: const BorderSide(color: AppColors.borderDefault, width: 1.5),
    ),

    // Navigation Bar
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      indicatorColor: colorScheme.primaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.labelSmall.copyWith(color: colorScheme.primary);
        }
        return AppTypography.labelSmall
            .copyWith(color: AppColors.textSecondary);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: colorScheme.primary);
        }
        return const IconThemeData(color: AppColors.textSecondary);
      }),
      elevation: AppElevation.sm,
    ),

    // TabBar
    tabBarTheme: TabBarThemeData(
      labelColor: colorScheme.primary,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle: AppTypography.labelLarge,
      unselectedLabelStyle: AppTypography.labelLarge,
      indicatorColor: colorScheme.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: AppColors.borderDefault,
    ),

    // Extensions
    extensions: [
      AppColorsExtension.light.copyWith(
        surfaceVariant: colorScheme.surfaceContainerHighest,
        borderDefault: colorScheme.outline,
      ),
      AppSpacingExtension.defaults,
    ],
  );
}
