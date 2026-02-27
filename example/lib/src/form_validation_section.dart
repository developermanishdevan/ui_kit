import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class FormValidationSection extends StatefulWidget {
  const FormValidationSection({super.key});

  @override
  State<FormValidationSection> createState() => _FormValidationSectionState();
}

class _FormValidationSectionState extends State<FormValidationSection> {
  final _formKeyCustom = GlobalKey<FormState>();
  final _formKeyTooltip = GlobalKey<FormState>();

  // Form Field Controllers
  final _firstNameController = TextEditingController(text: 'Mark');
  final _lastNameController = TextEditingController(text: 'Otto');
  final _usernameController = TextEditingController();
  bool _agreeTerms = false;

  // Validation States for "Server Side" / Explicit states
  final bool _isServerFirstNameValid = true;
  final bool _isServerLastNameValid = true;
  final bool _isServerUsernameValid = false;

  bool _customFormSubmitted = false;
  bool _tooltipFormSubmitted = false;

  void _submitCustomForm() {
    setState(() => _customFormSubmitted = true);
    if (_formKeyCustom.currentState!.validate() && _agreeTerms) {
      AppSnackbar.show(
        context,
        message: 'Custom Form Submitted Successfully!',
        variant: AppSnackbarVariant.success,
      );
    }
  }

  void _submitTooltipForm() {
    setState(() => _tooltipFormSubmitted = true);
    if (_formKeyTooltip.currentState!.validate()) {
      AppSnackbar.show(
        context,
        message: 'Tooltip Form Submitted Successfully!',
        variant: AppSnackbarVariant.success,
      );
    } else {
      setState(() {}); // Ensure tooltips show on failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Form Validation', style: AppTypography.h4),
          const SizedBox(height: 24),

          // Browser Default (Simulated)
          _buildCard(
            title: 'Browser Default',
            subtitle:
                'Depending on your browser and OS, you’ll see a slightly different style of feedback.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: 250,
                      child: AppTextField(
                        labelText: 'First name',
                        hintText: 'First name',
                        controller: TextEditingController(text: 'Mark'),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: AppTextField(
                        labelText: 'Last name',
                        hintText: 'Last name',
                        controller: TextEditingController(text: 'Otto'),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: AppTextField(
                        labelText: 'Username',
                        hintText: 'Username',
                        prefixIcon: const Icon(Icons.alternate_email),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppButton(label: 'Submit form', onPressed: () {}),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Custom Styles
          _buildCard(
            title: 'Custom styles',
            subtitle:
                'For custom Bootstrap-like validation, we use Flutter\'s Form validation.',
            child: Form(
              key: _formKeyCustom,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: 250,
                        child: AppTextField(
                          labelText: 'First name',
                          controller: _firstNameController,
                          isValid:
                              _customFormSubmitted &&
                              _firstNameController.text.isNotEmpty,
                          successText: 'Looks good!',
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Please enter first name'
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: AppTextField(
                          labelText: 'Last name',
                          controller: _lastNameController,
                          isValid:
                              _customFormSubmitted &&
                              _lastNameController.text.isNotEmpty,
                          successText: 'Looks good!',
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Please enter last name'
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: AppTextField(
                          labelText: 'Username',
                          controller: _usernameController,
                          prefixIcon: const Icon(Icons.alternate_email),
                          isValid:
                              _customFormSubmitted &&
                              _usernameController.text.isNotEmpty,
                          isInvalid:
                              _customFormSubmitted &&
                              _usernameController.text.isEmpty,
                          errorText: 'Please choose a username.',
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Please choose a username.'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppCheckbox(
                    label: 'Agree to terms and conditions',
                    value: _agreeTerms,
                    onChanged: (val) =>
                        setState(() => _agreeTerms = val ?? false),
                    isInvalid: _customFormSubmitted && !_agreeTerms,
                    errorText: 'You must agree before submitting.',
                  ),
                  const SizedBox(height: 24),
                  AppButton(label: 'Submit form', onPressed: _submitCustomForm),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Server Side (Explicit States)
          _buildCard(
            title: 'Server side',
            subtitle:
                'Explicitly indicate invalid and valid form fields with isValid and isInvalid properties.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: 250,
                      child: AppTextField(
                        labelText: 'First name',
                        isValid: _isServerFirstNameValid,
                        successText: 'Looks good!',
                        controller: TextEditingController(text: 'Mark'),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: AppTextField(
                        labelText: 'Last name',
                        isValid: _isServerLastNameValid,
                        successText: 'Looks good!',
                        controller: TextEditingController(text: 'Otto'),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: AppTextField(
                        labelText: 'Username',
                        isInvalid: !_isServerUsernameValid,
                        errorText: 'Please choose a username.',
                        prefixIcon: const Icon(Icons.alternate_email),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppCheckbox(
                  label: 'Agree to terms and conditions',
                  value: false,
                  onChanged: (val) {},
                  isInvalid: true,
                  errorText: 'You must agree before submitting.',
                ),
                const SizedBox(height: 24),
                AppButton(label: 'Submit form', onPressed: () {}),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Tooltips
          _buildCard(
            title: 'Tooltips',
            subtitle:
                'Display validation feedback in a styled tooltip by setting tooltipFeedback: true.',
            child: Form(
              key: _formKeyTooltip,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 24,
                    children: [
                      const SizedBox(
                        width: 250,
                        child: AppTextField(
                          labelText: 'First name',
                          isValid: true,
                          successText: 'Looks good!',
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: AppTextField(
                          labelText: 'Last name',
                          isInvalid:
                              _tooltipFormSubmitted, // Show error if submitted
                          errorText: 'Please enter last name.',
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Please enter last name.'
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: AppTextField(
                          labelText: 'City',
                          isInvalid: _tooltipFormSubmitted,
                          errorText: 'Please provide a valid city.',
                          validator: (value) => 'Please provide a valid city.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48), // Extra space for tooltips
                  AppButton(
                    label: 'Submit form',
                    onPressed: _submitTooltipForm,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.h5.copyWith(color: theme.bodyColor)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySm.copyWith(
              color: theme.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          child,
        ],
      ),
    );
  }
}
