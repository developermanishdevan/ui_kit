import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium, highly customizable button component following the UI Kit design system.
/// Supports multiple variants, sizes, colors, and states (loading, disabled).
class AppButton extends AppStatelessWrapper {
  /// Callback when the button is tapped. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// Optional icon to display before the label.
  final Widget? icon;

  /// Optional icon to display after the label.
  final Widget? suffixIcon;

  /// The text content of the button.
  final String label;

  /// The visual style of the button.
  final AppButtonVariant variant;

  /// The size of the button.
  final AppButtonSize size;

  /// The color scheme based on UI Kit semantic colors.
  final AppButtonColor color;

  /// Whether to show a loading spinner instead of the icon/label.
  final bool isLoading;

  /// Whether the button should take up all available horizontal space.
  final bool isFullWidth;

  /// Whether to use fully rounded (pill) corners.
  final bool isRoundedPill;

  /// Optional custom border radius. Overrides [isRoundedPill].
  final BorderRadius? borderRadius;

  /// Optional custom gradient background.
  final Gradient? gradient;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.suffixIcon,
    this.variant = AppButtonVariant.solid,
    this.size = AppButtonSize.md,
    this.color = AppButtonColor.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.isRoundedPill = false,
    this.borderRadius,
    this.gradient,
  });

  Color _getThemeColor(AppColorsExtension colors) {
    switch (color) {
      case AppButtonColor.primary:
        return colors.primary;
      case AppButtonColor.secondary:
        return colors.secondary;
      case AppButtonColor.success:
        return colors.success;
      case AppButtonColor.warning:
        return colors.warning;
      case AppButtonColor.danger:
        return colors.danger;
      case AppButtonColor.info:
        return colors.info;
      case AppButtonColor.light:
        return colors.light;
      case AppButtonColor.dark:
        return colors.dark;
    }
  }

  Color _getTextColorForSolid(AppColorsExtension colors, Color baseColor) {
    if (color == AppButtonColor.light) return colors.dark;
    if (color == AppButtonColor.warning) return colors.dark;
    return Colors.white;
  }

  EdgeInsetsGeometry _getPadding(AppSpacingExtension spacing) {
    switch (size) {
      case AppButtonSize.xs:
        return EdgeInsets.symmetric(
          horizontal: spacing.s2,
          vertical: spacing.s1,
        );
      case AppButtonSize.sm:
        return EdgeInsets.symmetric(
          horizontal: spacing.s2 * 1.5,
          vertical: spacing.s1 * 1.5,
        );
      case AppButtonSize.md:
        return EdgeInsets.symmetric(
          horizontal: spacing.s3,
          vertical: spacing.s2,
        );
      case AppButtonSize.lg:
        return EdgeInsets.symmetric(
          horizontal: spacing.s4,
          vertical: spacing.s3,
        );
      case AppButtonSize.xl:
        return EdgeInsets.symmetric(
          horizontal: spacing.s4 * 1.5,
          vertical: spacing.s4,
        );
    }
  }

  TextStyle _getTextStyle(AppTypographyExtension typography) {
    switch (size) {
      case AppButtonSize.xs:
        return typography.bodySm.copyWith(fontWeight: AppTypography.medium);
      case AppButtonSize.sm:
        return typography.bodySm.copyWith(fontWeight: AppTypography.medium);
      case AppButtonSize.md:
        return typography.bodyBase.copyWith(fontWeight: AppTypography.medium);
      case AppButtonSize.lg:
        return typography.bodyLg.copyWith(fontWeight: AppTypography.medium);
      case AppButtonSize.xl:
        return typography.bodyLg.copyWith(
          fontSize: 18,
          fontWeight: AppTypography.medium,
        );
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final baseColor = _getThemeColor(colors);
    final isDisabled = onPressed == null || isLoading;

    Color bg;
    Color fg;
    BorderSide border = BorderSide.none;

    switch (variant) {
      case AppButtonVariant.solid:
        bg = baseColor;
        fg = _getTextColorForSolid(colors, baseColor);
        break;
      case AppButtonVariant.outline:
        bg = Colors.transparent;
        fg = baseColor;
        border = BorderSide(color: baseColor, width: 1.5);
        break;
      case AppButtonVariant.soft:
        bg = baseColor.withValues(alpha: 0.1);
        fg = baseColor;
        break;
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = baseColor;
        break;
      case AppButtonVariant.link:
        bg = Colors.transparent;
        fg = baseColor;
        break;
    }

    if (isDisabled) {
      bg = bg != Colors.transparent ? bg.withValues(alpha: 0.5) : bg;
      fg = fg.withValues(alpha: 0.5);
      if (variant == AppButtonVariant.outline) {
        border = BorderSide(
          color: baseColor.withValues(alpha: 0.5),
          width: 1.5,
        );
      }
    }

    final bool isSolid = variant == AppButtonVariant.solid;

    Widget buttonContent = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          ),
          SizedBox(width: spacing.s2),
        ] else if (icon != null) ...[
          IconTheme(
            data: IconThemeData(
              color: fg,
              size: size == AppButtonSize.sm ? 16 : 20,
            ),
            child: icon!,
          ),
          SizedBox(width: spacing.s2),
        ],
        Text(
          label,
          style: _getTextStyle(typography).copyWith(
            color: fg,
            decoration: variant == AppButtonVariant.link
                ? TextDecoration.underline
                : TextDecoration.none,
          ),
        ),
        if (suffixIcon != null && !isLoading) ...[
          SizedBox(width: spacing.s2),
          IconTheme(
            data: IconThemeData(
              color: fg,
              size: size == AppButtonSize.sm ? 16 : 20,
            ),
            child: suffixIcon!,
          ),
        ],
      ],
    );

    final r = isRoundedPill ? radii.pill : borderRadius ?? radii.base;

    return AppSemantics(
      label: label,
      button: true,
      enabled: !isDisabled,
      child: AppInteractiveWidget(
        disabled: isDisabled,
        onTap: onPressed,
        showHoverEffect: true,
        child: AppAnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: gradient == null ? bg : null,
            gradient: gradient,
            borderRadius: r,
            border: border.style != BorderStyle.none
                ? Border.all(color: border.color, width: border.width)
                : null,
            boxShadow: isSolid && !isDisabled && !isLoading
                ? AppShadows.button3dShadow(baseColor)
                : null,
          ),
          child: Padding(padding: _getPadding(spacing), child: buttonContent),
        ),
      ),
    );
  }
}
