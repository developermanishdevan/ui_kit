import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class SpinnerSection extends StatelessWidget {
  const SpinnerSection({super.key});

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
              'Spinners',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Spinners',
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
                      Expanded(child: _buildBorderSpinnersCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildColorSpinnersCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildGrowingSpinnersCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildColorGrowingSpinnersCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildSizeSpinnersCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildButtonSpinnersCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildBorderSpinnersCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildColorSpinnersCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildGrowingSpinnersCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildColorGrowingSpinnersCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildSizeSpinnersCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildButtonSpinnersCard(context),
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

  Widget _buildBorderSpinnersCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Border Spinners',
            'Use the border spinners for a lightweight loading indicator.',
          ),
          const AppSpinner(),
        ],
      ),
    );
  }

  Widget _buildColorSpinnersCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Color Spinners',
            'You can use any of theme colors on the standard spinner.',
          ),
          Wrap(
            spacing: 16,
            children: [
              AppSpinner(color: theme.primary),
              AppSpinner(color: theme.secondary),
              AppSpinner(color: theme.success),
              AppSpinner(color: theme.danger),
              AppSpinner(color: theme.warning),
              AppSpinner(color: theme.info),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrowingSpinnersCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Growing Spinners',
            "If you don't fancy a border spinner, switch to the grow spinner.",
          ),
          const AppSpinner(type: AppSpinnerType.grow),
        ],
      ),
    );
  }

  Widget _buildColorGrowingSpinnersCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Color Growing Spinners',
            'Any theme color can be applied to growing spinners.',
          ),
          Wrap(
            spacing: 16,
            children: [
              AppSpinner(type: AppSpinnerType.grow, color: theme.primary),
              AppSpinner(type: AppSpinnerType.grow, color: theme.secondary),
              AppSpinner(type: AppSpinnerType.grow, color: theme.success),
              AppSpinner(type: AppSpinnerType.grow, color: theme.danger),
              AppSpinner(type: AppSpinnerType.grow, color: theme.warning),
              AppSpinner(type: AppSpinnerType.grow, color: theme.info),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSpinnersCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Size',
            'Add .spinner-border-sm to make a smaller spinner.',
          ),
          const Wrap(
            spacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppSpinner(size: AppSpinnerSize.sm),
              AppSpinner(type: AppSpinnerType.grow, size: AppSpinnerSize.sm),
              AppSpinner(),
              AppSpinner(type: AppSpinnerType.grow),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSpinnersCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Buttons Spinner',
            'Use spinners within buttons to indicate processing.',
          ),
          const Wrap(
            spacing: 8,
            children: [
              AppButton(
                label: 'Loading...',
                icon: AppSpinner(
                  size: AppSpinnerSize.sm,
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              AppButton(
                label: 'Loading...',
                icon: AppSpinner(
                  type: AppSpinnerType.grow,
                  size: AppSpinnerSize.sm,
                  color: Colors.white,
                ),
                color: AppButtonColor.secondary,
                variant: AppButtonVariant.soft,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
