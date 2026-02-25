import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';
import '../card/app_card.dart';

class AppStatCard extends StatelessWidget {
  const AppStatCard({
    required this.title,
    required this.value,
    super.key,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.trend,
    this.trendPositive,
    this.onTap,
  });

  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final String? trend;
  final bool? trendPositive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final trendColor = trendPositive == true
        ? AppColors.success
        : trendPositive == false
            ? AppColors.error
            : AppColors.textSecondary;

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                    )),
              ),
              if (icon != null)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color:
                        (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon,
                      size: 18, color: iconColor ?? AppColors.primary),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value,
              style: AppTypography.displaySmall.copyWith(
                fontWeight: AppTypography.weightBold,
              )),
          if (subtitle != null || trend != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                if (trend != null) ...[
                  Icon(
                    trendPositive == true
                        ? Icons.trending_up
                        : Icons.trending_down,
                    size: 14,
                    color: trendColor,
                  ),
                  const SizedBox(width: 4),
                  Text(trend!,
                      style: AppTypography.caption.copyWith(
                        color: trendColor,
                        fontWeight: AppTypography.weightSemiBold,
                      )),
                  const SizedBox(width: 8),
                ],
                if (subtitle != null)
                  Expanded(
                    child: Text(subtitle!,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        )),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
