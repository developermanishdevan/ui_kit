import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';

class AppInputChip extends StatelessWidget {
  const AppInputChip({
    required this.label, super.key,
    this.onDeleted,
    this.onPressed,
    this.avatar,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onDeleted;
  final VoidCallback? onPressed;
  final Widget? avatar;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(label),
      onDeleted: enabled ? onDeleted : null,
      onPressed: enabled ? onPressed : null,
      avatar: avatar,
      labelStyle: AppTypography.labelMedium,
      backgroundColor: AppColors.surfaceVariant,
      deleteIconColor: AppColors.textSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.smAll,
        side: BorderSide(color: AppColors.borderDefault),
      ),
    );
  }
}
