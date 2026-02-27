import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Phone input field.
class AppPhoneField extends AppStatelessWrapper {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const AppPhoneField({
    super.key,
    this.controller,
    this.labelText = 'Phone Number',
    this.hintText = '+1 (123) 456-7890',
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
      keyboardType: TextInputType.phone,
      prefixIcon: const Icon(Icons.phone_outlined),
    );
  }
}
