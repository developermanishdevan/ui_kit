import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';
import 'package:ui_kit/src/foundation/tokens/shadows/app_shadows.dart';

enum AppCardVariant { elevated, outlined, filled }

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.variant = AppCardVariant.elevated,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.shadows,
    this.borderColor,
    this.clip = Clip.antiAlias,
  });

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;
  final Color? borderColor;
  final Clip clip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = backgroundColor ??
        switch (variant) {
          AppCardVariant.elevated => cs.surface,
          AppCardVariant.outlined => cs.surface,
          AppCardVariant.filled => cs.surfaceContainerHighest,
        };
    final br = borderRadius ?? AppRadius.mdAll;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: br,
        boxShadow: shadows ??
            switch (variant) {
              AppCardVariant.elevated => AppShadows.sm,
              _ => AppShadows.none,
            },
        border: variant == AppCardVariant.outlined
            ? Border.all(color: borderColor ?? AppColors.borderDefault)
            : null,
      ),
      clipBehavior: clip,
      child: onTap != null
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: br,
                onTap: onTap,
                child: Padding(
                  padding: padding ?? const EdgeInsets.all(AppSpacing.base),
                  child: child,
                ),
              ),
            )
          : Padding(
              padding: padding ?? const EdgeInsets.all(AppSpacing.base),
              child: child,
            ),
    );
  }
}
