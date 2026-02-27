import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class FormBasicsSection extends StatefulWidget {
  const FormBasicsSection({super.key});

  @override
  State<FormBasicsSection> createState() => _FormBasicsSectionState();
}

class _FormBasicsSectionState extends State<FormBasicsSection> {
  // Input controllers
  final _emailController = TextEditingController();
  final _searchController = TextEditingController();

  // Selection states
  bool _check1 = true;
  bool _switch1 = true;
  String _dropdownValue = '1';

  // State values for new inputs
  double _rating = 3.5;
  double _sliderValue = 45;
  RangeValues _rangeValues = const RangeValues(20, 80);
  String _otpValue = '';
  String? _asyncValue;

  @override
  void dispose() {
    _emailController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Form Basics',
          style: AppTypography.h2.copyWith(
            color: context.theme.extension<AppColorsExtension>()!.textEmphasis,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildLeftColumn(context)),
                  const SizedBox(width: AppSpacing.s4),
                  Expanded(child: _buildRightColumn(context)),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLeftColumn(context),
                const SizedBox(height: AppSpacing.s4),
                _buildRightColumn(context),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionCard(
          context,
          title: 'Standard Inputs',
          subtitle: 'Daily use text input fields with semantic variations.',
          children: [
            const AppTextField(
              labelText: 'Full Name',
              hintText: 'John Doe',
              prefixIcon: Icon(Icons.person_outline),
            ),
            const SizedBox(height: AppSpacing.s3),
            AppEmailField(controller: _emailController),
            const SizedBox(height: AppSpacing.s3),
            const AppPasswordField(labelText: 'Password'),
            const SizedBox(height: AppSpacing.s3),
            const AppPhoneField(),
            const SizedBox(height: AppSpacing.s3),
            AppSearchField(
              controller: _searchController,
              onChanged: (v) => setState(() {}),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSectionCard(
          context,
          title: 'Complex Inputs',
          subtitle: 'Specialized inputs for specific data formats.',
          children: [
            AppOtpField(
              labelText: 'OTP Verification',
              onChanged: (v) => setState(() => _otpValue = v),
            ),
            if (_otpValue.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.s2),
              Text('Current OTP: $_otpValue', style: AppTypography.bodySm),
            ],
            const SizedBox(height: AppSpacing.s4),
            AppPinCodeField(labelText: 'Transaction PIN'),
            const SizedBox(height: AppSpacing.s4),
            const AppTextArea(
              labelText: 'Bio / Description',
              hintText: 'Tell us about yourself...',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionCard(
          context,
          title: 'Selection & Pickers',
          subtitle: 'Choosing values from sets or ranges.',
          children: [
            AppDropdown<String>(
              labelText: 'Country Settings',
              options: const [
                AppDropdownOption(label: 'United States', value: '1'),
                AppDropdownOption(label: 'United Kingdom', value: '2'),
                AppDropdownOption(label: 'Canada', value: '3'),
              ],
              value: _dropdownValue,
              onChanged: (val) => setState(() => _dropdownValue = val!),
            ),
            const SizedBox(height: AppSpacing.s4),
            AppAsyncDropdown<String>(
              labelText: 'Async Regions',
              future: Future.delayed(
                const Duration(seconds: 2),
                () => const [
                  AppDropdownOption(label: 'North America', value: 'NA'),
                  AppDropdownOption(label: 'Europe', value: 'EU'),
                  AppDropdownOption(label: 'Asia', value: 'AS'),
                ],
              ),
              value: _asyncValue,
              onChanged: (val) => setState(() => _asyncValue = val),
            ),
            const SizedBox(height: AppSpacing.s4),
            AppRatingInput(
              labelText: 'Product Rating',
              initialRating: _rating,
              onRatingChanged: (v) => setState(() => _rating = v),
            ),
            const SizedBox(height: AppSpacing.s4),
            AppSlider(
              labelText: 'Volume Level',
              value: _sliderValue,
              onChanged: (v) => setState(() => _sliderValue = v),
            ),
            const SizedBox(height: AppSpacing.s4),
            AppRangeSlider(
              labelText: 'Price Range',
              values: _rangeValues,
              onChanged: (v) => setState(() => _rangeValues = v),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSectionCard(
          context,
          title: 'Interaction States',
          subtitle: 'Validation, disabled, and readonly states.',
          children: [
            const AppTextField(
              labelText: 'Error State',
              errorText: 'This field is required',
              isInvalid: true,
            ),
            const SizedBox(height: AppSpacing.s3),
            const AppTextField(
              labelText: 'Success State',
              successText: 'Username available',
              isValid: true,
            ),
            const SizedBox(height: AppSpacing.s3),
            const AppTextField(
              labelText: 'Disabled Input',
              hintText: 'Cannot type here',
              enabled: false,
            ),
            const SizedBox(height: AppSpacing.s4),
            Row(
              children: [
                Expanded(
                  child: AppCheckbox(
                    value: _check1,
                    label: 'Sync Data',
                    onChanged: (val) => setState(() => _check1 = val!),
                  ),
                ),
                Expanded(
                  child: AppSwitch(
                    value: _switch1,
                    label: 'Notifications',
                    onChanged: (val) => setState(() => _switch1 = val),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
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
