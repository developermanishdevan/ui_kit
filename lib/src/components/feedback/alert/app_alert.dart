import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

enum AppAlertType { info, success, warning, error }

class AppAlert extends StatelessWidget {
  const AppAlert({
    required this.message,
    super.key,
    this.title,
    this.type = AppAlertType.info,
    this.onDismiss,
    this.action,
    this.onAction,
    this.icon,
  });

  final String message;
  final String? title;
  final AppAlertType type;
  final VoidCallback? onDismiss;
  final String? action;
  final VoidCallback? onAction;
  final IconData? icon;

  static const _configs = {
    AppAlertType.info: (
      AppColors.infoLight,
      AppColors.info,
      Icons.info_outline
    ),
    AppAlertType.success: (
      AppColors.successLight,
      AppColors.success,
      Icons.check_circle_outline
    ),
    AppAlertType.warning: (
      AppColors.warningLight,
      AppColors.warning,
      Icons.warning_amber_outlined
    ),
    AppAlertType.error: (
      AppColors.errorLight,
      AppColors.error,
      Icons.error_outline
    ),
  };

  @override
  Widget build(BuildContext context) {
    final (bg, fg, defaultIcon) = _configs[type]!;
    final effectiveIcon = icon ?? defaultIcon;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(effectiveIcon, color: fg, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(title!,
                      style: AppTypography.labelLarge.copyWith(color: fg)),
                Text(message,
                    style: AppTypography.bodySmall.copyWith(
                      color: fg.withValues(alpha: 0.85),
                    )),
                if (action != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  GestureDetector(
                    onTap: onAction,
                    child: Text(action!,
                        style: AppTypography.labelSmall.copyWith(
                          color: fg,
                          decoration: TextDecoration.underline,
                        )),
                  ),
                ],
              ],
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child:
                  Icon(Icons.close, size: 18, color: fg.withValues(alpha: 0.7)),
            ),
        ],
      ),
    );
  }
}
