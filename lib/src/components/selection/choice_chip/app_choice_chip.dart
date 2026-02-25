import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    required this.label, required this.selected, required this.onSelected, super.key,
    this.avatar,
    this.enabled = true,
    this.selectedColor,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Widget? avatar;
  final bool enabled;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label, style: AppTypography.labelMedium),
      selected: selected,
      onSelected: enabled ? onSelected : null,
      avatar: avatar,
      selectedColor:
          selectedColor ?? Theme.of(context).colorScheme.primaryContainer,
      labelStyle: AppTypography.labelMedium.copyWith(
        color: selected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
