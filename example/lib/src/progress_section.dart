import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

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
              'Progress',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Progress',
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
                      Expanded(child: _buildWorksCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildBackgroundCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildStripedCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildHeightCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildWorksCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildBackgroundCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildStripedCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildHeightCard(context),
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

  Widget _buildWorksCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'How it works',
            'A progress bar can be used to show a user how far along he/she is in a process.',
          ),
          AppProgress(value: 0.1),
          const SizedBox(height: 15),
          AppProgress(value: 0.35),
          const SizedBox(height: 15),
          AppProgress(value: 0.5),
          const SizedBox(height: 15),
          AppProgress(value: 0.75),
          const SizedBox(height: 15),
          AppProgress(value: 0.25, label: '25%'),
        ],
      ),
    );
  }

  Widget _buildBackgroundCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Backgrounds Color',
            'Use background utility classes to change the appearance of individual progress bars.',
          ),
          AppProgress(value: 0.25, color: theme.primary),
          const SizedBox(height: 15),
          AppProgress(value: 0.5, color: theme.secondary),
          const SizedBox(height: 15),
          AppProgress(value: 0.75, color: theme.success),
          const SizedBox(height: 15),
          AppProgress(value: 1.0, color: theme.info),
          const SizedBox(height: 15),
          AppProgress.stacked(
            segments: [
              const AppProgressSegment(value: 0.15),
              AppProgressSegment(value: 0.3, color: theme.secondary),
              AppProgressSegment(value: 0.2, color: theme.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStripedCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Striped Progress Bar',
            'Add isStriped to any progress bar to apply a stripe over the background color.',
          ),
          AppProgress(value: 0.25, color: theme.primary, isStriped: true),
          const SizedBox(height: 15),
          AppProgress(value: 0.5, color: theme.secondary, isStriped: true),
          const SizedBox(height: 15),
          AppProgress(value: 0.75, color: theme.success, isStriped: true),
          const SizedBox(height: 15),
          AppProgress(
            value: 0.65,
            color: theme.info,
            isStriped: true,
            isAnimated: true,
          ),
          const SizedBox(height: 15),
          AppProgress(
            value: 1.0,
            color: theme.warning,
            isStriped: true,
            isAnimated: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHeightCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Height',
            'We set a height value on the progress. Use xs, sm, md, lg or xl sizes.',
          ),
          AppProgress(value: 0.25, size: AppProgressSize.xs),
          const SizedBox(height: 15),
          AppProgress(
            value: 0.5,
            color: theme.secondary,
            size: AppProgressSize.sm,
          ),
          const SizedBox(height: 15),
          AppProgress(
            value: 0.75,
            color: theme.success,
            size: AppProgressSize.md,
          ),
          const SizedBox(height: 15),
          AppProgress(value: 0.35, color: theme.info, size: AppProgressSize.lg),
          const SizedBox(height: 15),
          AppProgress(
            value: 0.6,
            color: theme.warning,
            size: AppProgressSize.xl,
          ),
        ],
      ),
    );
  }
}
