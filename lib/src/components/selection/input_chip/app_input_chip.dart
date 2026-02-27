import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Input Chip component.
class AppInputChip extends AppStatelessWrapper {
  final String label;
  final VoidCallback? onDeleted;
  final VoidCallback? onPressed;
  final Widget? avatar;
  final bool enabled;

  const AppInputChip({
    super.key,
    required this.label,
    this.onDeleted,
    this.onPressed,
    this.avatar,
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return InputChip(
      label: Text(label),
      onPressed: enabled ? onPressed : null,
      onDeleted: enabled ? onDeleted : null,
      avatar: avatar,
      labelStyle: typography.bodySm.copyWith(
        fontWeight: AppTypography.medium,
        color: colors.bodyColor,
      ),
      backgroundColor: colors.bodySecondaryBg,
      deleteIconColor: colors.bodySecondaryColor,
      padding: EdgeInsets.symmetric(
        horizontal: spacing.s2,
        vertical: spacing.s1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: radii.base,
        side: BorderSide(color: colors.borderColor, width: 1),
      ),
    );
  }
}
