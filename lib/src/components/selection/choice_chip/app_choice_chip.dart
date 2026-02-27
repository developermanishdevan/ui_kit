import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Choice Chip component.
class AppChoiceChip extends AppStatelessWrapper {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Widget? avatar;
  final bool enabled;

  const AppChoiceChip({
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

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: enabled ? onSelected : null,
      avatar: avatar,
      labelStyle: typography.bodySm.copyWith(
        fontWeight: selected ? AppTypography.semiBold : AppTypography.medium,
        color: selected ? Colors.white : colors.bodyColor,
      ),
      selectedColor: colors.primary,
      backgroundColor: colors.bodySecondaryBg,
      disabledColor: colors.bodySecondaryBg.withValues(alpha: 0.5),
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
      showCheckmark: false,
    );
  }
}
