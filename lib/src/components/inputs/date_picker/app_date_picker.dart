import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Date Picker field.
class AppDatePicker extends AppStatelessWrapper {
  final DateTime? value;
  final ValueChanged<DateTime>? onChanged;
  final String? labelText;
  final String? hintText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool enabled;

  const AppDatePicker({
    super.key,
    this.value,
    this.onChanged,
    this.labelText,
    this.hintText = 'Select Date',
    this.firstDate,
    this.lastDate,
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppTextField(
      labelText: labelText,
      hintText: value != null
          ? '${value!.day}/${value!.month}/${value!.year}'
          : hintText,
      readOnly: true,
      enabled: enabled,
      prefixIcon: const Icon(Icons.calendar_today_outlined),
      onTap: enabled
          ? () async {
              final date = await showDatePicker(
                context: context,
                initialDate: value ?? DateTime.now(),
                firstDate: firstDate ?? DateTime(1900),
                lastDate: lastDate ?? DateTime(2100),
              );
              if (date != null && onChanged != null) {
                onChanged!(date);
              }
            }
          : null,
    );
  }
}
