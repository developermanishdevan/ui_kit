import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TooltipSection extends StatelessWidget {
  const TooltipSection({super.key});

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
              'Tooltips',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Tooltips',
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
                      Expanded(child: _buildDirectionCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildColorCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  _buildLinksCard(context),
                ],
              );
            }

            return Column(
              children: [
                _buildDirectionCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildColorCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildLinksCard(context),
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

  Widget _buildDirectionCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Tooltip Direction',
            'Four options are available: top, right, bottom, and left aligned.',
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              AppTooltip(
                message: 'Tooltip on top',
                placement: AppTooltipPlacement.top,
                child: AppButton(label: 'Tooltip on top', onPressed: () {}),
              ),
              AppTooltip(
                message: 'Tooltip on bottom',
                placement: AppTooltipPlacement.bottom,
                child: AppButton(label: 'Tooltip on bottom', onPressed: () {}),
              ),
              AppTooltip(
                message: 'Tooltip on left',
                placement: AppTooltipPlacement.left,
                child: AppButton(label: 'Tooltip on left', onPressed: () {}),
              ),
              AppTooltip(
                message: 'Tooltip on right',
                placement: AppTooltipPlacement.right,
                child: AppButton(label: 'Tooltip on right', onPressed: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Color Tooltip',
            'We set a custom class to scope our background-color appearance.',
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              AppTooltip(
                message: 'Primary tooltip content',
                variant: AppTooltipVariant.primary,
                child: AppButton(label: 'Primary tooltip', onPressed: () {}),
              ),
              AppTooltip(
                message: 'Danger tooltip content',
                variant: AppTooltipVariant.danger,
                child: AppButton(
                  label: 'Danger tooltip',
                  color: AppButtonColor.danger,
                  onPressed: () {},
                ),
              ),
              AppTooltip(
                message: 'Success tooltip content',
                variant: AppTooltipVariant.success,
                child: AppButton(
                  label: 'Success tooltip',
                  color: AppButtonColor.success,
                  onPressed: () {},
                ),
              ),
              AppTooltip(
                message: 'Info tooltip content',
                variant: AppTooltipVariant.info,
                child: AppButton(
                  label: 'Info tooltip',
                  color: AppButtonColor.info,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLinksCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Tooltips on links',
            'Hover over the links below to see tooltips:',
          ),
          RichText(
            text: TextSpan(
              style: AppTypography.bodyBase.copyWith(color: theme.bodyColor),
              children: [
                const TextSpan(text: 'Placeholder text to demonstrate some '),
                WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: AppTooltip(
                    message: 'Default tooltip',
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'inline links ',
                        style: TextStyle(
                          color: theme.danger,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
                const TextSpan(
                  text:
                      'with tooltips. This is now just filler, no killer. Content placed here just to mimic the presence of ',
                ),
                WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: AppTooltip(
                    message: 'Another tooltip',
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'real text ',
                        style: TextStyle(
                          color: theme.danger,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
                const TextSpan(
                  text:
                      '. And all that just to give you an idea of how tooltips would look when used in real-world situations.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
