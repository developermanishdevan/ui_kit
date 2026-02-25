import 'package:flutter/material.dart';
import '../../foundation/tokens/colors/app_colors.dart';
import '../../foundation/tokens/typography/app_typography.dart';

class AppBreadcrumbItem {
  const AppBreadcrumbItem({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;
}

class AppBreadcrumb extends StatelessWidget {
  const AppBreadcrumb({
    required this.items, super.key,
    this.separator = '/',
    this.activeColor,
    this.inactiveColor,
    this.style,
  });

  final List<AppBreadcrumbItem> items;
  final String separator;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final active = activeColor ?? AppColors.primary;
    final inactive = inactiveColor ?? AppColors.textSecondary;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(items.length * 2 - 1, (i) {
        if (i.isOdd) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(separator,
                style: (style ?? AppTypography.bodySmall)
                    .copyWith(color: inactive)),
          );
        }
        final idx = i ~/ 2;
        final item = items[idx];
        final isLast = idx == items.length - 1;
        return GestureDetector(
          onTap: item.onTap,
          child: Text(
            item.label,
            style: (style ?? AppTypography.bodySmall).copyWith(
              color: isLast ? inactive : active,
              decoration: (!isLast && item.onTap != null)
                  ? TextDecoration.underline
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
