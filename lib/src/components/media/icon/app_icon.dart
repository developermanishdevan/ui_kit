import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/icon_sizes/app_icon_sizes.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size = AppIconSizes.lg,
    this.color,
    this.semanticLabel,
  });

  final IconData icon;
  final double size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => Icon(
        icon,
        size: size,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        semanticLabel: semanticLabel,
      );
}

class AppIconBadge extends StatelessWidget {
  const AppIconBadge({
    required this.icon,
    super.key,
    this.count,
    this.dot = false,
    this.size = AppIconSizes.lg,
    this.iconColor,
    this.badgeColor,
    this.onTap,
  });

  final IconData icon;
  final int? count;
  final bool dot;
  final double size;
  final Color? iconColor;
  final Color? badgeColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconW = Icon(icon, size: size, color: iconColor);
    Widget w;

    if (dot) {
      w = Badge(child: iconW);
    } else if (count != null && count! > 0) {
      w = Badge(
        label: Text('${count! > 99 ? '99+' : count}'),
        backgroundColor: badgeColor ?? Theme.of(context).colorScheme.error,
        child: iconW,
      );
    } else {
      w = iconW;
    }

    return onTap != null ? GestureDetector(onTap: onTap, child: w) : w;
  }
}
