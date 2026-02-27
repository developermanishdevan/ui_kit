import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class SelectionSection extends StatefulWidget {
  const SelectionSection({super.key});

  @override
  State<SelectionSection> createState() => _SelectionSectionState();
}

class _SelectionSectionState extends State<SelectionSection> {
  // States
  bool _check1 = true;
  bool _check2 = false;
  bool _check3 = true;
  bool _check4 = false;

  String _radioValue = '1';
  String _radioValue2 = '1';

  bool _switch1 = true;
  bool _switch2 = true;

  bool _choice1 = true;
  bool _choice2 = false;
  bool _filter1 = false;
  bool _filter2 = true;

  List<String> _tags = ['Flutter', 'Dart', 'UI Kit'];
  List<String> _selectedItems = ['Item 1'];

  int _selectedCard = 0;
  int _selectedTile = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Selection',
          style: AppTypography.h2.copyWith(
            color: context.theme.extension<AppColorsExtension>()!.textEmphasis,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildCheckboxShowcase(context),
        const SizedBox(height: AppSpacing.s4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildRadioShowcase(context)),
            const SizedBox(width: AppSpacing.s4),
            Expanded(child: _buildSwitchShowcase(context)),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSectionCard(
          context,
          title: 'Chips',
          subtitle: 'Interactive chips for filtering and choices.',
          children: [
            _buildSubHeader('Choice Chips'),
            Wrap(
              spacing: AppSpacing.s2,
              children: [
                AppChoiceChip(
                  label: 'Option 1',
                  selected: _choice1,
                  onSelected: (v) => setState(() => _choice1 = v),
                ),
                AppChoiceChip(
                  label: 'Option 2',
                  selected: _choice2,
                  onSelected: (v) => setState(() => _choice2 = v),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s4),
            _buildSubHeader('Filter Chips'),
            Wrap(
              spacing: AppSpacing.s2,
              children: [
                AppFilterChip(
                  label: 'Filter 1',
                  selected: _filter1,
                  onSelected: (v) => setState(() => _filter1 = v),
                ),
                AppFilterChip(
                  label: 'Filter 2',
                  selected: _filter2,
                  onSelected: (v) => setState(() => _filter2 = v),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSectionCard(
          context,
          title: 'Advanced Selection',
          subtitle: 'Complex selection widgets.',
          children: [
            AppTagSelector(
              labelText: 'Tags',
              availableTags: const ['Mobile', 'Web', 'Desktop', 'Server'],
              selectedTags: _tags,
              onChanged: (v) => setState(() => _tags = v),
            ),
            const SizedBox(height: AppSpacing.s4),
            AppMultiSelectList<String>(
              labelText: 'Multi Select List',
              items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
              selectedItems: _selectedItems,
              itemLabel: (v) => v,
              onChanged: (v) => setState(() => _selectedItems = v),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSectionCard(
          context,
          title: 'Selectable Layouts',
          subtitle: 'Cards and tiles that act as selection triggers.',
          children: [
            _buildSubHeader('Selectable Cards'),
            Row(
              children: [
                Expanded(
                  child: AppSelectableCard(
                    selected: _selectedCard == 0,
                    onTap: () => setState(() => _selectedCard = 0),
                    child: const Column(
                      children: [
                        Icon(Icons.directions_car),
                        SizedBox(height: 8),
                        Text('Basic Plan'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.s3),
                Expanded(
                  child: AppSelectableCard(
                    selected: _selectedCard == 1,
                    onTap: () => setState(() => _selectedCard = 1),
                    child: const Column(
                      children: [
                        Icon(Icons.rocket_launch),
                        SizedBox(height: 8),
                        Text('Premium Plan'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s4),
            _buildSubHeader('Selectable Tiles'),
            AppSelectableTile(
              title: const Text('Notifications'),
              subtitle: const Text('Enable push notifications'),
              leading: const Icon(Icons.notifications_outlined),
              selected: _selectedTile == 0,
              onTap: () => setState(() => _selectedTile = 0),
            ),
            AppSelectableTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Use high contrast colors'),
              leading: const Icon(Icons.dark_mode_outlined),
              selected: _selectedTile == 1,
              onTap: () => setState(() => _selectedTile = 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCheckboxShowcase(BuildContext context) {
    return _buildSectionCard(
      context,
      title: 'Checkbox',
      subtitle: 'Premium checkbox components with various styles.',
      children: [
        _buildSubHeader('Default'),
        AppCheckbox(
          value: _check1,
          label: 'Check this custom checkbox',
          onChanged: (v) => setState(() => _check1 = v!),
        ),
        const SizedBox(height: AppSpacing.s2),
        AppCheckbox(
          value: _check2,
          label: 'Check this custom checkbox',
          onChanged: (v) => setState(() => _check2 = v!),
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSubHeader('Inline'),
        Row(
          children: [
            AppCheckbox(
              value: _check3,
              label: 'Check this custom checkbox',
              onChanged: (v) => setState(() => _check3 = v!),
            ),
            const SizedBox(width: AppSpacing.s4),
            AppCheckbox(
              value: _check4,
              label: 'Check this custom checkbox',
              onChanged: (v) => setState(() => _check4 = v!),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSubHeader('Colors'),
        Wrap(
          spacing: AppSpacing.s4,
          runSpacing: AppSpacing.s2,
          children: [
            AppCheckbox(
              value: true,
              label: 'Default Checkbox',
              onChanged: (v) {},
            ),
            AppCheckbox(
              value: true,
              label: 'Success Checkbox',
              color: AppCheckboxColor.success,
              onChanged: (v) {},
            ),
            AppCheckbox(
              value: true,
              label: 'Info Checkbox',
              color: AppCheckboxColor.info,
              onChanged: (v) {},
            ),
            AppCheckbox(
              value: true,
              label: 'Secondary Checkbox',
              color: AppCheckboxColor.secondary,
              onChanged: (v) {},
            ),
            AppCheckbox(
              value: true,
              label: 'Warning Checkbox',
              color: AppCheckboxColor.warning,
              onChanged: (v) {},
            ),
            AppCheckbox(
              value: true,
              label: 'Danger Checkbox',
              color: AppCheckboxColor.danger,
              onChanged: (v) {},
            ),
            AppCheckbox(
              value: true,
              label: 'Dark Checkbox',
              color: AppCheckboxColor.dark,
              onChanged: (v) {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioShowcase(BuildContext context) {
    return _buildSectionCard(
      context,
      title: 'Radio',
      subtitle: 'Premium radio buttons with group selection.',
      children: [
        _buildSubHeader('Default'),
        AppRadio(
          value: '0',
          groupValue: _radioValue,
          label: 'Default radio',
          onChanged: (v) => setState(() => _radioValue = v!),
        ),
        const SizedBox(height: AppSpacing.s2),
        AppRadio(
          value: '1',
          groupValue: _radioValue,
          label: 'Default checked radio',
          onChanged: (v) => setState(() => _radioValue = v!),
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSubHeader('Inline'),
        Row(
          children: [
            AppRadio(
              value: '0',
              groupValue: _radioValue2,
              label: 'Check this custom checkbox',
              onChanged: (v) => setState(() => _radioValue2 = v!),
            ),
            const SizedBox(width: AppSpacing.s4),
            AppRadio(
              value: '1',
              groupValue: _radioValue2,
              label: 'Check this custom checkbox',
              onChanged: (v) => setState(() => _radioValue2 = v!),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSubHeader('Colors'),
        Wrap(
          spacing: AppSpacing.s4,
          runSpacing: AppSpacing.s2,
          children: [
            AppRadio(
              value: '1',
              groupValue: '1',
              label: 'Default Radio',
              onChanged: (v) {},
            ),
            AppRadio(
              value: '1',
              groupValue: '1',
              label: 'Success Radio',
              color: AppRadioColor.success,
              onChanged: (v) {},
            ),
            AppRadio(
              value: '1',
              groupValue: '1',
              label: 'Info Radio',
              color: AppRadioColor.info,
              onChanged: (v) {},
            ),
            AppRadio(
              value: '1',
              groupValue: '1',
              label: 'Secondary Radio',
              color: AppRadioColor.secondary,
              onChanged: (v) {},
            ),
            AppRadio(
              value: '1',
              groupValue: '1',
              label: 'Warning Radio',
              color: AppRadioColor.warning,
              onChanged: (v) {},
            ),
            AppRadio(
              value: '2',
              groupValue: '1',
              label: 'Danger Radio',
              color: AppRadioColor.danger,
              onChanged: (v) {},
            ),
            AppRadio(
              value: '2',
              groupValue: '1',
              label: 'Dark Radio',
              color: AppRadioColor.dark,
              onChanged: (v) {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchShowcase(BuildContext context) {
    return _buildSectionCard(
      context,
      title: 'Switch',
      subtitle: 'Premium toggle switches with various states.',
      children: [
        AppSwitch(
          value: _switch1,
          label: 'Default switch checkbox input',
          onChanged: (v) => setState(() => _switch1 = v),
        ),
        const SizedBox(height: AppSpacing.s2),
        AppSwitch(
          value: _switch2,
          label: 'Checked switch checkbox input',
          onChanged: (v) => setState(() => _switch2 = v),
        ),
        const SizedBox(height: AppSpacing.s2),
        const AppSwitch(
          value: false,
          disabled: true,
          label: 'Disabled switch checkbox input',
        ),
        const SizedBox(height: AppSpacing.s2),
        const AppSwitch(
          value: true,
          disabled: true,
          label: 'Disabled checked switch checkbox input',
        ),
      ],
    );
  }

  Widget _buildSubHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s2, top: AppSpacing.s1),
      child: Text(
        text,
        style: AppTypography.bodyBase.copyWith(
          fontWeight: AppTypography.semiBold,
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTypography.h6.copyWith(
              fontWeight: AppTypography.semiBold,
              color: colors.textEmphasis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySm.copyWith(
              color: colors.bodySecondaryColor,
            ),
          ),
          Divider(height: AppSpacing.s5, color: colors.borderColorTranslucent),
          ...children,
        ],
      ),
    );
  }
}
