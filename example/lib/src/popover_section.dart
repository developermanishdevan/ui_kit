import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class PopoverSection extends StatelessWidget {
  const PopoverSection({super.key});

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
              'Popovers',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Popovers',
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
                      Expanded(child: _buildLiveDemoCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildDirectionsCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildTriggersCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildCustomThemedCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildLiveDemoCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildDirectionsCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildTriggersCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildCustomThemedCard(context),
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

  Widget _buildLiveDemoCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Live demo',
            'We render the following live popover on click with a title and body content.',
          ),
          Center(
            child: AppPopover(
              title: 'Popover title',
              content: const Text(
                "And here's some amazing content. It's very engaging. Right?",
              ),
              placement: AppPopoverPlacement.end,
              child: const AppButton(
                label: 'Click to toggle popover',
                color: AppButtonColor.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionsCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Popover Directions',
            'Four options are available: top, right, bottom, and left aligned.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildDirectionButton(context, 'Top', AppPopoverPlacement.top),
              _buildDirectionButton(context, 'End', AppPopoverPlacement.end),
              _buildDirectionButton(
                context,
                'Bottom',
                AppPopoverPlacement.bottom,
              ),
              _buildDirectionButton(
                context,
                'Start',
                AppPopoverPlacement.start,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionButton(
    BuildContext context,
    String label,
    AppPopoverPlacement placement,
  ) {
    return AppPopover(
      content: const Text(
        'Vivamus sagittis lacus vel augue laoreet rutrum faucibus.',
      ),
      placement: placement,
      child: AppButton(
        label: 'Popover on $label',
        color: AppButtonColor.primary,
      ),
    );
  }

  Widget _buildTriggersCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Triggers',
            'Popovers can be triggered on click or on hover.',
          ),
          Wrap(
            spacing: 8,
            children: [
              const AppPopover(
                title: 'Click Trigger',
                content: Text(
                  'This popover appeared because you clicked the button.',
                ),
                trigger: AppPopoverTrigger.click,
                child: AppButton(
                  label: 'Click Me',
                  color: AppButtonColor.success,
                ),
              ),
              AppPopover(
                title: 'Hover Trigger',
                content: const Text(
                  'This popover appears when you hover over the button.',
                ),
                trigger: AppPopoverTrigger.hover,
                child: AppButton(label: 'Hover Me', color: AppButtonColor.dark),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomThemedCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Themed Popovers',
            'Customize the appearance of popovers using background and text colors.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildThemedButton(
                context,
                'Primary',
                theme.primary,
                Colors.white,
              ),
              _buildThemedButton(
                context,
                'Success',
                theme.success,
                Colors.white,
              ),
              _buildThemedButton(context, 'Danger', theme.danger, Colors.white),
              _buildThemedButton(context, 'Dark', theme.dark, Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemedButton(
    BuildContext context,
    String label,
    Color bg,
    Color text,
  ) {
    return AppPopover(
      title: '$label Popover',
      content: const Text('This popover is themed with custom state colors.'),
      backgroundColor: bg,
      textColor: text,
      placement: AppPopoverPlacement.top,
      child: AppButton(
        label: '$label popover',
        color: AppButtonColor.secondary,
        variant: AppButtonVariant.soft,
      ),
    );
  }
}
