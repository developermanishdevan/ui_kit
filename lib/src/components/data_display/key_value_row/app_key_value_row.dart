import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppKeyValueRow extends StatelessWidget {
  const AppKeyValueRow({
    required this.label, required this.value, super.key,
    this.labelStyle,
    this.valueStyle,
    this.trailing,
    this.copyable = false,
    this.padding,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Widget? trailing;
  final bool copyable;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: labelStyle ??
                  AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: valueStyle ??
                  AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
          if (copyable)
            GestureDetector(
              onTap: () {
                // Copy to clipboard
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Copied!'), duration: Duration(seconds: 1)),
                );
              },
              child: const Icon(Icons.copy,
                  size: 16, color: AppColors.textTertiary),
            ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
