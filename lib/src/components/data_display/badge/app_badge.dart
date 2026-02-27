import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

enum AppBadgeVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

enum AppBadgeType { fill, outline, soft }

enum AppBadgeSize { xs, sm, md, lg }

class AppBadge extends AppStatelessWrapper {
  final String label;
  final AppBadgeVariant variant;
  final AppBadgeType type;
  final AppBadgeSize size;
  final bool isPill;
  final bool isDot;
  final bool hasBorder;

  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.primary,
    this.type = AppBadgeType.fill,
    this.size = AppBadgeSize.sm,
    this.isPill = false,
    this.isDot = false,
    this.hasBorder = false,
  });

  Color _getVariantColor(AppColorsExtension colors) {
    switch (variant) {
      case AppBadgeVariant.primary:
        return colors.primary;
      case AppBadgeVariant.secondary:
        return colors.secondary;
      case AppBadgeVariant.success:
        return colors.success;
      case AppBadgeVariant.danger:
        return colors.danger;
      case AppBadgeVariant.warning:
        return colors.warning;
      case AppBadgeVariant.info:
        return colors.info;
      case AppBadgeVariant.light:
        return colors.bodyBg;
      case AppBadgeVariant.dark:
        return colors.textEmphasis;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final color = _getVariantColor(colors);

    double dotSize;
    double fontSize;
    EdgeInsets padding;

    switch (size) {
      case AppBadgeSize.xs:
        dotSize = 6;
        fontSize = 8;
        padding = EdgeInsets.symmetric(horizontal: spacing.s1, vertical: 1);
        break;
      case AppBadgeSize.sm:
        dotSize = 10;
        fontSize = 10;
        padding = EdgeInsets.symmetric(horizontal: spacing.s2, vertical: 2);
        break;
      case AppBadgeSize.md:
        dotSize = 12;
        fontSize = 12;
        padding = EdgeInsets.symmetric(horizontal: spacing.s2 + 2, vertical: 3);
        break;
      case AppBadgeSize.lg:
        dotSize = 14;
        fontSize = 14;
        padding = EdgeInsets.symmetric(horizontal: spacing.s3, vertical: 4);
        break;
    }

    if (isDot) {
      return Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: hasBorder ? Border.all(color: colors.bodyBg, width: 2) : null,
        ),
      );
    }

    Color bgColor;
    Color textColor;
    Border? border;

    switch (type) {
      case AppBadgeType.fill:
        bgColor = color;
        textColor = (variant == AppBadgeVariant.light)
            ? colors.bodyColor
            : Colors.white;
        if (hasBorder) {
          border = Border.all(color: colors.bodyBg, width: 2);
        }
        break;
      case AppBadgeType.outline:
        bgColor = Colors.transparent;
        textColor = color;
        border = Border.all(color: color, width: 1);
        break;
      case AppBadgeType.soft:
        bgColor = color.withValues(alpha: 0.1);
        textColor = color;
        break;
    }

    return AppSemantics(
      label: label,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          border: border,
          borderRadius: isPill ? radii.pill : radii.base,
        ),
        child: Text(
          label,
          style: typography.bodySm.copyWith(
            color: textColor,
            fontWeight: AppTypography.semiBold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
