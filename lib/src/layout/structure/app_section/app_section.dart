import 'package:flutter/material.dart';
import '../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../foundation/tokens/typography/app_typography.dart';
import '../../../foundation/tokens/colors/app_colors.dart';

class AppSection extends StatelessWidget {
  const AppSection({
    required this.title, required this.child, super.key,
    this.subtitle,
    this.trailing,
    this.padding,
    this.margin,
    this.showDivider = false,
  });

  final String title;
  final Widget child;
  final String? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: AppTypography.weightBold,
                        )),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          )),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          child,
          if (showDivider) ...[
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}
