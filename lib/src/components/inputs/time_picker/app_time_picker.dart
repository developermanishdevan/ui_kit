import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Time Picker field.
class AppTimePicker extends AppStatelessWrapper {
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay>? onChanged;
  final String? labelText;
  final String? hintText;
  final bool enabled;

  const AppTimePicker({
    super.key,
    this.value,
    this.onChanged,
    this.labelText,
    this.hintText = 'Select Time',
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppTextField(
      labelText: labelText,
      hintText: value != null ? value!.format(context) : hintText,
      readOnly: true,
      enabled: enabled,
      prefixIcon: const Icon(Icons.access_time_outlined),
      onTap: enabled
          ? () async {
              final time = await showTimePicker(
                context: context,
                initialTime: value ?? TimeOfDay.now(),
              );
              if (time != null && onChanged != null) {
                onChanged!(time);
              }
            }
          : null,
    );
  }
}
