import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Filter Chip component.
class AppFilterChip extends AppStatelessWrapper {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Widget? avatar;
  final bool enabled;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
    this.avatar,
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: enabled ? onSelected : null,
      avatar: avatar,
      labelStyle: typography.bodySm.copyWith(
        fontWeight: selected ? AppTypography.semiBold : AppTypography.medium,
        color: selected ? colors.primary : colors.bodyColor,
      ),
      selectedColor: colors.primary.withValues(alpha: 0.1),
      backgroundColor: Colors.transparent,
      disabledColor: colors.bodySecondaryBg,
      padding: EdgeInsets.symmetric(
        horizontal: spacing.s2,
        vertical: spacing.s1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: radii.base,
        side: BorderSide(
          color: selected ? colors.primary : colors.borderColor,
          width: 1,
        ),
      ),
      checkmarkColor: colors.primary,
    );
  }
}
