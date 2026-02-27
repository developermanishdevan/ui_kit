import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class SnackbarSection extends StatelessWidget {
  const SnackbarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Snackbars',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Snackbars',
              style: AppTypography.bodySm.copyWith(
                color: theme.bodySecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),

        LayoutBuilder(
          builder: (context, constraints) {
            final isLarge = constraints.maxWidth > 992;

            if (isLarge) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildBasicCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildVariantsCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildBasicCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildVariantsCard(context),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCardHeader(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.h5.copyWith(
            fontWeight: AppTypography.semiBold,
            color: theme.textEmphasis,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTypography.bodySm.copyWith(
            color: theme.bodySecondaryColor,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
      ],
    );
  }

  Widget _buildBasicCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Basic Examples',
            'Snackbars provide brief messages about app processes at the bottom of the screen.',
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppButton(
                label: 'Show Default Snackbar',
                onPressed: () {
                  AppSnackbar.show(
                    context,
                    message: 'This is a standard snackbar message.',
                  );
                },
              ),
              AppButton(
                label: 'Show with Action',
                color: AppButtonColor.secondary,
                onPressed: () {
                  AppSnackbar.show(
                    context,
                    message: 'File has been deleted successfully.',
                    actionLabel: 'UNDO',
                    onAction: () {
                      // Handle undo
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVariantsCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Color Variants',
            'Apply different brand colors to emphasize the context of the message.',
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppButton(
                label: 'Success',
                color: AppButtonColor.success,
                onPressed: () => AppSnackbar.show(
                  context,
                  message: 'Operation completed successfully!',
                  variant: AppSnackbarVariant.success,
                ),
              ),
              AppButton(
                label: 'Danger',
                color: AppButtonColor.danger,
                onPressed: () => AppSnackbar.show(
                  context,
                  message: 'An error occurred. Please try again.',
                  variant: AppSnackbarVariant.danger,
                ),
              ),
              AppButton(
                label: 'Warning',
                color: AppButtonColor.warning,
                onPressed: () => AppSnackbar.show(
                  context,
                  message: 'Storage is almost full.',
                  variant: AppSnackbarVariant.warning,
                ),
              ),
              AppButton(
                label: 'Info',
                color: AppButtonColor.info,
                onPressed: () => AppSnackbar.show(
                  context,
                  message: 'A new update is available.',
                  variant: AppSnackbarVariant.info,
                ),
              ),
              AppButton(
                label: 'Primary',
                onPressed: () => AppSnackbar.show(
                  context,
                  message: 'Primary theme snackbar.',
                  variant: AppSnackbarVariant.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
