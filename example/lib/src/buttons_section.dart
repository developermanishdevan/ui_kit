import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ButtonsSection extends StatefulWidget {
  const ButtonsSection({super.key});

  @override
  State<ButtonsSection> createState() => _ButtonsSectionState();
}

class _ButtonsSectionState extends State<ButtonsSection> {
  Set<String> _segmentedValue = {'Day'};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Buttons',
            style: AppTypography.h2.copyWith(
              color: context.theme
                  .extension<AppColorsExtension>()!
                  .textEmphasis,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),

          _buildSectionCard(
            context,
            title: 'Segmented Button',
            subtitle:
                'Choice between multiple related options with premium chip style.',
            children: [
              AppSegmentedButton<String>(
                items: const [
                  AppSegmentedButtonItem(value: 'Day', label: 'Day'),
                  AppSegmentedButtonItem(value: 'Week', label: 'Week'),
                  AppSegmentedButtonItem(value: 'Month', label: 'Month'),
                ],
                selected: _segmentedValue,
                onSelectionChanged: (value) {
                  setState(() => _segmentedValue = value);
                },
              ),
              const SizedBox(width: AppSpacing.s4),
              AppSegmentedButton<String>(
                color: AppButtonColor.secondary,
                items: const [
                  AppSegmentedButtonItem(value: '1', label: 'Option 1'),
                  AppSegmentedButtonItem(value: '2', label: 'Option 2'),
                ],
                selected: const {'1'},
                onSelectionChanged: (value) {},
              ),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Segment Chips',
            subtitle:
                'Compact segmented controls often used for filtering or view switching.',
            children: [
              AppToggleButton(
                options: const ['Left', 'Center', 'Right'],
                selectedIndex: 0,
                onChanged: (index) {},
              ),
              const SizedBox(width: AppSpacing.s4),
              AppToggleButton(
                options: const ['Yearly', 'Monthly'],
                selectedIndex: 1,
                activeColor: AppButtonColor.success,
                onChanged: (index) {},
              ),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Default Buttons',
            subtitle:
                'Use the button classes on an <a>, <button> or <input> element.',
            children: [
              AppButton(label: 'Primary', onPressed: () {}),
              AppButton(
                label: 'Secondary',
                color: AppButtonColor.secondary,
                onPressed: () {},
              ),
              AppButton(
                label: 'Success',
                color: AppButtonColor.success,
                onPressed: () {},
              ),
              AppButton(
                label: 'Info',
                color: AppButtonColor.info,
                onPressed: () {},
              ),
              AppButton(
                label: 'Warning',
                color: AppButtonColor.warning,
                onPressed: () {},
              ),
              AppButton(
                label: 'Danger',
                color: AppButtonColor.danger,
                onPressed: () {},
              ),
              AppButton(
                label: 'Dark',
                color: AppButtonColor.dark,
                onPressed: () {},
              ),
              AppButton(
                label: 'Light',
                color: AppButtonColor.light,
                onPressed: () {},
              ),
              AppButton(
                label: 'Link',
                variant: AppButtonVariant.link,
                onPressed: () {},
              ),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Rounded Buttons',
            subtitle:
                'Add isRoundedPill to default button to get rounded corners.',
            children: [
              AppButton(
                label: 'Primary',
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Secondary',
                color: AppButtonColor.secondary,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Success',
                color: AppButtonColor.success,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Info',
                color: AppButtonColor.info,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Warning',
                color: AppButtonColor.warning,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Danger',
                color: AppButtonColor.danger,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Dark',
                color: AppButtonColor.dark,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Light',
                color: AppButtonColor.light,
                isRoundedPill: true,
                onPressed: () {},
              ),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Outline Buttons',
            subtitle:
                'Use variant: AppButtonVariant.outline to quickly create bordered buttons.',
            children: [
              AppButton(
                label: 'Primary',
                variant: AppButtonVariant.outline,
                onPressed: () {},
              ),
              AppButton(
                label: 'Secondary',
                variant: AppButtonVariant.outline,
                color: AppButtonColor.secondary,
                onPressed: () {},
              ),
              AppButton(
                label: 'Success',
                variant: AppButtonVariant.outline,
                color: AppButtonColor.success,
                onPressed: () {},
              ),
              AppButton(
                label: 'Info',
                variant: AppButtonVariant.outline,
                color: AppButtonColor.info,
                onPressed: () {},
              ),
              AppButton(
                label: 'Warning',
                variant: AppButtonVariant.outline,
                color: AppButtonColor.warning,
                onPressed: () {},
              ),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Soft Buttons',
            subtitle:
                'Use variant: AppButtonVariant.soft to quickly create buttons with soft background.',
            children: [
              AppButton(
                label: 'Primary',
                variant: AppButtonVariant.soft,
                onPressed: () {},
              ),
              AppButton(
                label: 'Secondary',
                variant: AppButtonVariant.soft,
                color: AppButtonColor.secondary,
                onPressed: () {},
              ),
              AppButton(
                label: 'Success',
                variant: AppButtonVariant.soft,
                color: AppButtonColor.success,
                onPressed: () {},
              ),
              AppButton(
                label: 'Info',
                variant: AppButtonVariant.soft,
                color: AppButtonColor.info,
                onPressed: () {},
              ),
              AppButton(
                label: 'Warning',
                variant: AppButtonVariant.soft,
                color: AppButtonColor.warning,
                onPressed: () {},
              ),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Soft Rounded Buttons',
            subtitle:
                'Use isRoundedPill with soft variant to quickly create Soft Rounded buttons.',
            children: [
              AppButton(
                label: 'Primary',
                variant: AppButtonVariant.soft,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Secondary',
                variant: AppButtonVariant.soft,
                color: AppButtonColor.secondary,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Success',
                variant: AppButtonVariant.soft,
                color: AppButtonColor.success,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Info',
                variant: AppButtonVariant.soft,
                color: AppButtonColor.info,
                isRoundedPill: true,
                onPressed: () {},
              ),
              AppButton(
                label: 'Warning',
                variant: AppButtonVariant.soft,
                color: AppButtonColor.warning,
                isRoundedPill: true,
                onPressed: () {},
              ),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Button Sizes',
            subtitle: 'Use size property for additional sizes.',
            children: [
              AppButton(
                label: 'Large',
                size: AppButtonSize.lg,
                onPressed: () {},
              ),
              AppButton(
                label: 'Normal',
                size: AppButtonSize.md,
                onPressed: () {},
              ),
              AppButton(
                label: 'Small',
                size: AppButtonSize.sm,
                onPressed: () {},
              ),
              AppButton(label: 'Xs', size: AppButtonSize.xs, onPressed: () {}),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Disabled Button',
            subtitle: 'Disabled by omitting onPressed attribute in buttons.',
            children: [
              const AppButton(label: 'Primary'),
              const AppButton(
                label: 'Secondary',
                color: AppButtonColor.secondary,
              ),
              const AppButton(label: 'Success', color: AppButtonColor.success),
              const AppButton(label: 'Info', color: AppButtonColor.info),
              const AppButton(label: 'Warning', color: AppButtonColor.warning),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Icon Button',
            subtitle: 'Icon only or Icon with text Button.',
            children: [
              AppIconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              AppIconButton(
                icon: const Icon(Icons.mic_none),
                color: AppButtonColor.secondary,
                onPressed: () {},
              ),
              AppIconButton(
                icon: const Icon(Icons.check),
                color: AppButtonColor.success,
                onPressed: () {},
              ),
              AppButton(
                label: 'Cloud Hosting',
                icon: const Icon(Icons.cloud_outlined),
                color: AppButtonColor.info,
                onPressed: () {},
              ),
              AppButton(
                label: 'Warning',
                icon: const Icon(Icons.warning_amber_outlined),
                color: AppButtonColor.warning,
                onPressed: () {},
              ),
            ],
          ),

          _buildSectionCard(
            context,
            title: 'Block Button',
            subtitle:
                'Create block level buttons by using isFullWidth property.',
            children: [
              AppButton(
                label: 'Block Button',
                isFullWidth: true,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              AppButton(
                label: 'Block Button',
                isFullWidth: true,
                color: AppButtonColor.secondary,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              AppButton(
                label: 'Block Button',
                isFullWidth: true,
                variant: AppButtonVariant.outline,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.bodyBase.copyWith(
              fontWeight: AppTypography.semiBold,
              color: context.theme
                  .extension<AppColorsExtension>()!
                  .textEmphasis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySm.copyWith(
              color: context.theme
                  .extension<AppColorsExtension>()!
                  .bodySecondaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          ),
        ],
      ),
    );
  }
}
