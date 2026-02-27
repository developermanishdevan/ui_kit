import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppCard extends AppStatelessWrapper {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final bool withBorder;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow = AppShadows.base,
    this.withBorder = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final bg = backgroundColor ?? colors.bodySecondaryBg;
    final r = borderRadius ?? radii.base;

    return Container(
      margin: margin ?? EdgeInsets.only(bottom: spacing.s3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: r,
        boxShadow: boxShadow != null ? [boxShadow!] : null,
      ),
      child: Container(
        // Outer 1px Border
        decoration: BoxDecoration(
          borderRadius: r,
          border: withBorder
              ? Border.all(
                  color: colors.borderColor.withValues(alpha: 0.8),
                  width: 1,
                )
              : null,
        ),
        // 1px spacer for the double border effect
        padding: withBorder ? EdgeInsets.all(1) : EdgeInsets.zero,
        child: Container(
          // Inner 1px Border
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              (r.resolve(Directionality.of(context)).topLeft.x - 1).clamp(
                0,
                double.infinity,
              ),
            ),
            border: withBorder
                ? Border.all(
                    color: colors.borderColor.withValues(alpha: 0.5),
                    width: 1,
                  )
                : null,
          ),
          padding: padding ?? EdgeInsets.all(spacing.s3),
          child: child,
        ),
      ),
    );
  }
}
