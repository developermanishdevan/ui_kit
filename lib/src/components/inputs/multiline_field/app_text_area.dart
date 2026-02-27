import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppTextArea extends AppStatelessWrapper {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final int minLines;
  final bool readOnly;
  final bool enabled;

  const AppTextArea({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.maxLines = 5,
    this.minLines = 3,
    this.readOnly = false,
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
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      enabled: enabled,
      keyboardType: TextInputType.multiline,
    );
  }
}
