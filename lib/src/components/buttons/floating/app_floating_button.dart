import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';

enum AppFabSize { mini, standard, large, extended }

class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.label,
    this.size = AppFabSize.standard,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
    this.heroTag,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;
  final AppFabSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? tooltip;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.primary;
    final fg = foregroundColor ?? AppColors.white;

    if (label != null || size == AppFabSize.extended) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(icon, color: fg),
        label: Text(label ?? '', style: TextStyle(color: fg)),
        backgroundColor: bg,
        tooltip: tooltip,
        heroTag: heroTag,
      );
    }

    return switch (size) {
      AppFabSize.mini => FloatingActionButton.small(
          onPressed: onPressed,
          backgroundColor: bg,
          foregroundColor: fg,
          tooltip: tooltip,
          heroTag: heroTag,
          child: Icon(icon),
        ),
      AppFabSize.large => FloatingActionButton.large(
          onPressed: onPressed,
          backgroundColor: bg,
          foregroundColor: fg,
          tooltip: tooltip,
          heroTag: heroTag,
          child: Icon(icon),
        ),
      _ => FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: bg,
          foregroundColor: fg,
          tooltip: tooltip,
          heroTag: heroTag,
          child: Icon(icon),
        ),
    };
  }
}
