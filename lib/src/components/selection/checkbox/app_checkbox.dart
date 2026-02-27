import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// Defines the color scheme of the checkbox.
enum AppCheckboxColor {
  primary,
  success,
  info,
  warning,
  danger,
  secondary,
  dark,
}

/// A premium checkbox component following the UI Kit design system.
/// Supports labels, color variants, and validation states.
class AppCheckbox extends AppStatelessWrapper {
  /// Whether the checkbox is checked.
  final bool value;

  /// Callback when the checkbox value changes.
  final ValueChanged<bool?>? onChanged;

  /// Optional label to display next to the checkbox.
  final String? label;

  /// The color scheme based on UI Kit semantic colors.
  final AppCheckboxColor color;

  /// Whether the checkbox is disabled.
  final bool disabled;

  /// Error text to display below the checkbox.
  final String? errorText;

  /// Whether the current state is valid.
  final bool isValid;

  /// Whether the current state is invalid.
  final bool isInvalid;

  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.color = AppCheckboxColor.primary,
    this.disabled = false,
    this.errorText,
    this.isValid = false,
    this.isInvalid = false,
  });

  Color _getActiveColor(AppColorsExtension colors) {
    if (isInvalid) return colors.danger;
    if (isValid) return colors.success;

    switch (color) {
      case AppCheckboxColor.primary:
        return colors.primary;
      case AppCheckboxColor.success:
        return colors.success;
      case AppCheckboxColor.info:
        return colors.info;
      case AppCheckboxColor.warning:
        return colors.warning;
      case AppCheckboxColor.danger:
        return colors.danger;
      case AppCheckboxColor.secondary:
        return colors.secondary;
      case AppCheckboxColor.dark:
        return colors.textEmphasis;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    final activeColor = _getActiveColor(colors);

    final borderColor = isInvalid
        ? colors.danger
        : (isValid
              ? colors.success
              : (value ? activeColor : colors.borderColor));

    return AppSemantics(
      label: label ?? 'Checkbox',
      checked: value,
      enabled: !disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppInteractiveWidget(
            disabled: disabled,
            onTap: onChanged != null ? () => onChanged!(!value) : null,
            showHoverEffect: false,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppAnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: value ? activeColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: value
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
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
          if (isInvalid && errorText != null) ...[
            SizedBox(height: spacing.s1),
            Text(
              errorText!,
              style: typography.bodySm.copyWith(color: colors.danger),
            ),
          ],
        ],
      ),
    );
  }
}
