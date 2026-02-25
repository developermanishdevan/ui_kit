import 'package:flutter/material.dart';
import '../text_field/app_text_field.dart';
import '../../../utils/validators/app_validators.dart';

class AppEmailField extends StatelessWidget {
  const AppEmailField({
    super.key,
    this.controller,
    this.label = 'Email',
    this.hint = 'example@email.com',
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction ?? TextInputAction.next,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      enabled: enabled,
      validator: validator ?? AppValidators.email,
    );
  }
}
