import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppSlider extends StatelessWidget {
  const AppSlider({
    required this.value, required this.onChanged, super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.label,
    this.showLabel = true,
    this.showMinMax = true,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.formatLabel,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool showLabel;
  final bool showMinMax;
  final bool enabled;
  final Color? activeColor;
  final Color? inactiveColor;
  final String Function(double)? formatLabel;

  String _format(double v) => formatLabel?.call(v) ?? v.toStringAsFixed(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label!, style: AppTypography.labelMedium),
              if (showLabel)
                Text(_format(value),
                    style: AppTypography.labelMedium.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: showLabel ? _format(value) : null,
          onChanged: enabled ? onChanged : null,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
        ),
        if (showMinMax)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_format(min),
                    style: AppTypography.caption.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )),
                Text(_format(max),
                    style: AppTypography.caption.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )),
              ],
            ),
          ),
      ],
    );
  }
}
