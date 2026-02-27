import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../ui_kit.dart';

/// A premium Date Range Picker component.
class AppRangePicker extends AppStatefulWrapper {
  final DateTimeRange? initialRange;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTimeRange?>? onChanged;
  final String? labelText;
  final String? hintText;
  final IconData prefixIcon;
  final bool enabled;

  const AppRangePicker({
    super.key,
    this.initialRange,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.prefixIcon = Icons.date_range_outlined,
    this.enabled = true,
  });

  @override
  State<AppRangePicker> createState() => _AppRangePickerState();
}

class _AppRangePickerState extends AppStatefulWrapperState<AppRangePicker> {
  DateTimeRange? _selectedRange;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedRange = widget.initialRange;
    _updateControllerText();
  }

  @override
  void didUpdateWidget(AppRangePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialRange != oldWidget.initialRange) {
      _selectedRange = widget.initialRange;
      _updateControllerText();
    }
  }

  void _updateControllerText() {
    if (_selectedRange != null) {
      final start = DateFormat('MMM d, yyyy').format(_selectedRange!.start);
      final end = DateFormat('MMM d, yyyy').format(_selectedRange!.end);
      _controller.text = '$start - $end';
    } else {
      _controller.text = '';
    }
  }

  Future<void> _pickRange(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedRange,
      firstDate: widget.firstDate ?? DateTime(now.year - 5),
      lastDate: widget.lastDate ?? DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: context.theme.extension<AppColorsExtension>()!.primary,
              primary: context.theme.extension<AppColorsExtension>()!.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedRange) {
      setState(() {
        _selectedRange = picked;
        _updateControllerText();
      });
      widget.onChanged?.call(picked);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return AppTextField(
      controller: _controller,
      labelText: widget.labelText,
      hintText: widget.hintText ?? 'Select date range',
      prefixIcon: Icon(widget.prefixIcon),
      readOnly: true,
      enabled: widget.enabled,
      onTap: widget.enabled ? () => _pickRange(context) : null,
      suffixIcon: const Icon(Icons.arrow_drop_down),
    );
  }
}
