import 'package:flutter/material.dart';
import '../text_field/app_text_field.dart';

class AppDatePickerField extends StatefulWidget {
  const AppDatePickerField({
    super.key,
    this.label,
    this.hint,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.dateFormat,
    this.errorText,
    this.enabled = true,
  });

  final String? label;
  final String? hint;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime?>? onChanged;
  final String Function(DateTime)? dateFormat;
  final String? errorText;
  final bool enabled;

  @override
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

class _AppDatePickerFieldState extends State<AppDatePickerField> {
  DateTime? _selected;
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
    if (_selected != null) _ctrl.text = _format(_selected!);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _format(DateTime dt) =>
      widget.dateFormat?.call(dt) ?? dt.toString().split(' ')[0];

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _selected ?? now,
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _selected = date;
        _ctrl.text = _format(date);
      });
      widget.onChanged?.call(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _ctrl,
      label: widget.label,
      hint: widget.hint,
      errorText: widget.errorText,
      enabled: widget.enabled,
      readOnly: true,
      onTap: widget.enabled ? _pickDate : null,
      suffixIcon: Icons.calendar_today,
    );
  }
}
