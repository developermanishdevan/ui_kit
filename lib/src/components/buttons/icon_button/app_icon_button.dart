import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import 'package:ui_kit/src/foundation/tokens/icon_sizes/app_icon_sizes.dart';

enum AppIconButtonVariant { standard, filled, tonal, outlined }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.variant = AppIconButtonVariant.standard,
    this.size = AppIconSizes.lg,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.tooltip,
    this.isDisabled = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final String? tooltip;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final effectiveOnPressed = isDisabled ? null : onPressed;

    final iconWidget = Icon(
      icon,
      size: size,
      color: color ??
          switch (variant) {
            AppIconButtonVariant.filled => AppColors.white,
            AppIconButtonVariant.tonal => cs.onSecondaryContainer,
            _ => cs.onSurface,
          },
    );

    final decoration = switch (variant) {
      AppIconButtonVariant.filled => BoxDecoration(
          color: backgroundColor ?? cs.primary,
          borderRadius: AppRadius.mdAll,
        ),
      AppIconButtonVariant.tonal => BoxDecoration(
          color: backgroundColor ?? cs.secondaryContainer,
          borderRadius: AppRadius.mdAll,
        ),
      AppIconButtonVariant.outlined => BoxDecoration(
          border: Border.all(color: borderColor ?? cs.outline),
          borderRadius: AppRadius.mdAll,
        ),
      AppIconButtonVariant.standard => null,
    };

    final btn = Opacity(
      opacity: isDisabled ? 0.48 : 1.0,
      child: Container(
        decoration: decoration,
        child: IconButton(
          icon: iconWidget,
          onPressed: effectiveOnPressed,
          tooltip: tooltip,
          padding: EdgeInsets.all(size * 0.3),
          constraints: BoxConstraints(
            minWidth: size + (size * 0.6),
            minHeight: size + (size * 0.6),
          ),
        ),
      ),
    );

    return btn;
  }
}
