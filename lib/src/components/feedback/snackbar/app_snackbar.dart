import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

enum AppSnackbarVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    AppSnackbarVariant variant = AppSnackbarVariant.dark,
    Duration duration = const Duration(seconds: 4),
    bool showCloseIcon = true,
  }) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;

    Color bgColor;
    Color textColor;
    Color actionColor;

    switch (variant) {
      case AppSnackbarVariant.primary:
        bgColor = colors.primary;
        textColor = Colors.white;
        actionColor = Colors.white.withValues(alpha: 0.9);
        break;
      case AppSnackbarVariant.secondary:
        bgColor = colors.secondary;
        textColor = Colors.white;
        actionColor = Colors.white.withValues(alpha: 0.9);
        break;
      case AppSnackbarVariant.success:
        bgColor = colors.success;
        textColor = Colors.white;
        actionColor = Colors.white.withValues(alpha: 0.9);
        break;
      case AppSnackbarVariant.danger:
        bgColor = colors.danger;
        textColor = Colors.white;
        actionColor = Colors.white.withValues(alpha: 0.9);
        break;
      case AppSnackbarVariant.warning:
        bgColor = colors.warning;
        textColor = Colors.black87;
        actionColor = Colors.black87.withValues(alpha: 0.8);
        break;
      case AppSnackbarVariant.info:
        bgColor = colors.info;
        textColor = Colors.white;
        actionColor = Colors.white.withValues(alpha: 0.9);
        break;
      case AppSnackbarVariant.light:
        bgColor = colors.light;
        textColor = colors.dark;
        actionColor = colors.primary;
        break;
      case AppSnackbarVariant.dark:
        bgColor = colors.dark;
        textColor = Colors.white;
        actionColor = colors.primary;
        break;
    }

    final isLargeScreen = MediaQuery.sizeOf(context).width > 768;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.only(left: 16, right: 8),
        content: AppSemantics(
          label: 'Notification: $message',
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    message,
                    style: typography.bodyBase.copyWith(
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    onAction();
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    actionLabel,
                    style: typography.bodyBase.copyWith(
                      color: actionColor,
                      fontWeight: AppTypography.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
              if (showCloseIcon) ...[
                const SizedBox(width: 4),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 16,
                    color: textColor.withValues(alpha: 0.6),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ],
          ),
        ),
        backgroundColor: bgColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 4,
        width: isLargeScreen ? 400 : null,
        margin: isLargeScreen ? null : const EdgeInsets.all(16),
      ),
    );
  }
}
