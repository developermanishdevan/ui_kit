import 'package:flutter/material.dart';
import '../../foundation/tokens/spacing/app_spacing.dart';
import '../../foundation/tokens/typography/app_typography.dart';
import '../../foundation/tokens/colors/app_colors.dart';

class AppFormSection extends StatelessWidget {
  const AppFormSection({
    required this.title, required this.children, super.key,
    this.description,
    this.collapsed = false,
    this.collapsible = false,
  });

  final String title;
  final String? description;
  final List<Widget> children;
  final bool collapsed;
  final bool collapsible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: AppTypography.titleMedium),
        if (description != null) ...[
          const SizedBox(height: 2),
          Text(description!,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              )),
        ],
        const SizedBox(height: AppSpacing.md),
        ...children.map((c) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: c,
            )),
      ],
    );
  }
}

class AppValidationMessage extends StatelessWidget {
  const AppValidationMessage(
    this.message, {
    super.key,
    this.isError = true,
  });

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isError ? Icons.error_outline : Icons.check_circle_outline,
          size: 14,
          color: isError ? AppColors.error : AppColors.success,
        ),
        const SizedBox(width: 4),
        Text(message,
            style: AppTypography.caption.copyWith(
              color: isError ? AppColors.error : AppColors.success,
            )),
      ],
    );
  }
}
