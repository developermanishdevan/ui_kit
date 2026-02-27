import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class DropdownSection extends StatelessWidget {
  const DropdownSection({super.key});

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
              'Dropdown',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Dropdown',
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
                      Expanded(child: _buildSingleButtonCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildSingleButtonVariantsCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildDarkDropdownCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildMenuContentCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildSingleButtonCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildSingleButtonVariantsCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildDarkDropdownCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildMenuContentCard(context),
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

  List<AppDropdownItem> _getDemoItems() {
    return [
      const AppDropdownItem(label: 'Action'),
      const AppDropdownItem(label: 'Another action'),
      const AppDropdownItem(label: 'Something else here'),
    ];
  }

  Widget _buildSingleButtonCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Single Button Dropdowns',
            'Any single button can be turned into a dropdown toggle with some markup changes.',
          ),
          Wrap(
            spacing: 12,
            children: [
              AppDropdownMenu(
                toggle: AppButton(
                  label: 'Dropdown Button',
                  suffixIcon: const Icon(Icons.keyboard_arrow_down, size: 16),
                  onPressed: () {},
                ),
                items: _getDemoItems(),
              ),
              AppDropdownMenu(
                toggle: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Dropdown Link',
                        style: TextStyle(color: theme.primary),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: theme.primary,
                      ),
                    ],
                  ),
                ),
                items: _getDemoItems(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSingleButtonVariantsCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Single Button Variant Dropdowns',
            'Any single .btn can be turned into a dropdown toggle. Here\'s how you can put them to work.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildVariantDropdown(context, 'Primary', AppButtonColor.primary),
              _buildVariantDropdown(
                context,
                'Secondary',
                AppButtonColor.secondary,
              ),
              _buildVariantDropdown(context, 'Success', AppButtonColor.success),
              _buildVariantDropdown(context, 'Info', AppButtonColor.info),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVariantDropdown(
    BuildContext context,
    String label,
    AppButtonColor color,
  ) {
    return AppDropdownMenu(
      toggle: AppButton(
        label: label,
        color: color,
        suffixIcon: const Icon(Icons.keyboard_arrow_down, size: 16),
        onPressed: () {},
      ),
      items: [
        const AppDropdownItem(label: 'Action'),
        const AppDropdownItem(label: 'Another action'),
        const AppDropdownItem(label: 'Something else here'),
        const AppDropdownDivider(),
        const AppDropdownItem(label: 'Separated link'),
      ],
    );
  }

  Widget _buildDarkDropdownCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Dark Dropdowns',
            'Opt into darker dropdowns to match a dark navbar or custom style.',
          ),
          AppDropdownMenu(
            isDark: true,
            toggle: AppButton(
              label: 'Dark Dropdown',
              color: AppButtonColor.primary,
              suffixIcon: const Icon(Icons.keyboard_arrow_down, size: 16),
              onPressed: () {},
            ),
            items: [
              const AppDropdownItem(label: 'Action'),
              const AppDropdownItem(label: 'Another action'),
              const AppDropdownItem(label: 'Something else here'),
              const AppDropdownDivider(),
              const AppDropdownItem(label: 'Separated link'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuContentCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Menu Content',
            'Add a header to label sections of actions and separate groups with a divider.',
          ),
          Wrap(
            spacing: 8,
            children: [
              AppDropdownMenu(
                toggle: AppButton(
                  label: 'Dropdown Header',
                  color: AppButtonColor.info,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down, size: 16),
                  onPressed: () {},
                ),
                items: const [
                  AppDropdownHeader(label: 'Dropdown header'),
                  AppDropdownItem(label: 'Action'),
                  AppDropdownItem(label: 'Another action'),
                ],
              ),
              _buildVariantDropdown(
                context,
                'Dropdown Divider',
                AppButtonColor.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
