import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppTimelineItem {
  const AppTimelineItem({
    required this.title,
    this.subtitle,
    this.time,
    this.icon,
    this.iconColor,
    this.trailing,
  });
  final String title;
  final String? subtitle;
  final String? time;
  final IconData? icon;
  final Color? iconColor;
  final Widget? trailing;
}

class AppTimeline extends StatelessWidget {
  const AppTimeline({
    required this.items, super.key,
    this.dotSize = 12.0,
    this.lineWidth = 2.0,
    this.lineColor,
    this.defaultDotColor,
  });

  final List<AppTimelineItem> items;
  final double dotSize;
  final double lineWidth;
  final Color? lineColor;
  final Color? defaultDotColor;

  @override
  Widget build(BuildContext context) {
    final lc = lineColor ?? AppColors.borderDefault;
    final dc = defaultDotColor ?? AppColors.primary;

    return Column(
      children: List.generate(items.length, (i) {
        final item = items[i];
        final isLast = i == items.length - 1;
        final dotColor = item.iconColor ?? dc;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline dot + line
              Column(
                children: [
                  Container(
                    width: dotSize,
                    height: dotSize,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                    child: item.icon != null
                        ? Icon(item.icon,
                            size: dotSize * 0.6, color: AppColors.white)
                        : null,
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: lineWidth,
                        color: lc,
                        margin: EdgeInsets.symmetric(
                            horizontal: (dotSize - lineWidth) / 2),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(item.title,
                                style: AppTypography.bodyMedium.copyWith(
                                  fontWeight: AppTypography.weightSemiBold,
                                )),
                            if (item.subtitle != null)
                              Text(item.subtitle!,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  )),
                          ],
                        ),
                      ),
                      if (item.time != null)
                        Text(item.time!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textTertiary,
                            )),
                      if (item.trailing != null) item.trailing!,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
