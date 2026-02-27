import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// Defines an option for the [AppDropdown] component.
class AppDropdownOption<T> {
  final T value;
  final String label;
  final Widget? icon;

  const AppDropdownOption({
    required this.value,
    required this.label,
    this.icon,
  });
}

/// A premium dropdown component following the UI Kit design system.
/// Supports labels, hints, validation states, and standard DropdownButtonFormField features.
class AppDropdown<T> extends AppStatelessWrapper {
  /// The list of options to display in the dropdown.
  final List<AppDropdownOption<T>> options;

  /// The currently selected value.
  final T? value;

  /// Callback when the selected value changes.
  final ValueChanged<T?>? onChanged;

  /// Optional label to display above the dropdown.
  final String? labelText;

  /// Optional hint text to display when no value is selected.
  final String? hintText;

  /// Optional prefix icon.
  final Widget? prefixIcon;

  /// Optional suffix icon.
  final Widget? suffixIcon;

  /// Error text to display below the dropdown.
  final String? errorText;

  /// Whether the current state is valid.
  final bool isValid;

  /// Whether the current state is invalid.
  final bool isInvalid;

  /// Whether the dropdown is disabled.
  final bool enabled;

  const AppDropdown({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.isValid = false,
    this.isInvalid = false,
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final baseBorder = OutlineInputBorder(
      borderRadius: radii.base,
      borderSide: BorderSide(color: colors.borderColor, width: 1),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: radii.base,
      borderSide: BorderSide(color: colors.primary, width: 1.5),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: radii.base,
      borderSide: BorderSide(color: colors.danger, width: 1.5),
    );

    final successBorder = OutlineInputBorder(
      borderRadius: radii.base,
      borderSide: BorderSide(color: colors.success, width: 1.5),
    );

    var currentBorder = baseBorder;
    if (isInvalid || errorText != null) {
      currentBorder = errorBorder;
    } else if (isValid) {
      currentBorder = successBorder;
    }

    return AppSemantics(
      label: labelText ?? hintText ?? 'Dropdown select',
      enabled: enabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (labelText != null) ...[
            Text(
              labelText!,
              style: typography.bodyBase.copyWith(
                fontWeight: AppTypography.medium,
                color: colors.textEmphasis,
              ),
            ),
            SizedBox(height: spacing.s1),
          ],
          DropdownButtonFormField<T>(
            items: options.map((opt) {
              return DropdownMenuItem<T>(
                value: opt.value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (opt.icon != null) ...[
                      opt.icon!,
                      SizedBox(width: spacing.s2),
                    ],
                    Text(opt.label),
                  ],
                ),
              );
            }).toList(),
            initialValue: value,
            onChanged: enabled ? onChanged : null,
            style: typography.bodyBase.copyWith(
              color: enabled
                  ? colors.textEmphasis
                  : colors.textEmphasis.withValues(alpha: 0.5),
            ),
            icon:
                suffixIcon ??
                Icon(Icons.expand_more, color: colors.bodySecondaryColor),
            dropdownColor: colors.bodyBg,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: typography.bodyBase.copyWith(
                color: colors.bodySecondaryColor,
              ),
              fillColor: colors.bodySecondaryBg,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: spacing.s3,
                vertical: spacing.s2,
              ),
              prefixIcon: prefixIcon != null
                  ? IconTheme(
                      data: IconThemeData(
                        color: colors.bodySecondaryColor,
                        size: 20,
                      ),
                      child: prefixIcon!,
                    )
                  : null,
              border: currentBorder,
              enabledBorder: currentBorder,
              focusedBorder: focusedBorder,
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              errorText: (isInvalid || errorText != null) ? errorText : null,
              errorStyle: typography.bodySm.copyWith(color: colors.danger),
            ),
          ),
        ],
      ),
    );
  }
}
