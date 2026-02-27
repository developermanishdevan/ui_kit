import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Email input field.
class AppEmailField extends AppStatelessWrapper {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const AppEmailField({
    super.key,
    this.controller,
    this.labelText = 'Email Address',
    this.hintText = 'example@domain.com',
    this.errorText,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppTextField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      onChanged: onChanged,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }
}
