import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// Defines the color scheme of the switch.
enum AppSwitchColor { primary, success, info, warning, danger, secondary, dark }

/// A premium switch component following the UI Kit design system.
/// Supports labels, color variants, and animated transitions.
class AppSwitch extends AppStatelessWrapper {
  /// Whether the switch is on.
  final bool value;

  /// Callback when the switch value changes.
  final ValueChanged<bool>? onChanged;

  /// Optional label to display next to the switch.
  final String? label;

  /// The color scheme based on UI Kit semantic colors.
  final AppSwitchColor color;

  /// Whether the switch is disabled.
  final bool disabled;

  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.color = AppSwitchColor.primary,
    this.disabled = false,
  });

  Color _getActiveColor(AppColorsExtension colors) {
    switch (color) {
      case AppSwitchColor.primary:
        return colors.primary;
      case AppSwitchColor.success:
        return colors.success;
      case AppSwitchColor.info:
        return colors.info;
      case AppSwitchColor.warning:
        return colors.warning;
      case AppSwitchColor.danger:
        return colors.danger;
      case AppSwitchColor.secondary:
        return colors.secondary;
      case AppSwitchColor.dark:
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
      label: label ?? 'Switch',
      checked: value,
      enabled: !disabled,
      child: AppInteractiveWidget(
        disabled: disabled,
        onTap: onChanged != null ? () => onChanged!(!value) : null,
        showHoverEffect: false,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 36,
              height: 20,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: value ? activeColor : colors.bodySecondaryBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: value ? activeColor : colors.borderColor,
                  width: 1,
                ),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
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
