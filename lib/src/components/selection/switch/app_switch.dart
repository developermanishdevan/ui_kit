import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.value,
    required this.onChanged,
    super.key,
    this.label,
    this.description,
    this.enabled = true,
    this.activeColor,
    this.thumbIcon,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final String? description;
  final bool enabled;
  final Color? activeColor;
  final Icon? thumbIcon;

  @override
  Widget build(BuildContext context) {
    final sw = Switch(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeThumbColor: activeColor,
      thumbIcon: thumbIcon != null
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return thumbIcon!;
              return null;
            })
          : null,
    );

    if (label == null && description == null) return sw;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null) Text(label!, style: AppTypography.bodyMedium),
            if (description != null)
              Text(description!,
                  style: AppTypography.caption.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )),
          ],
        ),
        GestureDetector(
          onTap: enabled ? () => onChanged(!value) : null,
          child: sw,
        ),
      ],
    );
  }
}
