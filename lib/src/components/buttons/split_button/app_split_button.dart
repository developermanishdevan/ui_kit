import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';

class AppSplitButton extends StatelessWidget {
  const AppSplitButton({
    required this.label,
    required this.onPressed,
    required this.onDropdownPressed,
    super.key,
    this.icon,
    this.height = 44,
    this.backgroundColor,
    this.foregroundColor,
    this.dropdownIcon = Icons.keyboard_arrow_down,
  });

  final String label;
  final VoidCallback onPressed;
  final VoidCallback onDropdownPressed;
  final IconData? icon;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData dropdownIcon;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.primary;
    final fg = foregroundColor ?? AppColors.white;

    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main action
          Material(
            color: bg,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.md),
              bottomLeft: Radius.circular(AppRadius.md),
            ),
            child: InkWell(
              onTap: onPressed,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.md),
                bottomLeft: Radius.circular(AppRadius.md),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 18, color: fg),
                      const SizedBox(width: 8),
                    ],
                    Text(label,
                        style: AppTypography.labelLarge.copyWith(color: fg)),
                  ],
                ),
              ),
            ),
          ),
          // Divider
          Container(
              width: 1, color: fg.withValues(alpha: 0.3), height: height * 0.6),
          // Dropdown trigger
          Material(
            color: bg,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(AppRadius.md),
              bottomRight: Radius.circular(AppRadius.md),
            ),
            child: InkWell(
              onTap: onDropdownPressed,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(AppRadius.md),
                bottomRight: Radius.circular(AppRadius.md),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(dropdownIcon, size: 20, color: fg),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
