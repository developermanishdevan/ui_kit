import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppSegmentedButtonItem<T> {
  final T value;
  final String label;
  final Widget? icon;

  const AppSegmentedButtonItem({
    required this.value,
    required this.label,
    this.icon,
  });
}

/// A premium Segmented Button component.
class AppSegmentedButton<T> extends AppStatelessWrapper {
  final List<AppSegmentedButtonItem<T>> items;
  final Set<T> selected;
  final ValueChanged<Set<T>> onSelectionChanged;
  final bool multiSelectionEnabled;
  final AppButtonSize size;
  final AppButtonColor color;

  const AppSegmentedButton({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelectionChanged,
    this.multiSelectionEnabled = false,
    this.size = AppButtonSize.md,
    this.color = AppButtonColor.primary,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;
    final themeColor = _getThemeColor(colors);

    return SegmentedButton<T>(
      segments: items.map((item) {
        return ButtonSegment<T>(
          value: item.value,
          label: Text(item.label),
          icon: item.icon,
        );
      }).toList(),
      selected: selected,
      onSelectionChanged: onSelectionChanged,
      multiSelectionEnabled: multiSelectionEnabled,
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: themeColor.withValues(alpha: 0.1),
        selectedForegroundColor: themeColor,
        foregroundColor: colors.bodySecondaryColor,
        side: BorderSide(color: colors.borderColor),
        shape: RoundedRectangleBorder(borderRadius: radii.base),
      ),
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
