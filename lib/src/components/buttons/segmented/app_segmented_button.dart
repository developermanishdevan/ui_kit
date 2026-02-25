import 'package:flutter/material.dart';

class AppSegmentedButtonItem<T> {
  const AppSegmentedButtonItem({
    required this.value,
    required this.label,
    this.icon,
  });
  final T value;
  final String label;
  final IconData? icon;
}

class AppSegmentedButton<T> extends StatelessWidget {
  const AppSegmentedButton({
    required this.items,
    required this.selected,
    required this.onChanged,
    super.key,
    this.multiSelect = false,
  });

  final List<AppSegmentedButtonItem<T>> items;
  final Set<T> selected;
  final ValueChanged<Set<T>> onChanged;
  final bool multiSelect;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      segments: items
          .map((item) => ButtonSegment<T>(
                value: item.value,
                label: Text(item.label),
                icon: item.icon != null ? Icon(item.icon) : null,
              ))
          .toList(),
      selected: selected,
      onSelectionChanged: onChanged,
      multiSelectionEnabled: multiSelect,
    );
  }
}
