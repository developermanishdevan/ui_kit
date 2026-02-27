import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class InputPickerSection extends StatefulWidget {
  const InputPickerSection({super.key});

  @override
  State<InputPickerSection> createState() => _InputPickerSectionState();
}

class _InputPickerSectionState extends State<InputPickerSection> {
  DateTime? _basicDate;
  DateTime? _dateTime;
  DateTimeRange? _dateRange;
  TimeOfDay? _time;
  Duration? _duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Input Pickers',
          style: AppTypography.h2.copyWith(
            color: context.theme.extension<AppColorsExtension>()!.textEmphasis,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildLeftColumn(context)),
                  const SizedBox(width: AppSpacing.s4),
                  Expanded(child: _buildRightColumn(context)),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLeftColumn(context),
                const SizedBox(height: AppSpacing.s4),
                _buildRightColumn(context),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionCard(
          context,
          title: 'Date & Calendar',
          subtitle: 'Standard material-style date selection.',
          children: [
            AppDatePicker(
              labelText: 'Modern Date Picker',
              value: _basicDate,
              onChanged: (val) => setState(() => _basicDate = val),
            ),
            const SizedBox(height: AppSpacing.s4),
            AppRangePicker(
              labelText: 'Standalone Range Picker',
              initialRange: _dateRange,
              onChanged: (val) => setState(() => _dateRange = val),
            ),
            const SizedBox(height: AppSpacing.s4),
            AppDateTimePicker(
              type: AppPickerType.dateRange,
              labelText: 'Date Range Selection (Wrapper)',
              value: _dateRange,
              onChanged: (val) =>
                  setState(() => _dateRange = val as DateTimeRange),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildSectionCard(
          context,
          title: 'Advanced Timing',
          subtitle: 'Combined date and time selection.',
          children: [
            AppDateTimePicker(
              type: AppPickerType.dateTime,
              labelText: 'Full Timestamp',
              value: _dateTime,
              onChanged: (val) => setState(() => _dateTime = val as DateTime),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionCard(
          context,
          title: 'Time & Duration',
          subtitle: 'Clock-based pickers for daily scheduling.',
          children: [
            AppTimePicker(
              labelText: 'Start Time',
              value: _time,
              onChanged: (val) => setState(() => _time = val),
            ),
            const SizedBox(height: AppSpacing.s4),
            AppDateTimePicker(
              type: AppPickerType.duration,
              labelText: 'Session Duration',
              value: _duration,
              onChanged: (val) => setState(() => _duration = val as Duration),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTypography.h6.copyWith(
              fontWeight: AppTypography.semiBold,
              color: colors.textEmphasis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySm.copyWith(
              color: colors.bodySecondaryColor,
            ),
          ),
          Divider(height: AppSpacing.s5, color: colors.borderColorTranslucent),
          ...children,
        ],
      ),
    );
  }
}
