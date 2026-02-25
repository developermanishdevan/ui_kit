import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    required this.title, super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.padding,
    this.backgroundColor,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enabled;
  final bool selected;
  final bool dense;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListTile(
        title: Text(title,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: AppTypography.weightSemiBold,
              color: selected ? AppColors.primary : AppColors.textPrimary,
            )),
        subtitle: subtitle != null
            ? Text(subtitle!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ))
            : null,
        leading: leading,
        trailing: trailing,
        onTap: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        enabled: enabled,
        selected: selected,
        dense: dense,
        contentPadding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
      ),
    );
  }
}
