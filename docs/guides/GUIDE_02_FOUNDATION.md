# Guide 02 — Foundation: Design Tokens

All values live in `lib/src/foundation/tokens/`. They are pure Dart classes with static constants — no Flutter `BuildContext` needed.

---

## 2.1 AppColors

**File:** `lib/src/foundation/tokens/colors/app_colors.dart`

```dart
import 'package:flutter/material.dart';

/// Central color palette for the UI Kit.
/// Use semantic aliases (e.g. [AppColors.primary]) in components,
/// and raw palette values (e.g. [AppColors.blue500]) only in token definitions.
abstract final class AppColors {

  // ── Raw Palette ──────────────────────────────────────────────────────────
  // Blue
  static const Color blue50  = Color(0xFFEFF6FF);
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
  static const Color grey50  = Color(0xFFF9FAFB);
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
  static const Color green50  = Color(0xFFF0FDF4);
  static const Color green500 = Color(0xFF22C55E);
  static const Color green600 = Color(0xFF16A34A);
  static const Color green700 = Color(0xFF15803D);

  // Red
  static const Color red50  = Color(0xFFFEF2F2);
  static const Color red500 = Color(0xFFEF4444);
  static const Color red600 = Color(0xFFDC2626);
  static const Color red700 = Color(0xFFB91C1C);

  // Amber / Warning
  static const Color amber50  = Color(0xFFFFFBEB);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber600 = Color(0xFFD97706);

  // Purple
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color purple600 = Color(0xFF7C3AED);

  // Transparent
  static const Color transparent = Colors.transparent;
  static const Color white       = Color(0xFFFFFFFF);
  static const Color black       = Color(0xFF000000);

  // ── Semantic Aliases (Light) ─────────────────────────────────────────────
  static const Color primary         = blue600;
  static const Color primaryLight    = blue100;
  static const Color primaryDark     = blue800;

  static const Color secondary       = purple600;
  static const Color secondaryLight  = Color(0xFFEDE9FE);

  static const Color success         = green600;
  static const Color successLight    = green50;

  static const Color error           = red600;
  static const Color errorLight      = red50;

  static const Color warning         = amber600;
  static const Color warningLight    = amber50;

  static const Color info            = blue500;
  static const Color infoLight       = blue50;

  // Surfaces
  static const Color surface         = white;
  static const Color surfaceVariant  = grey50;
  static const Color surfaceDark     = grey900;

  // Text
  static const Color textPrimary     = grey900;
  static const Color textSecondary   = grey600;
  static const Color textTertiary    = grey400;
  static const Color textOnPrimary   = white;
  static const Color textOnDark      = grey100;

  // Border
  static const Color borderDefault   = grey200;
  static const Color borderFocused   = blue500;
  static const Color borderError     = red500;

  // Overlay
  static const Color overlayLight    = Color(0x1A000000); // 10%
  static const Color overlayMedium   = Color(0x4D000000); // 30%
  static const Color overlayDark     = Color(0x80000000); // 50%

  // ── Semantic Aliases (Dark) ──────────────────────────────────────────────
  static const Color darkPrimary        = blue400;
  static const Color darkSurface        = grey900;
  static const Color darkSurfaceVariant = grey800;
  static const Color darkTextPrimary    = grey50;
  static const Color darkTextSecondary  = grey400;
  static const Color darkBorderDefault  = grey700;
}
```

---

## 2.2 AppTypography

**File:** `lib/src/foundation/tokens/typography/app_typography.dart`

```dart
import 'package:flutter/material.dart';

/// Font size and weight constants.
abstract final class AppTypography {

  // ── Font Family ──────────────────────────────────────────────────────────
  static const String fontFamily = 'Inter'; // or your chosen font

  // ── Font Sizes ───────────────────────────────────────────────────────────
  static const double size2xs = 10.0;
  static const double sizeXs  = 12.0;
  static const double sizeSm  = 14.0;
  static const double sizeMd  = 16.0;
  static const double sizeLg  = 18.0;
  static const double sizeXl  = 20.0;
  static const double size2xl = 24.0;
  static const double size3xl = 30.0;
  static const double size4xl = 36.0;
  static const double size5xl = 48.0;
  static const double size6xl = 60.0;
  static const double size7xl = 72.0;

  // ── Font Weights ─────────────────────────────────────────────────────────
  static const FontWeight weightThin       = FontWeight.w100;
  static const FontWeight weightLight      = FontWeight.w300;
  static const FontWeight weightRegular    = FontWeight.w400;
  static const FontWeight weightMedium     = FontWeight.w500;
  static const FontWeight weightSemiBold   = FontWeight.w600;
  static const FontWeight weightBold       = FontWeight.w700;
  static const FontWeight weightExtraBold  = FontWeight.w800;
  static const FontWeight weightBlack      = FontWeight.w900;

  // ── Line Heights ─────────────────────────────────────────────────────────
  static const double lineHeightTight  = 1.2;
  static const double lineHeightSnug   = 1.375;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.625;
  static const double lineHeightLoose  = 2.0;

  // ── Letter Spacing ───────────────────────────────────────────────────────
  static const double trackingTight   = -0.05;
  static const double trackingNormal  = 0.0;
  static const double trackingWide    = 0.025;
  static const double trackingWider   = 0.05;
  static const double trackingWidest  = 0.1;

  // ── Semantic Text Styles ─────────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontSize: size5xl, fontWeight: weightBold,
    height: lineHeightTight, letterSpacing: trackingTight,
  );
  static const TextStyle displayMedium = TextStyle(
    fontSize: size4xl, fontWeight: weightBold,
    height: lineHeightTight,
  );
  static const TextStyle displaySmall = TextStyle(
    fontSize: size3xl, fontWeight: weightSemiBold,
    height: lineHeightTight,
  );
  static const TextStyle headlineLarge = TextStyle(
    fontSize: size2xl, fontWeight: weightSemiBold,
    height: lineHeightSnug,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontSize: sizeXl, fontWeight: weightSemiBold,
    height: lineHeightSnug,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontSize: sizeLg, fontWeight: weightSemiBold,
    height: lineHeightSnug,
  );
  static const TextStyle titleLarge = TextStyle(
    fontSize: sizeMd, fontWeight: weightSemiBold,
    height: lineHeightNormal,
  );
  static const TextStyle titleMedium = TextStyle(
    fontSize: sizeSm, fontWeight: weightSemiBold,
    height: lineHeightNormal,
  );
  static const TextStyle titleSmall = TextStyle(
    fontSize: sizeXs, fontWeight: weightSemiBold,
    height: lineHeightNormal,
    letterSpacing: trackingWide,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: sizeMd, fontWeight: weightRegular,
    height: lineHeightRelaxed,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: sizeSm, fontWeight: weightRegular,
    height: lineHeightRelaxed,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: sizeXs, fontWeight: weightRegular,
    height: lineHeightRelaxed,
  );
  static const TextStyle labelLarge = TextStyle(
    fontSize: sizeSm, fontWeight: weightMedium,
    height: lineHeightNormal, letterSpacing: trackingWide,
  );
  static const TextStyle labelMedium = TextStyle(
    fontSize: sizeXs, fontWeight: weightMedium,
    height: lineHeightNormal, letterSpacing: trackingWide,
  );
  static const TextStyle labelSmall = TextStyle(
    fontSize: size2xs, fontWeight: weightMedium,
    height: lineHeightNormal, letterSpacing: trackingWider,
  );
  static const TextStyle caption = TextStyle(
    fontSize: sizeXs, fontWeight: weightRegular,
    height: lineHeightNormal, letterSpacing: trackingWide,
  );
  static const TextStyle overline = TextStyle(
    fontSize: size2xs, fontWeight: weightSemiBold,
    height: lineHeightNormal, letterSpacing: trackingWidest,
  );
  static const TextStyle code = TextStyle(
    fontSize: sizeSm, fontWeight: weightRegular,
    fontFamily: 'monospace', height: lineHeightRelaxed,
  );
}
```

---

## 2.3 AppSpacing

**File:** `lib/src/foundation/tokens/spacing/app_spacing.dart`

```dart
/// Spacing scale based on a 4px base unit.
abstract final class AppSpacing {
  static const double none   = 0.0;
  static const double px1    = 1.0;
  static const double px2    = 2.0;
  static const double xs     = 4.0;
  static const double sm     = 8.0;
  static const double md     = 12.0;
  static const double base   = 16.0;
  static const double lg     = 20.0;
  static const double xl     = 24.0;
  static const double xl2    = 32.0;
  static const double xl3    = 40.0;
  static const double xl4    = 48.0;
  static const double xl5    = 56.0;
  static const double xl6    = 64.0;
  static const double xl7    = 80.0;
  static const double xl8    = 96.0;
  static const double xl9    = 128.0;
  static const double xl10   = 160.0;
}
```

---

## 2.4 AppRadius

**File:** `lib/src/foundation/tokens/radius/app_radius.dart`

```dart
import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const double none   = 0.0;
  static const double xs     = 2.0;
  static const double sm     = 4.0;
  static const double md     = 8.0;
  static const double lg     = 12.0;
  static const double xl     = 16.0;
  static const double xl2    = 20.0;
  static const double xl3    = 24.0;
  static const double full   = 9999.0;

  // BorderRadius convenience
  static const BorderRadius noneAll   = BorderRadius.zero;
  static const BorderRadius xsAll     = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smAll     = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll     = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll     = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlAll     = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius xl2All    = BorderRadius.all(Radius.circular(xl2));
  static const BorderRadius xl3All    = BorderRadius.all(Radius.circular(xl3));
  static const BorderRadius fullAll   = BorderRadius.all(Radius.circular(full));
}
```

---

## 2.5 AppShadows & AppElevation

**File:** `lib/src/foundation/tokens/shadows/app_shadows.dart`

```dart
import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

abstract final class AppShadows {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> xs = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2, offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 4, offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2, offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 6, offset: Offset(0, 4), spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 4, offset: Offset(0, 2), spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x19000000),
      blurRadius: 15, offset: Offset(0, 10), spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 6, offset: Offset(0, 4), spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 25, offset: Offset(0, 20), spreadRadius: -5,
    ),
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 10, offset: Offset(0, 8), spreadRadius: -5,
    ),
  ];

  static const List<BoxShadow> inner = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 4, offset: Offset(0, 2),
      spreadRadius: -1,
    ),
  ];
}
```

**File:** `lib/src/foundation/tokens/elevation/app_elevation.dart`

```dart
abstract final class AppElevation {
  static const double none    = 0.0;
  static const double low     = 1.0;
  static const double sm      = 2.0;
  static const double md      = 4.0;
  static const double lg      = 8.0;
  static const double xl      = 12.0;
  static const double xl2     = 16.0;
  static const double modal   = 24.0;
}
```

---

## 2.6 AppGradients

**File:** `lib/src/foundation/tokens/gradients/app_gradients.dart`

```dart
import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

abstract final class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: [AppColors.blue500, AppColors.blue700],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static const LinearGradient secondary = LinearGradient(
    colors: [AppColors.purple500, AppColors.purple600],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static const LinearGradient success = LinearGradient(
    colors: [AppColors.green500, AppColors.green700],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static const LinearGradient sunset = LinearGradient(
    colors: [Color(0xFFF97316), Color(0xFFEC4899)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static const LinearGradient ocean = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static const LinearGradient darkOverlay = LinearGradient(
    colors: [Colors.transparent, Color(0xB3000000)],
    begin: Alignment.topCenter, end: Alignment.bottomCenter,
  );

  static const RadialGradient radialPrimary = RadialGradient(
    colors: [AppColors.blue400, AppColors.blue700],
    radius: 0.8,
  );
}
```

---

## 2.7 Remaining Token Files

### AppDurations — `tokens/durations/app_durations.dart`

```dart
abstract final class AppDurations {
  static const Duration instant  = Duration.zero;
  static const Duration fast     = Duration(milliseconds: 100);
  static const Duration normal   = Duration(milliseconds: 200);
  static const Duration medium   = Duration(milliseconds: 300);
  static const Duration slow     = Duration(milliseconds: 500);
  static const Duration slower   = Duration(milliseconds: 750);
  static const Duration slowest  = Duration(milliseconds: 1000);
  static const Duration page     = Duration(milliseconds: 350);
}
```

### AppOpacity — `tokens/opacity/app_opacity.dart`

```dart
abstract final class AppOpacity {
  static const double transparent = 0.0;
  static const double dim5        = 0.05;
  static const double dim10       = 0.10;
  static const double dim20       = 0.20;
  static const double dim30       = 0.30;
  static const double dim40       = 0.40;
  static const double dim50       = 0.50;
  static const double dim60       = 0.60;
  static const double dim70       = 0.70;
  static const double disabled    = 0.38;
  static const double medium      = 0.60;
  static const double high        = 0.87;
  static const double opaque      = 1.0;
}
```

### AppIconSizes — `tokens/icon_sizes/app_icon_sizes.dart`

```dart
abstract final class AppIconSizes {
  static const double xs   = 12.0;
  static const double sm   = 16.0;
  static const double md   = 20.0;
  static const double lg   = 24.0;
  static const double xl   = 32.0;
  static const double xl2  = 40.0;
  static const double xl3  = 48.0;
  static const double xl4  = 64.0;
}
```

### AppZIndex — `tokens/z_index/app_z_index.dart`

```dart
abstract final class AppZIndex {
  static const int base      = 0;
  static const int raised    = 10;
  static const int dropdown  = 100;
  static const int sticky    = 200;
  static const int overlay   = 300;
  static const int modal     = 400;
  static const int popover   = 500;
  static const int tooltip   = 600;
  static const int toast     = 700;
}
```

### AppBorderStyles — `tokens/border_styles/app_border_styles.dart`

```dart
import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

abstract final class AppBorderStyles {
  static const double widthThin    = 1.0;
  static const double widthMedium  = 1.5;
  static const double widthThick   = 2.0;
  static const double widthHeavy   = 3.0;

  static const BorderSide thin = BorderSide(
    color: AppColors.borderDefault, width: widthThin,
  );
  static const BorderSide medium = BorderSide(
    color: AppColors.borderDefault, width: widthMedium,
  );
  static const BorderSide focused = BorderSide(
    color: AppColors.borderFocused, width: widthThick,
  );
  static const BorderSide error = BorderSide(
    color: AppColors.borderError, width: widthThick,
  );
  static const BorderSide none = BorderSide.none;
}
```

---

## 2.8 Foundation Config Files

### AppBrand — `config/app_brand.dart`

```dart
import 'package:flutter/material.dart';

/// Branding configuration injected at app level.
/// Override this at startup before MaterialApp initialises.
class AppBrandConfig {
  const AppBrandConfig({
    this.appName = 'App',
    this.primaryColor = const Color(0xFF2563EB),
    this.accentColor = const Color(0xFF7C3AED),
    this.fontFamily,
    this.logoAssetPath,
    this.faviconAssetPath,
  });

  final String appName;
  final Color primaryColor;
  final Color accentColor;
  final String? fontFamily;
  final String? logoAssetPath;
  final String? faviconAssetPath;
}

/// Global singleton that holds current brand config.
class AppBrand {
  static AppBrandConfig _config = const AppBrandConfig();

  static AppBrandConfig get config => _config;

  static void configure(AppBrandConfig config) {
    _config = config;
  }
}
```

### AppUiConfig — `config/app_ui_config.dart`

```dart
/// App-level UI configuration.
class AppUiConfig {
  const AppUiConfig({
    this.defaultAnimationEnabled = true,
    this.defaultBorderRadius = 8.0,
    this.defaultElevation = 2.0,
    this.useMaterial3 = true,
    this.compactMode = false,
  });

  final bool defaultAnimationEnabled;
  final double defaultBorderRadius;
  final double defaultElevation;
  final bool useMaterial3;
  final bool compactMode;

  static AppUiConfig _instance = const AppUiConfig();
  static AppUiConfig get instance => _instance;

  static void configure(AppUiConfig config) => _instance = config;

  AppUiConfig copyWith({
    bool? defaultAnimationEnabled,
    double? defaultBorderRadius,
    double? defaultElevation,
    bool? useMaterial3,
    bool? compactMode,
  }) {
    return AppUiConfig(
      defaultAnimationEnabled: defaultAnimationEnabled ?? this.defaultAnimationEnabled,
      defaultBorderRadius:     defaultBorderRadius     ?? this.defaultBorderRadius,
      defaultElevation:        defaultElevation        ?? this.defaultElevation,
      useMaterial3:            useMaterial3            ?? this.useMaterial3,
      compactMode:             compactMode             ?? this.compactMode,
    );
  }
}
```

### FeatureFlags — `config/feature_flags.dart`

```dart
/// Runtime feature flags for conditional UI rendering.
class AppFeatureFlags {
  const AppFeatureFlags({
    this.enableDarkMode       = true,
    this.enableAnimations     = true,
    this.enableAnalytics      = false,
    this.enableBetaFeatures   = false,
    this.enableAccessibility  = true,
    this.enableOfflineMode    = false,
    this.enablePushNotifications = false,
  });

  final bool enableDarkMode;
  final bool enableAnimations;
  final bool enableAnalytics;
  final bool enableBetaFeatures;
  final bool enableAccessibility;
  final bool enableOfflineMode;
  final bool enablePushNotifications;

  static AppFeatureFlags _instance = const AppFeatureFlags();
  static AppFeatureFlags get instance => _instance;
  static void configure(AppFeatureFlags flags) => _instance = flags;
}
```

---

## 2.9 Base Widget Classes

### AppBaseWidget — `base/app_base_widget.dart`

```dart
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
```

### AppStatefulWrapper — `base/app_stateful_wrapper.dart`

```dart
import 'package:flutter/material.dart';

/// Abstract base for all stateful UI Kit widgets.
abstract class AppStatefulWidget extends StatefulWidget {
  const AppStatefulWidget({super.key});
}

abstract class AppState<T extends AppStatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);
  ColorScheme get colors => Theme.of(context).colorScheme;
  TextTheme get textTheme => Theme.of(context).textTheme;
  bool get isDark => Theme.of(context).brightness == Brightness.dark;
  Size get screenSize => MediaQuery.sizeOf(context);
  EdgeInsets get screenPadding => MediaQuery.paddingOf(context);
}
```

### AppInteractiveWidget — `base/app_interactive_widget.dart`

```dart
import 'package:flutter/material.dart';

/// Mixin for widgets with press/hover/focus states.
mixin AppInteractiveState<T extends StatefulWidget> on State<T> {
  bool _isHovered  = false;
  bool _isPressed  = false;
  bool _isFocused  = false;

  bool get isHovered => _isHovered;
  bool get isPressed => _isPressed;
  bool get isFocused => _isFocused;

  void onHoverChanged(bool hovered) =>
      setState(() => _isHovered = hovered);

  void onPressChanged(bool pressed) =>
      setState(() => _isPressed = pressed);

  void onFocusChanged(bool focused) =>
      setState(() => _isFocused = focused);

  double get interactiveOpacity {
    if (_isPressed) return 0.7;
    if (_isHovered) return 0.9;
    return 1.0;
  }
}
```
