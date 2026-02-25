# Guide 03 — Theme System

## 3.1 Theme Extensions

**File:** `lib/src/theme/theme_extensions.dart`

```dart
import 'package:flutter/material.dart';
import '../foundation/tokens/colors/app_colors.dart';
import '../foundation/tokens/spacing/app_spacing.dart';
import '../foundation/tokens/radius/app_radius.dart';
import '../foundation/tokens/shadows/app_shadows.dart';

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
    Color? success, Color? successLight, Color? warning, Color? warningLight,
    Color? info, Color? infoLight, Color? textTertiary, Color? surfaceVariant,
    Color? borderDefault, Color? overlayLight, Color? overlayDark,
  }) {
    return AppColorsExtension(
      success:       success       ?? this.success,
      successLight:  successLight  ?? this.successLight,
      warning:       warning       ?? this.warning,
      warningLight:  warningLight  ?? this.warningLight,
      info:          info          ?? this.info,
      infoLight:     infoLight     ?? this.infoLight,
      textTertiary:  textTertiary  ?? this.textTertiary,
      surfaceVariant:surfaceVariant?? this.surfaceVariant,
      borderDefault: borderDefault ?? this.borderDefault,
      overlayLight:  overlayLight  ?? this.overlayLight,
      overlayDark:   overlayDark   ?? this.overlayDark,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      success:       Color.lerp(success,       other.success,       t)!,
      successLight:  Color.lerp(successLight,  other.successLight,  t)!,
      warning:       Color.lerp(warning,       other.warning,       t)!,
      warningLight:  Color.lerp(warningLight,  other.warningLight,  t)!,
      info:          Color.lerp(info,          other.info,          t)!,
      infoLight:     Color.lerp(infoLight,     other.infoLight,     t)!,
      textTertiary:  Color.lerp(textTertiary,  other.textTertiary,  t)!,
      surfaceVariant:Color.lerp(surfaceVariant,other.surfaceVariant,t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      overlayLight:  Color.lerp(overlayLight,  other.overlayLight,  t)!,
      overlayDark:   Color.lerp(overlayDark,   other.overlayDark,   t)!,
    );
  }

  // ── Default light instance ────────────────────────
  static const AppColorsExtension light = AppColorsExtension(
    success:       AppColors.success,
    successLight:  AppColors.successLight,
    warning:       AppColors.warning,
    warningLight:  AppColors.warningLight,
    info:          AppColors.info,
    infoLight:     AppColors.infoLight,
    textTertiary:  AppColors.textTertiary,
    surfaceVariant:AppColors.surfaceVariant,
    borderDefault: AppColors.borderDefault,
    overlayLight:  AppColors.overlayLight,
    overlayDark:   AppColors.overlayDark,
  );

  // ── Default dark instance ─────────────────────────
  static const AppColorsExtension dark = AppColorsExtension(
    success:       AppColors.green500,
    successLight:  Color(0xFF14532D),
    warning:       AppColors.amber500,
    warningLight:  Color(0xFF451A03),
    info:          AppColors.blue400,
    infoLight:     Color(0xFF1E3A5F),
    textTertiary:  AppColors.grey500,
    surfaceVariant:AppColors.darkSurfaceVariant,
    borderDefault: AppColors.darkBorderDefault,
    overlayLight:  Color(0x1AFFFFFF),
    overlayDark:   AppColors.overlayDark,
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
    double? pagePadding, double? sectionGap, double? cardPadding,
    double? inputPadding, double? buttonPaddingH, double? buttonPaddingV,
  }) => AppSpacingExtension(
    pagePadding:    pagePadding    ?? this.pagePadding,
    sectionGap:     sectionGap     ?? this.sectionGap,
    cardPadding:    cardPadding    ?? this.cardPadding,
    inputPadding:   inputPadding   ?? this.inputPadding,
    buttonPaddingH: buttonPaddingH ?? this.buttonPaddingH,
    buttonPaddingV: buttonPaddingV ?? this.buttonPaddingV,
  );

  @override
  AppSpacingExtension lerp(AppSpacingExtension? other, double t) => this;

  static const AppSpacingExtension defaults = AppSpacingExtension(
    pagePadding:    AppSpacing.base,
    sectionGap:     AppSpacing.xl2,
    cardPadding:    AppSpacing.base,
    inputPadding:   AppSpacing.sm,
    buttonPaddingH: AppSpacing.xl,
    buttonPaddingV: AppSpacing.md,
  );

  static const AppSpacingExtension compact = AppSpacingExtension(
    pagePadding:    AppSpacing.sm,
    sectionGap:     AppSpacing.xl,
    cardPadding:    AppSpacing.sm,
    inputPadding:   AppSpacing.xs,
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
```

---

## 3.2 Light Theme

**File:** `lib/src/theme/light_theme.dart`

```dart
import 'package:flutter/material.dart';
import '../foundation/tokens/colors/app_colors.dart';
import '../foundation/tokens/typography/app_typography.dart';
import '../foundation/tokens/radius/app_radius.dart';
import '../foundation/tokens/elevation/app_elevation.dart';
import 'theme_extensions.dart';

ThemeData buildLightTheme({String? fontFamily}) {
  const colorScheme = ColorScheme.light(
    primary:          AppColors.primary,
    onPrimary:        AppColors.textOnPrimary,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.primaryDark,

    secondary:        AppColors.secondary,
    onSecondary:      AppColors.white,
    secondaryContainer: AppColors.secondaryLight,

    error:            AppColors.error,
    onError:          AppColors.white,
    errorContainer:   AppColors.errorLight,

    surface:          AppColors.surface,
    onSurface:        AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,

    outline:          AppColors.borderDefault,
    outlineVariant:   AppColors.grey100,
    shadow:           AppColors.black,
  );

  return ThemeData(
    useMaterial3:   true,
    brightness:     Brightness.light,
    colorScheme:    colorScheme,
    fontFamily:     fontFamily ?? AppTypography.fontFamily,

    // AppBar
    appBarTheme: AppBarTheme(
      elevation:       0,
      centerTitle:     false,
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: AppTypography.titleLarge.copyWith(
        color: AppColors.textPrimary,
      ),
    ),

    // Card
    cardTheme: CardThemeData(
      elevation:    AppElevation.low,
      color:        AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: const BorderSide(color: AppColors.borderDefault),
      ),
      margin: EdgeInsets.zero,
    ),

    // InputDecoration
    inputDecorationTheme: InputDecorationTheme(
      filled:       true,
      fillColor:    AppColors.surfaceVariant,
      hintStyle:    AppTypography.bodyMedium.copyWith(color: AppColors.textTertiary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.borderDefault),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.borderDefault),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.borderFocused, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.borderError, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.borderError, width: 2),
      ),
    ),

    // ElevatedButton
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:  AppColors.primary,
        foregroundColor:  AppColors.white,
        elevation:        AppElevation.low,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // OutlinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // TextButton
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        textStyle: AppTypography.labelLarge,
      ),
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.grey100,
      selectedColor:   AppColors.primaryLight,
      labelStyle:      AppTypography.labelMedium,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.fullAll),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      side: BorderSide.none,
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color:     AppColors.borderDefault,
      thickness: 1.0,
      space:     0,
    ),

    // SnackBar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grey900,
      contentTextStyle: AppTypography.bodyMedium.copyWith(color: AppColors.white),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
      behavior: SnackBarBehavior.floating,
    ),

    // BottomSheet
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      showDragHandle: true,
      dragHandleColor: AppColors.grey300,
      elevation: AppElevation.lg,
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      elevation: AppElevation.modal,
      titleTextStyle: AppTypography.headlineMedium,
      contentTextStyle: AppTypography.bodyMedium,
    ),

    // ListTile
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: AppTypography.bodyMedium,
      subtitleTextStyle: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
    ),

    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.white;
        return AppColors.grey400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.grey200;
      }),
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(AppColors.white),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.xsAll),
      side: const BorderSide(color: AppColors.borderDefault, width: 1.5),
    ),

    // Navigation Bar
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primaryLight,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTypography.labelSmall.copyWith(color: AppColors.primary);
        }
        return AppTypography.labelSmall.copyWith(color: AppColors.textSecondary);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary);
        }
        return const IconThemeData(color: AppColors.textSecondary);
      }),
      elevation: AppElevation.sm,
    ),

    // TabBar
    tabBarTheme: TabBarThemeData(
      labelColor:       AppColors.primary,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle:       AppTypography.labelLarge,
      unselectedLabelStyle: AppTypography.labelLarge,
      indicatorColor:   AppColors.primary,
      indicatorSize:    TabBarIndicatorSize.tab,
      dividerColor:     AppColors.borderDefault,
    ),

    // Extensions
    extensions: const [
      AppColorsExtension.light,
      AppSpacingExtension.defaults,
    ],
  );
}
```

---

## 3.3 Dark Theme

**File:** `lib/src/theme/dark_theme.dart`

```dart
import 'package:flutter/material.dart';
import '../foundation/tokens/colors/app_colors.dart';
import '../foundation/tokens/typography/app_typography.dart';
import '../foundation/tokens/radius/app_radius.dart';
import '../foundation/tokens/elevation/app_elevation.dart';
import 'theme_extensions.dart';

ThemeData buildDarkTheme({String? fontFamily}) {
  const colorScheme = ColorScheme.dark(
    primary:          AppColors.darkPrimary,
    onPrimary:        AppColors.grey900,
    primaryContainer: Color(0xFF1E3A5F),
    onPrimaryContainer: AppColors.blue100,

    secondary:        AppColors.purple500,
    onSecondary:      AppColors.white,

    error:            AppColors.red500,
    onError:          AppColors.white,
    errorContainer:   Color(0xFF7F1D1D),

    surface:          AppColors.darkSurface,
    onSurface:        AppColors.darkTextPrimary,
    onSurfaceVariant: AppColors.darkTextSecondary,

    outline:          AppColors.darkBorderDefault,
    shadow:           AppColors.black,
  );

  return ThemeData(
    useMaterial3:   true,
    brightness:     Brightness.dark,
    colorScheme:    colorScheme,
    fontFamily:     fontFamily ?? AppTypography.fontFamily,

    appBarTheme: AppBarTheme(
      elevation:        0,
      centerTitle:      false,
      backgroundColor:  AppColors.darkSurface,
      foregroundColor:  AppColors.darkTextPrimary,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: AppTypography.titleLarge.copyWith(
        color: AppColors.darkTextPrimary,
      ),
    ),

    cardTheme: CardThemeData(
      elevation:    AppElevation.low,
      color:        AppColors.darkSurfaceVariant,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: const BorderSide(color: AppColors.darkBorderDefault),
      ),
      margin: EdgeInsets.zero,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled:    true,
      fillColor: AppColors.darkSurfaceVariant,
      hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.grey500),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.darkBorderDefault),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.darkBorderDefault),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.darkPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.red500, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.mdAll,
        borderSide: const BorderSide(color: AppColors.red500, width: 2),
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkSurfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      showDragHandle: true,
      dragHandleColor: AppColors.grey600,
      elevation: AppElevation.lg,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      elevation: AppElevation.modal,
    ),

    extensions: const [
      AppColorsExtension.dark,
      AppSpacingExtension.defaults,
    ],
  );
}
```

---

## 3.4 AppTheme

**File:** `lib/src/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

/// Central theme accessor.
class AppTheme {
  const AppTheme._();

  static final ThemeData light = buildLightTheme();
  static final ThemeData dark  = buildDarkTheme();

  /// Returns light or dark theme based on brightness.
  static ThemeData of(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;
}
```

---

## 3.5 ThemeController

**File:** `lib/src/theme/theme_controller.dart`

```dart
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

  void setLight()  => value = ThemeMode.light;
  void setDark()   => value = ThemeMode.dark;
  void setSystem() => value = ThemeMode.system;

  void toggle() {
    value = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
```
