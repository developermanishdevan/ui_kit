import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Search input field.
class AppSearchField extends AppStatelessWrapper {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool enabled;

  const AppSearchField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText = 'Search...',
    this.errorText,
    this.onChanged,
    this.onClear,
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
      prefixIcon: const Icon(Icons.search_outlined),
      suffixIcon: controller != null && controller!.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.close_outlined, size: 18),
              onPressed: () {
                controller!.clear();
                if (onClear != null) onClear!();
                if (onChanged != null) onChanged!('');
              },
            )
          : null,
    );
  }
}
