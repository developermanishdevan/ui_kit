import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    this.icon = Icons.inbox_outlined,
    this.title = 'Nothing here',
    this.message,
    this.action,
    this.onAction,
    this.iconSize = 64.0,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? action;
  final VoidCallback? onAction;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) => _StateWidget(
        icon: icon,
        title: title,
        message: message,
        action: action,
        onAction: onAction,
        iconSize: iconSize,
        iconColor: iconColor ?? AppColors.grey300,
      );
}

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    this.title = 'Something went wrong',
    this.message,
    this.onRetry,
  });
  final String title;
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => _StateWidget(
        icon: Icons.error_outline,
        title: title,
        message: message,
        action: onRetry != null ? 'Try Again' : null,
        onAction: onRetry,
        iconColor: AppColors.error,
      );
}

class AppSuccessState extends StatelessWidget {
  const AppSuccessState({
    super.key,
    this.title = 'All done!',
    this.message,
    this.action,
    this.onAction,
  });
  final String title;
  final String? message;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => _StateWidget(
        icon: Icons.check_circle_outline,
        title: title,
        message: message,
        action: action,
        onAction: onAction,
        iconColor: AppColors.success,
      );
}

class AppNoInternetState extends StatelessWidget {
  const AppNoInternetState({super.key, this.onRetry});
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => _StateWidget(
        icon: Icons.wifi_off,
        title: 'No internet connection',
        message: 'Please check your network and try again.',
        action: onRetry != null ? 'Retry' : null,
        onAction: onRetry,
        iconColor: AppColors.grey400,
      );
}

class _StateWidget extends StatelessWidget {
  const _StateWidget({
    required this.icon,
    required this.title,
    this.message,
    this.action,
    this.onAction,
    this.iconSize = 64.0,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? action;
  final VoidCallback? onAction;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize, color: iconColor ?? AppColors.grey300),
            const SizedBox(height: AppSpacing.base),
            Text(title,
                style: AppTypography.headlineSmall,
                textAlign: TextAlign.center),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(message!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center),
            ],
            if (action != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.xl),
              FilledButton(onPressed: onAction, child: Text(action!)),
            ],
          ],
        ),
      ),
    );
  }
}
