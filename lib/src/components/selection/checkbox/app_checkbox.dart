import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
    this.label,
    this.description,
    this.tristate = false,
    this.enabled = true,
    this.activeColor,
  });

  final bool? value;
  final ValueChanged<bool?> onChanged;
  final String? label;
  final String? description;
  final bool tristate;
  final bool enabled;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final checkbox = Checkbox(
      value: value,
      onChanged: enabled ? onChanged : null,
      tristate: tristate,
      activeColor: activeColor ?? cs.primary,
    );

    if (label == null && description == null) return checkbox;

    return GestureDetector(
      onTap: enabled ? () => onChanged(!(value ?? false)) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          checkbox,
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null)
                Text(label!,
                    style: AppTypography.bodyMedium.copyWith(
                      color: enabled ? null : Theme.of(context).disabledColor,
                    )),
              if (description != null)
                Text(description!,
                    style: AppTypography.caption.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )),
            ],
          ),
        ],
      ),
    );
  }
}
