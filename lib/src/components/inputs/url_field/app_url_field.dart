import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium URL input field.
class AppUrlField extends AppStatelessWrapper {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const AppUrlField({
    super.key,
    this.controller,
    this.labelText = 'Website URL',
    this.hintText = 'https://example.com',
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
      keyboardType: TextInputType.url,
      prefixIcon: const Icon(Icons.link_outlined),
    );
  }
}
