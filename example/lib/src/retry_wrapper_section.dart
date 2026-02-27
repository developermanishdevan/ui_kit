import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class RetryWrapperSection extends StatefulWidget {
  const RetryWrapperSection({super.key});

  @override
  State<RetryWrapperSection> createState() => _RetryWrapperSectionState();
}

class _RetryWrapperSectionState extends State<RetryWrapperSection> {
  bool _showError = false;

  void _toggleError() => setState(() => _showError = !_showError);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                context,
                'Retry Wrapper',
                'Shows an error card with a retry button when operation fails.',
              ),
              AppRetryWrapper(
                isError: _showError,
                onRetry: _toggleError,
                errorText: 'Could not fetch user data. Please try again.',
                retryLabel: 'Try Again',
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: theme.success.withValues(alpha: 0.08),
                    border: Border.all(
                      color: theme.success.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.base),
                  ),
                  child: const Center(
                    child: AppSpinner(type: AppSpinnerType.grow),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              AppButton(
                label: _showError ? 'Resolve Error' : 'Simulate Error',
                onPressed: _toggleError,
                color: _showError
                    ? AppButtonColor.success
                    : AppButtonColor.danger,
                variant: AppButtonVariant.outline,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardHeader(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.h6.copyWith(
              fontWeight: AppTypography.semiBold,
              color: theme.textEmphasis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySm.copyWith(
              color: theme.bodySecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s3),
        ],
      ),
    );
  }
}
