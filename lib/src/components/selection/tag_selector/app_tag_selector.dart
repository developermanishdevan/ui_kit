import 'package:flutter/material.dart';

import '../../../../ui_kit.dart';

class AppTagSelector extends StatelessWidget {
  const AppTagSelector({
    required this.options,
    required this.selected,
    required this.onChanged,
    super.key,
    this.multiSelect = true,
    this.label,
    this.maxSelections,
  });

  final List<String> options;
  final Set<String> selected;
  final ValueChanged<Set<String>> onChanged;
  final bool multiSelect;
  final String? label;
  final int? maxSelections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTypography.labelMedium),
          const SizedBox(height: AppSpacing.xs),
        ],
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: options.map((opt) {
            final isSelected = selected.contains(opt);
            return AppChoiceChip(
              label: opt,
              selected: isSelected,
              enabled: isSelected ||
                  maxSelections == null ||
                  selected.length < maxSelections!,
              onSelected: (_) {
                final newSet = Set<String>.from(selected);
                if (isSelected) {
                  newSet.remove(opt);
                } else if (!multiSelect) {
                  newSet.clear();
                  newSet.add(opt);
                } else {
                  newSet.add(opt);
                }
                onChanged(newSet);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
