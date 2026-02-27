import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// Defines the color scheme of the radio button.
enum AppRadioColor { primary, success, info, warning, danger, secondary, dark }

/// A premium radio button component following the UI Kit design system.
/// Supports labels, color variants, and selection states.
class AppRadio<T> extends AppStatelessWrapper {
  /// The value associated with this radio button.
  final T value;

  /// The currently selected value in the group.
  final T? groupValue;

  /// Callback when this radio button is selected.
  final ValueChanged<T?>? onChanged;

  /// Optional label to display next to the radio button.
  final String? label;

  /// The color scheme based on UI Kit semantic colors.
  final AppRadioColor color;

  /// Whether the radio button is disabled.
  final bool disabled;

  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.label,
    this.color = AppRadioColor.primary,
    this.disabled = false,
  });

  bool get isSelected => value == groupValue;

  Color _getActiveColor(AppColorsExtension colors) {
    switch (color) {
      case AppRadioColor.primary:
        return colors.primary;
      case AppRadioColor.success:
        return colors.success;
      case AppRadioColor.info:
        return colors.info;
      case AppRadioColor.warning:
        return colors.warning;
      case AppRadioColor.danger:
        return colors.danger;
      case AppRadioColor.secondary:
        return colors.secondary;
      case AppRadioColor.dark:
        return colors.textEmphasis;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    final activeColor = _getActiveColor(colors);

    return AppSemantics(
      label: label ?? 'Radio',
      selected: isSelected,
      enabled: !disabled,
      child: AppInteractiveWidget(
        disabled: disabled,
        onTap: onChanged != null ? () => onChanged!(value) : null,
        showHoverEffect: false,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? activeColor : colors.borderColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        color: activeColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
            if (label != null) ...[
              SizedBox(width: spacing.s2),
              Text(
                label!,
                style: typography.bodyBase.copyWith(
                  color: disabled
                      ? colors.bodySecondaryColor
                      : colors.textEmphasis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
