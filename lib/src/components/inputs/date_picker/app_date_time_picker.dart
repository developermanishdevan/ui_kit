import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../ui_kit.dart';

enum AppPickerType { date, time, dateTime, dateRange, duration }

class AppDateTimePicker extends AppStatefulWrapper {
  final AppPickerType type;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final bool enabled;
  final dynamic value;
  final ValueChanged<dynamic>? onChanged;

  const AppDateTimePicker({
    super.key,
    required this.type,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.enabled = true,
    this.value,
    this.onChanged,
  });

  @override
  State<AppDateTimePicker> createState() => _AppDateTimePickerState();
}

class _AppDateTimePickerState
    extends AppStatefulWrapperState<AppDateTimePicker> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateTextFromValue();
  }

  @override
  void didUpdateWidget(covariant AppDateTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateTextFromValue();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateTextFromValue() {
    if (widget.value == null) {
      _controller.text = '';
      return;
    }

    switch (widget.type) {
      case AppPickerType.date:
        if (widget.value is DateTime) {
          final dt = widget.value as DateTime;
          _controller.text = '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)}';
        }
        break;
      case AppPickerType.time:
        if (widget.value is TimeOfDay) {
          final tod = widget.value as TimeOfDay;
          _controller.text = '${_pad(tod.hour)}:${_pad(tod.minute)}';
        }
        break;
      case AppPickerType.dateTime:
        if (widget.value is DateTime) {
          final dt = widget.value as DateTime;
          _controller.text =
              '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)} ${_pad(dt.hour)}:${_pad(dt.minute)}';
        }
        break;
      case AppPickerType.dateRange:
        if (widget.value is DateTimeRange) {
          final dr = widget.value as DateTimeRange;
          _controller.text =
              '${dr.start.year}-${_pad(dr.start.month)}-${_pad(dr.start.day)} to ${dr.end.year}-${_pad(dr.end.month)}-${_pad(dr.end.day)}';
        }
        break;
      case AppPickerType.duration:
        if (widget.value is Duration) {
          final dur = widget.value as Duration;
          final hours = dur.inHours;
          final mins = dur.inMinutes.remainder(60);
          _controller.text = '${hours}h ${mins}m';
        }
        break;
    }
  }

  String _pad(int n) => n.toString().padLeft(2, '0');

  Future<void> _handleTap() async {
    if (!widget.enabled) return;

    switch (widget.type) {
      case AppPickerType.date:
        final selected = await showDatePicker(
          context: context,
          initialDate: (widget.value as DateTime?) ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (selected != null) {
          widget.onChanged?.call(selected);
        }
        break;

      case AppPickerType.time:
        final selected = await showTimePicker(
          context: context,
          initialTime: (widget.value as TimeOfDay?) ?? TimeOfDay.now(),
        );
        if (selected != null) {
          widget.onChanged?.call(selected);
        }
        break;

      case AppPickerType.dateTime:
        final date = await showDatePicker(
          context: context,
          initialDate: (widget.value as DateTime?) ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          if (!mounted) return;
          final time = await showTimePicker(
            context: context,
            initialTime: widget.value != null
                ? TimeOfDay.fromDateTime(widget.value as DateTime)
                : TimeOfDay.now(),
          );
          if (time != null) {
            final combined = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );
            widget.onChanged?.call(combined);
          }
        }
        break;

      case AppPickerType.dateRange:
        final selected = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          initialDateRange: widget.value as DateTimeRange?,
        );
        if (selected != null) {
          widget.onChanged?.call(selected);
        }
        break;

      case AppPickerType.duration:
        Duration tempDuration = (widget.value as Duration?) ?? const Duration();
        if (!mounted) return;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        final colors = Theme.of(context).extension<AppColorsExtension>()!;

        await showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext builder) {
            return Container(
              height: 250,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.bodyBg,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: colors.bodySecondaryColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.onChanged?.call(tempDuration);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(color: colors.primary),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        brightness: isDark ? Brightness.dark : Brightness.light,
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                            color: colors.textEmphasis,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        initialTimerDuration: tempDuration,
                        onTimerDurationChanged: (Duration newDuration) {
                          tempDuration = newDuration;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
        break;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    IconData defaultIcon;
    switch (widget.type) {
      case AppPickerType.date:
      case AppPickerType.dateRange:
        defaultIcon = Icons.calendar_today_outlined;
        break;
      case AppPickerType.time:
      case AppPickerType.duration:
        defaultIcon = Icons.access_time;
        break;
      case AppPickerType.dateTime:
        defaultIcon = Icons.date_range;
        break;
    }

    return AppTextField(
      controller: _controller,
      labelText: widget.labelText,
      hintText: widget.hintText,
      errorText: widget.errorText,
      enabled: widget.enabled,
      readOnly: true,
      onTap: _handleTap,
      prefixIcon: widget.prefixIcon ?? Icon(defaultIcon),
    );
  }
}
