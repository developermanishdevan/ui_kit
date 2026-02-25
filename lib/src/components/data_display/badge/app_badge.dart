import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

enum AppBadgeVariant { filled, outlined, light }

enum AppBadgeColor { primary, success, warning, error, info, neutral }

class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.label, super.key,
    this.variant = AppBadgeVariant.filled,
    this.color = AppBadgeColor.primary,
    this.icon,
    this.dot = false,
  });

  final String label;
  final AppBadgeVariant variant;
  final AppBadgeColor color;
  final IconData? icon;
  final bool dot;

  static const _bgColors = {
    AppBadgeColor.primary: AppColors.primaryLight,
    AppBadgeColor.success: AppColors.successLight,
    AppBadgeColor.warning: AppColors.warningLight,
    AppBadgeColor.error: AppColors.errorLight,
    AppBadgeColor.info: AppColors.infoLight,
    AppBadgeColor.neutral: AppColors.grey100,
  };

  static const _fgColors = {
    AppBadgeColor.primary: AppColors.primary,
    AppBadgeColor.success: AppColors.success,
    AppBadgeColor.warning: AppColors.warning,
    AppBadgeColor.error: AppColors.error,
    AppBadgeColor.info: AppColors.info,
    AppBadgeColor.neutral: AppColors.textSecondary,
  };

  @override
  Widget build(BuildContext context) {
    final bg = _bgColors[color]!;
    final fg = _fgColors[color]!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.px2,
      ),
      decoration: BoxDecoration(
        color: variant == AppBadgeVariant.outlined ? Colors.transparent : bg,
        borderRadius: AppRadius.fullAll,
        border:
            variant == AppBadgeVariant.outlined ? Border.all(color: fg) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot)
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
              margin: const EdgeInsets.only(right: 4),
            ),
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(label, style: AppTypography.labelSmall.copyWith(color: fg)),
        ],
      ),
    );
  }
}
