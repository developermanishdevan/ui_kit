import 'package:flutter/material.dart';
import '../../../foundation/tokens/colors/app_colors.dart';
import '../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../foundation/tokens/typography/app_typography.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.text,
    this.color,
    this.thickness = 1.0,
    this.indent = 0,
    this.endIndent = 0,
    this.margin,
  });

  final String? text;
  final Color? color;
  final double thickness;
  final double indent;
  final double endIndent;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.borderDefault;

    if (text == null) {
      return Container(
        margin: margin ?? const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Divider(
          color: c,
          thickness: thickness,
          indent: indent,
          endIndent: endIndent,
        ),
      );
    }

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
              child: Divider(color: c, thickness: thickness, indent: indent)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Text(text!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary,
                )),
          ),
          Expanded(
              child: Divider(
                  color: c, thickness: thickness, endIndent: endIndent)),
        ],
      ),
    );
  }
}
