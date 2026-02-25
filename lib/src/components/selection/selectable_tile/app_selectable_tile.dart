import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppSelectableTile extends StatelessWidget {
  const AppSelectableTile({
    required this.title,
    required this.selected,
    required this.onTap,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.activeColor,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = activeColor ?? cs.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? color.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: AppRadius.mdAll,
        border: Border.all(
          color: selected ? color : AppColors.borderDefault,
          width: selected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.mdAll,
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  const SizedBox(width: AppSpacing.sm)
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title,
                          style: AppTypography.bodyMedium.copyWith(
                            color: selected ? color : AppColors.textPrimary,
                            fontWeight: selected
                                ? AppTypography.weightSemiBold
                                : AppTypography.weightRegular,
                          )),
                      if (subtitle != null)
                        Text(subtitle!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            )),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
                if (selected) Icon(Icons.check_circle, color: color, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
