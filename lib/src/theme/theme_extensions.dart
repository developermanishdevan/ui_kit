import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color primary;
  final Color secondary;
  final Color success;
  final Color warning;
  final Color danger;
  final Color info;
  final Color light;
  final Color dark;

  final Color bodyBg;
  final Color bodyColor;
  final Color bodySecondaryColor;
  final Color bodySecondaryBg;
  final Color borderColor;
  final Color borderColorTranslucent;

  final Color textEmphasis;
  final Color bgSubtle;

  const AppColorsExtension({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.light,
    required this.dark,
    required this.bodyBg,
    required this.bodyColor,
    required this.bodySecondaryColor,
    required this.bodySecondaryBg,
    required this.borderColor,
    required this.borderColorTranslucent,
    required this.textEmphasis,
    required this.bgSubtle,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primary,
    Color? secondary,
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
    Color? light,
    Color? dark,
    Color? bodyBg,
    Color? bodyColor,
    Color? bodySecondaryColor,
    Color? bodySecondaryBg,
    Color? borderColor,
    Color? borderColorTranslucent,
    Color? textEmphasis,
    Color? bgSubtle,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
      light: light ?? this.light,
      dark: dark ?? this.dark,
      bodyBg: bodyBg ?? this.bodyBg,
      bodyColor: bodyColor ?? this.bodyColor,
      bodySecondaryColor: bodySecondaryColor ?? this.bodySecondaryColor,
      bodySecondaryBg: bodySecondaryBg ?? this.bodySecondaryBg,
      borderColor: borderColor ?? this.borderColor,
      borderColorTranslucent:
          borderColorTranslucent ?? this.borderColorTranslucent,
      textEmphasis: textEmphasis ?? this.textEmphasis,
      bgSubtle: bgSubtle ?? this.bgSubtle,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      light: Color.lerp(light, other.light, t)!,
      dark: Color.lerp(dark, other.dark, t)!,
      bodyBg: Color.lerp(bodyBg, other.bodyBg, t)!,
      bodyColor: Color.lerp(bodyColor, other.bodyColor, t)!,
      bodySecondaryColor: Color.lerp(
        bodySecondaryColor,
        other.bodySecondaryColor,
        t,
      )!,
      bodySecondaryBg: Color.lerp(bodySecondaryBg, other.bodySecondaryBg, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderColorTranslucent: Color.lerp(
        borderColorTranslucent,
        other.borderColorTranslucent,
        t,
      )!,
      textEmphasis: Color.lerp(textEmphasis, other.textEmphasis, t)!,
      bgSubtle: Color.lerp(bgSubtle, other.bgSubtle, t)!,
    );
  }
}

class AppTypographyExtension extends ThemeExtension<AppTypographyExtension> {
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle h6;
  final TextStyle bodyXs;
  final TextStyle bodySm;
  final TextStyle bodyBase;
  final TextStyle bodyLg;

  const AppTypographyExtension({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.bodyXs,
    required this.bodySm,
    required this.bodyBase,
    required this.bodyLg,
  });

  @override
  ThemeExtension<AppTypographyExtension> copyWith({
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? h5,
    TextStyle? h6,
    TextStyle? bodyXs,
    TextStyle? bodySm,
    TextStyle? bodyBase,
    TextStyle? bodyLg,
  }) {
    return AppTypographyExtension(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      bodyXs: bodyXs ?? this.bodyXs,
      bodySm: bodySm ?? this.bodySm,
      bodyBase: bodyBase ?? this.bodyBase,
      bodyLg: bodyLg ?? this.bodyLg,
    );
  }

  @override
  ThemeExtension<AppTypographyExtension> lerp(
    covariant ThemeExtension<AppTypographyExtension>? other,
    double t,
  ) {
    if (other is! AppTypographyExtension) {
      return this;
    }
    return AppTypographyExtension(
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      h4: TextStyle.lerp(h4, other.h4, t)!,
      h5: TextStyle.lerp(h5, other.h5, t)!,
      h6: TextStyle.lerp(h6, other.h6, t)!,
      bodyXs: TextStyle.lerp(bodyXs, other.bodyXs, t)!,
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t)!,
      bodyBase: TextStyle.lerp(bodyBase, other.bodyBase, t)!,
      bodyLg: TextStyle.lerp(bodyLg, other.bodyLg, t)!,
    );
  }
}

class AppSpacingExtension extends ThemeExtension<AppSpacingExtension> {
  final double s1;
  final double s2;
  final double s3;
  final double s4;
  final double s5;

  const AppSpacingExtension({
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s5,
  });

  @override
  ThemeExtension<AppSpacingExtension> copyWith({
    double? s1,
    double? s2,
    double? s3,
    double? s4,
    double? s5,
  }) {
    return AppSpacingExtension(
      s1: s1 ?? this.s1,
      s2: s2 ?? this.s2,
      s3: s3 ?? this.s3,
      s4: s4 ?? this.s4,
      s5: s5 ?? this.s5,
    );
  }

  @override
  ThemeExtension<AppSpacingExtension> lerp(
    covariant ThemeExtension<AppSpacingExtension>? other,
    double t,
  ) {
    if (other is! AppSpacingExtension) return this;
    return AppSpacingExtension(
      s1: s1 + (other.s1 - s1) * t,
      s2: s2 + (other.s2 - s2) * t,
      s3: s3 + (other.s3 - s3) * t,
      s4: s4 + (other.s4 - s4) * t,
      s5: s5 + (other.s5 - s5) * t,
    );
  }
}

class AppRadiusExtension extends ThemeExtension<AppRadiusExtension> {
  final BorderRadius base;
  final BorderRadius sm;
  final BorderRadius lg;
  final BorderRadius xl;
  final BorderRadius xxl;
  final BorderRadius pill;

  const AppRadiusExtension({
    required this.base,
    required this.sm,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.pill,
  });

  @override
  ThemeExtension<AppRadiusExtension> copyWith({
    BorderRadius? base,
    BorderRadius? sm,
    BorderRadius? lg,
    BorderRadius? xl,
    BorderRadius? xxl,
    BorderRadius? pill,
  }) {
    return AppRadiusExtension(
      base: base ?? this.base,
      sm: sm ?? this.sm,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      pill: pill ?? this.pill,
    );
  }

  @override
  ThemeExtension<AppRadiusExtension> lerp(
    covariant ThemeExtension<AppRadiusExtension>? other,
    double t,
  ) {
    if (other is! AppRadiusExtension) return this;
    return AppRadiusExtension(
      base: BorderRadius.lerp(base, other.base, t)!,
      sm: BorderRadius.lerp(sm, other.sm, t)!,
      lg: BorderRadius.lerp(lg, other.lg, t)!,
      xl: BorderRadius.lerp(xl, other.xl, t)!,
      xxl: BorderRadius.lerp(xxl, other.xxl, t)!,
      pill: BorderRadius.lerp(pill, other.pill, t)!,
    );
  }
}

class AppShadowsExtension extends ThemeExtension<AppShadowsExtension> {
  final BoxShadow base;
  final BoxShadow sm;
  final BoxShadow lg;

  const AppShadowsExtension({
    required this.base,
    required this.sm,
    required this.lg,
  });

  @override
  ThemeExtension<AppShadowsExtension> copyWith({
    BoxShadow? base,
    BoxShadow? sm,
    BoxShadow? lg,
  }) {
    return AppShadowsExtension(
      base: base ?? this.base,
      sm: sm ?? this.sm,
      lg: lg ?? this.lg,
    );
  }

  @override
  ThemeExtension<AppShadowsExtension> lerp(
    covariant ThemeExtension<AppShadowsExtension>? other,
    double t,
  ) {
    if (other is! AppShadowsExtension) return this;
    return AppShadowsExtension(
      base: BoxShadow.lerp(base, other.base, t)!,
      sm: BoxShadow.lerp(sm, other.sm, t)!,
      lg: BoxShadow.lerp(lg, other.lg, t)!,
    );
  }
}

class AppBorderStylesExtension
    extends ThemeExtension<AppBorderStylesExtension> {
  final BorderSide none;
  final BorderSide solidThin;
  final BorderSide solidMedium;
  final BorderSide solidThick;

  const AppBorderStylesExtension({
    required this.none,
    required this.solidThin,
    required this.solidMedium,
    required this.solidThick,
  });

  @override
  ThemeExtension<AppBorderStylesExtension> copyWith({
    BorderSide? none,
    BorderSide? solidThin,
    BorderSide? solidMedium,
    BorderSide? solidThick,
  }) {
    return AppBorderStylesExtension(
      none: none ?? this.none,
      solidThin: solidThin ?? this.solidThin,
      solidMedium: solidMedium ?? this.solidMedium,
      solidThick: solidThick ?? this.solidThick,
    );
  }

  @override
  ThemeExtension<AppBorderStylesExtension> lerp(
    covariant ThemeExtension<AppBorderStylesExtension>? other,
    double t,
  ) {
    if (other is! AppBorderStylesExtension) return this;
    return AppBorderStylesExtension(
      none: BorderSide.lerp(none, other.none, t),
      solidThin: BorderSide.lerp(solidThin, other.solidThin, t),
      solidMedium: BorderSide.lerp(solidMedium, other.solidMedium, t),
      solidThick: BorderSide.lerp(solidThick, other.solidThick, t),
    );
  }
}

class AppBreakpointsExtension extends ThemeExtension<AppBreakpointsExtension> {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  const AppBreakpointsExtension({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  @override
  ThemeExtension<AppBreakpointsExtension> copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return AppBreakpointsExtension(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  ThemeExtension<AppBreakpointsExtension> lerp(
    covariant ThemeExtension<AppBreakpointsExtension>? other,
    double t,
  ) {
    if (other is! AppBreakpointsExtension) return this;
    return AppBreakpointsExtension(
      xs: xs + (other.xs - xs) * t,
      sm: sm + (other.sm - sm) * t,
      md: md + (other.md - md) * t,
      lg: lg + (other.lg - lg) * t,
      xl: xl + (other.xl - xl) * t,
      xxl: xxl + (other.xxl - xxl) * t,
    );
  }
}

class AppDurationsExtension extends ThemeExtension<AppDurationsExtension> {
  final Duration quickest;
  final Duration quick;
  final Duration normal;
  final Duration slow;
  final Duration slowest;

  const AppDurationsExtension({
    required this.quickest,
    required this.quick,
    required this.normal,
    required this.slow,
    required this.slowest,
  });

  @override
  ThemeExtension<AppDurationsExtension> copyWith({
    Duration? quickest,
    Duration? quick,
    Duration? normal,
    Duration? slow,
    Duration? slowest,
  }) {
    return AppDurationsExtension(
      quickest: quickest ?? this.quickest,
      quick: quick ?? this.quick,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
      slowest: slowest ?? this.slowest,
    );
  }

  @override
  ThemeExtension<AppDurationsExtension> lerp(
    covariant ThemeExtension<AppDurationsExtension>? other,
    double t,
  ) {
    if (other is! AppDurationsExtension) return this;
    return AppDurationsExtension(
      quickest: Duration(
        microseconds:
            (quickest.inMicroseconds +
                    (other.quickest.inMicroseconds - quickest.inMicroseconds) *
                        t)
                .round(),
      ),
      quick: Duration(
        microseconds:
            (quick.inMicroseconds +
                    (other.quick.inMicroseconds - quick.inMicroseconds) * t)
                .round(),
      ),
      normal: Duration(
        microseconds:
            (normal.inMicroseconds +
                    (other.normal.inMicroseconds - normal.inMicroseconds) * t)
                .round(),
      ),
      slow: Duration(
        microseconds:
            (slow.inMicroseconds +
                    (other.slow.inMicroseconds - slow.inMicroseconds) * t)
                .round(),
      ),
      slowest: Duration(
        microseconds:
            (slowest.inMicroseconds +
                    (other.slowest.inMicroseconds - slowest.inMicroseconds) * t)
                .round(),
      ),
    );
  }
}

class AppElevationExtension extends ThemeExtension<AppElevationExtension> {
  final double none;
  final double level1;
  final double level2;
  final double level3;
  final double level4;
  final double level5;

  const AppElevationExtension({
    required this.none,
    required this.level1,
    required this.level2,
    required this.level3,
    required this.level4,
    required this.level5,
  });

  @override
  ThemeExtension<AppElevationExtension> copyWith({
    double? none,
    double? level1,
    double? level2,
    double? level3,
    double? level4,
    double? level5,
  }) {
    return AppElevationExtension(
      none: none ?? this.none,
      level1: level1 ?? this.level1,
      level2: level2 ?? this.level2,
      level3: level3 ?? this.level3,
      level4: level4 ?? this.level4,
      level5: level5 ?? this.level5,
    );
  }

  @override
  ThemeExtension<AppElevationExtension> lerp(
    covariant ThemeExtension<AppElevationExtension>? other,
    double t,
  ) {
    if (other is! AppElevationExtension) return this;
    return AppElevationExtension(
      none: none + (other.none - none) * t,
      level1: level1 + (other.level1 - level1) * t,
      level2: level2 + (other.level2 - level2) * t,
      level3: level3 + (other.level3 - level3) * t,
      level4: level4 + (other.level4 - level4) * t,
      level5: level5 + (other.level5 - level5) * t,
    );
  }
}

class AppGradientsExtension extends ThemeExtension<AppGradientsExtension> {
  final LinearGradient brand;
  final LinearGradient soft;
  final LinearGradient success;
  final LinearGradient error;

  const AppGradientsExtension({
    required this.brand,
    required this.soft,
    required this.success,
    required this.error,
  });

  @override
  ThemeExtension<AppGradientsExtension> copyWith({
    LinearGradient? brand,
    LinearGradient? soft,
    LinearGradient? success,
    LinearGradient? error,
  }) {
    return AppGradientsExtension(
      brand: brand ?? this.brand,
      soft: soft ?? this.soft,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  ThemeExtension<AppGradientsExtension> lerp(
    covariant ThemeExtension<AppGradientsExtension>? other,
    double t,
  ) {
    if (other is! AppGradientsExtension) return this;
    return AppGradientsExtension(
      brand: LinearGradient.lerp(brand, other.brand, t)!,
      soft: LinearGradient.lerp(soft, other.soft, t)!,
      success: LinearGradient.lerp(success, other.success, t)!,
      error: LinearGradient.lerp(error, other.error, t)!,
    );
  }
}

class AppIconSizesExtension extends ThemeExtension<AppIconSizesExtension> {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  const AppIconSizesExtension({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  @override
  ThemeExtension<AppIconSizesExtension> copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return AppIconSizesExtension(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  ThemeExtension<AppIconSizesExtension> lerp(
    covariant ThemeExtension<AppIconSizesExtension>? other,
    double t,
  ) {
    if (other is! AppIconSizesExtension) return this;
    return AppIconSizesExtension(
      xs: xs + (other.xs - xs) * t,
      sm: sm + (other.sm - sm) * t,
      md: md + (other.md - md) * t,
      lg: lg + (other.lg - lg) * t,
      xl: xl + (other.xl - xl) * t,
      xxl: xxl + (other.xxl - xxl) * t,
    );
  }
}

class AppOpacityExtension extends ThemeExtension<AppOpacityExtension> {
  final double transparent;
  final double semiTransparent;
  final double moderate;
  final double distinct;
  final double almostSolid;
  final double hover;
  final double focus;

  const AppOpacityExtension({
    required this.transparent,
    required this.semiTransparent,
    required this.moderate,
    required this.distinct,
    required this.almostSolid,
    required this.hover,
    required this.focus,
  });

  @override
  ThemeExtension<AppOpacityExtension> copyWith({
    double? transparent,
    double? semiTransparent,
    double? moderate,
    double? distinct,
    double? almostSolid,
    double? hover,
    double? focus,
  }) {
    return AppOpacityExtension(
      transparent: transparent ?? this.transparent,
      semiTransparent: semiTransparent ?? this.semiTransparent,
      moderate: moderate ?? this.moderate,
      distinct: distinct ?? this.distinct,
      almostSolid: almostSolid ?? this.almostSolid,
      hover: hover ?? this.hover,
      focus: focus ?? this.focus,
    );
  }

  @override
  ThemeExtension<AppOpacityExtension> lerp(
    covariant ThemeExtension<AppOpacityExtension>? other,
    double t,
  ) {
    if (other is! AppOpacityExtension) return this;
    return AppOpacityExtension(
      transparent: transparent + (other.transparent - transparent) * t,
      semiTransparent:
          semiTransparent + (other.semiTransparent - semiTransparent) * t,
      moderate: moderate + (other.moderate - moderate) * t,
      distinct: distinct + (other.distinct - distinct) * t,
      almostSolid: almostSolid + (other.almostSolid - almostSolid) * t,
      hover: hover + (other.hover - hover) * t,
      focus: focus + (other.focus - focus) * t,
    );
  }
}

class AppZIndexExtension extends ThemeExtension<AppZIndexExtension> {
  final int background;
  final int normal;
  final int dropdown;
  final int sticky;
  final int fixed;
  final int modalBackdrop;
  final int modal;
  final int popover;
  final int tooltip;

  const AppZIndexExtension({
    required this.background,
    required this.normal,
    required this.dropdown,
    required this.sticky,
    required this.fixed,
    required this.modalBackdrop,
    required this.modal,
    required this.popover,
    required this.tooltip,
  });

  @override
  ThemeExtension<AppZIndexExtension> copyWith({
    int? background,
    int? normal,
    int? dropdown,
    int? sticky,
    int? fixed,
    int? modalBackdrop,
    int? modal,
    int? popover,
    int? tooltip,
  }) {
    return AppZIndexExtension(
      background: background ?? this.background,
      normal: normal ?? this.normal,
      dropdown: dropdown ?? this.dropdown,
      sticky: sticky ?? this.sticky,
      fixed: fixed ?? this.fixed,
      modalBackdrop: modalBackdrop ?? this.modalBackdrop,
      modal: modal ?? this.modal,
      popover: popover ?? this.popover,
      tooltip: tooltip ?? this.tooltip,
    );
  }

  @override
  ThemeExtension<AppZIndexExtension> lerp(
    covariant ThemeExtension<AppZIndexExtension>? other,
    double t,
  ) {
    if (other is! AppZIndexExtension) return this;
    return AppZIndexExtension(
      background: (background + (other.background - background) * t).round(),
      normal: (normal + (other.normal - normal) * t).round(),
      dropdown: (dropdown + (other.dropdown - dropdown) * t).round(),
      sticky: (sticky + (other.sticky - sticky) * t).round(),
      fixed: (fixed + (other.fixed - fixed) * t).round(),
      modalBackdrop: (modalBackdrop + (other.modalBackdrop - modalBackdrop) * t)
          .round(),
      modal: (modal + (other.modal - modal) * t).round(),
      popover: (popover + (other.popover - popover) * t).round(),
      tooltip: (tooltip + (other.tooltip - tooltip) * t).round(),
    );
  }
}
