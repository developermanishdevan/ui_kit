import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

enum AppSnackbarType { info, success, warning, error }

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    AppSnackbarType type = AppSnackbarType.info,
    String? action,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    final (bg, fg, icon) = switch (type) {
      AppSnackbarType.success => (
          AppColors.success,
          AppColors.white,
          Icons.check_circle
        ),
      AppSnackbarType.warning => (
          AppColors.warning,
          AppColors.white,
          Icons.warning_amber
        ),
      AppSnackbarType.error => (AppColors.error, AppColors.white, Icons.error),
      AppSnackbarType.info => (AppColors.grey900, AppColors.white, Icons.info),
    };

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          behavior: SnackBarBehavior.floating,
          backgroundColor: bg,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          margin: const EdgeInsets.all(AppSpacing.base),
          content: Row(
            children: [
              Icon(icon, color: fg, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(message,
                    style: AppTypography.bodyMedium.copyWith(color: fg)),
              ),
            ],
          ),
          action: action != null
              ? SnackBarAction(
                  label: action,
                  textColor: fg,
                  onPressed: onAction ?? () {},
                )
              : null,
        ),
      );
  }
}
