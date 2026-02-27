import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A wrapper widget that provides a retry mechanism.
class AppRetryWrapper extends AppStatelessWrapper {
  final Widget child;
  final bool isError;
  final String? errorText;
  final VoidCallback onRetry;
  final String retryLabel;

  const AppRetryWrapper({
    super.key,
    required this.child,
    required this.isError,
    required this.onRetry,
    this.errorText = 'Failed to load content',
    this.retryLabel = 'Retry',
  });

  @override
  Widget buildWidget(BuildContext context) {
    if (!isError) return child;

    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return Center(
      child: Container(
        padding: EdgeInsets.all(spacing.s4),
        decoration: BoxDecoration(
          color: colors.danger.withValues(alpha: 0.05),
          border: Border.all(color: colors.danger.withValues(alpha: 0.2)),
          borderRadius: radii.base,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: colors.danger, size: 32),
            SizedBox(height: spacing.s3),
            Text(
              errorText!,
              style: typography.bodyBase.copyWith(
                color: colors.textEmphasis,
                fontWeight: AppTypography.semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spacing.s4),
            AppButton(
              label: retryLabel,
              onPressed: onRetry,
              color: AppButtonColor.danger,
              variant: AppButtonVariant.outline,
              size: AppButtonSize.sm,
            ),
          ],
        ),
      ),
    );
  }
}
