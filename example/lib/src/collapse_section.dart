import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CollapseSection extends StatefulWidget {
  const CollapseSection({super.key});

  @override
  State<CollapseSection> createState() => _CollapseSectionState();
}

class _CollapseSectionState extends State<CollapseSection> {
  bool _showDefault = false;
  bool _showHorizontal = false;

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
              'Collapse',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Collapse',
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
                      Expanded(child: _buildDefaultCard()),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildHorizontalCard()),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildDefaultCard(),
                const SizedBox(height: AppSpacing.s4),
                _buildHorizontalCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCardHeader(String title, String subtitle) {
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

  Widget _buildDefaultCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            'Default Example',
            'Click the buttons below to show and hide another element via class changes:',
          ),
          Wrap(
            spacing: 8,
            children: [
              AppButton(
                label: 'Toggle Collapse',
                onPressed: () => setState(() => _showDefault = !_showDefault),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppCollapse(
            show: _showDefault,
            child: AppCard(
              backgroundColor: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodyBg,
              child: const Text(
                'Some placeholder content for the collapse component. This panel is hidden by default but revealed when the user activates the relevant trigger.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            'Horizontal',
            'The collapse plugin also supports horizontal collapsing. Transition the width instead of height.',
          ),
          AppButton(
            label: 'Toggle Width Collapse',
            onPressed: () => setState(() => _showHorizontal = !_showHorizontal),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: AppCollapse(
              show: _showHorizontal,
              axis: AppCollapseAxis.horizontal,
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodyBg,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).extension<AppColorsExtension>()!.borderColor,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'This is some placeholder content for a horizontal collapse. It\'s hidden by default and shown when triggered.',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
