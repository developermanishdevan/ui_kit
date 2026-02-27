import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Slider input field.
class AppSlider extends AppStatelessWrapper {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final ValueChanged<double>? onChanged;
  final String? labelText;
  final AppButtonColor color;
  final bool enabled;

  const AppSlider({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 100,
    this.divisions,
    this.label,
    this.onChanged,
    this.labelText,
    this.color = AppButtonColor.primary,
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    final themeColor = _getThemeColor(colors);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText!,
                style: typography.bodyBase.copyWith(
                  fontWeight: AppTypography.medium,
                  color: colors.textEmphasis,
                ),
              ),
              Text(
                value.toStringAsFixed(0),
                style: typography.bodySm.copyWith(
                  fontWeight: AppTypography.bold,
                  color: themeColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing.s1),
        ],
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            activeTrackColor: themeColor,
            inactiveTrackColor: colors.borderColor.withValues(alpha: 0.3),
            thumbColor: Colors.white,
            overlayColor: themeColor.withValues(alpha: 0.2),
            valueIndicatorColor: themeColor,
            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 10,
              elevation: 4,
            ),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: label ?? value.toStringAsFixed(0),
            onChanged: enabled ? onChanged : null,
          ),
        ),
      ],
    );
  }

  Color _getThemeColor(AppColorsExtension colors) {
    switch (color) {
      case AppButtonColor.primary:
        return colors.primary;
      case AppButtonColor.secondary:
        return colors.secondary;
      case AppButtonColor.success:
        return colors.success;
      case AppButtonColor.warning:
        return colors.warning;
      case AppButtonColor.danger:
        return colors.danger;
      case AppButtonColor.info:
        return colors.info;
      case AppButtonColor.light:
        return colors.light;
      case AppButtonColor.dark:
        return colors.dark;
    }
  }
}
