import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

enum AppEmptyStateVariant {
  empty,
  error,
  noInternet,
  maintenance,
  permission,
  success,
}

/// A premium Empty State component for various feedback scenarios.
class AppEmptyState extends AppStatelessWrapper {
  final AppEmptyStateVariant variant;
  final String? title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? customIcon;
  final double iconSize;

  const AppEmptyState({
    super.key,
    this.variant = AppEmptyStateVariant.empty,
    this.title,
    this.description,
    this.actionLabel,
    this.onAction,
    this.customIcon,
    this.iconSize = 80,
  });

  IconData _getIcon() {
    switch (variant) {
      case AppEmptyStateVariant.empty:
        return Icons.inbox_outlined;
      case AppEmptyStateVariant.error:
        return Icons.error_outline;
      case AppEmptyStateVariant.noInternet:
        return Icons.wifi_off_outlined;
      case AppEmptyStateVariant.maintenance:
        return Icons.construction_outlined;
      case AppEmptyStateVariant.permission:
        return Icons.lock_outline;
      case AppEmptyStateVariant.success:
        return Icons.check_circle_outline;
    }
  }

  String _getDefaultTitle() {
    switch (variant) {
      case AppEmptyStateVariant.empty:
        return 'No Data Found';
      case AppEmptyStateVariant.error:
        return 'Something went wrong';
      case AppEmptyStateVariant.noInternet:
        return 'No Internet Connection';
      case AppEmptyStateVariant.maintenance:
        return 'Under Maintenance';
      case AppEmptyStateVariant.permission:
        return 'Access Denied';
      case AppEmptyStateVariant.success:
        return 'Operation Successful';
    }
  }

  String _getDefaultDescription() {
    switch (variant) {
      case AppEmptyStateVariant.empty:
        return 'We couldn\'t find any records here.';
      case AppEmptyStateVariant.error:
        return 'An unexpected error occurred. Please try again later.';
      case AppEmptyStateVariant.noInternet:
        return 'Please check your connection and try again.';
      case AppEmptyStateVariant.maintenance:
        return 'We are currently updating our systems. Please check back soon.';
      case AppEmptyStateVariant.permission:
        return 'You don\'t have permission to view this content.';
      case AppEmptyStateVariant.success:
        return 'Your action has been completed successfully.';
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return AppSemantics(
      label: 'Empty state: ${title ?? _getDefaultTitle()}',
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.s4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customIcon ??
                  Icon(
                    _getIcon(),
                    size: iconSize,
                    color: colors.primary.withValues(alpha: 0.5),
                  ),
              SizedBox(height: spacing.s4),
              Text(
                title ?? _getDefaultTitle(),
                style: typography.h4.copyWith(
                  color: colors.textEmphasis,
                  fontWeight: AppTypography.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spacing.s2),
              Text(
                description ?? _getDefaultDescription(),
                style: typography.bodyBase.copyWith(
                  color: colors.bodySecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              if (actionLabel != null && onAction != null) ...[
                SizedBox(height: spacing.s5),
                AppButton(
                  label: actionLabel!,
                  onPressed: onAction,
                  color: AppButtonColor.primary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
