import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
    this.label,
    this.enabled = true,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    Widget radio = Radio<T>(
      value: value,
      // ignore: deprecated_member_use
      groupValue: groupValue,
      // ignore: deprecated_member_use
      onChanged: enabled ? onChanged : null,
      activeColor: AppColors.primary,
    );

    if (label == null) return radio;

    return InkWell(
      onTap: enabled ? () => onChanged?.call(value) : null,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          radio,
          const SizedBox(width: 4),
          Text(label!,
              style: AppTypography.bodyMedium.copyWith(
                color: enabled ? AppColors.textPrimary : AppColors.textTertiary,
              )),
        ],
      ),
    );
  }
}

class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    required this.items,
    required this.groupValue,
    required this.onChanged,
    super.key,
    this.label,
    this.vertical = true,
    this.spacing = 8.0,
  });

  final List<AppRadioItem<T>> items;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String? label;
  final bool vertical;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final children = items
        .map((item) => AppRadio<T>(
              value: item.value,
              groupValue: groupValue,
              onChanged: onChanged,
              label: item.label,
              enabled: item.enabled,
            ))
        .toList();

    Widget group = vertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: children
                .map((c) => Padding(
                      padding: EdgeInsets.only(bottom: spacing),
                      child: c,
                    ))
                .toList(),
          )
        : Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: children,
          );

    if (label == null) return group;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label!,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
            )),
        const SizedBox(height: 8),
        group,
      ],
    );
  }
}

class AppRadioItem<T> {
  const AppRadioItem(
      {required this.value, required this.label, this.enabled = true});
  final T value;
  final String label;
  final bool enabled;
}
