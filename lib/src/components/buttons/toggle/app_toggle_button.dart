import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Toggle Button component.
class AppToggleButton extends AppStatelessWrapper {
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final AppButtonColor activeColor;
  final AppButtonSize size;

  const AppToggleButton({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.activeColor = AppButtonColor.primary,
    this.size = AppButtonSize.md,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final activeBg = _getThemeColor(colors);

    return Container(
      padding: EdgeInsets.all(spacing.s1),
      decoration: BoxDecoration(
        color: colors.bodySecondaryBg,
        borderRadius: radii.base,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onChanged(index),
            child: AppAnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: spacing.s3,
                vertical: spacing.s2,
              ),
              decoration: BoxDecoration(
                color: isSelected ? activeBg : Colors.transparent,
                borderRadius: radii.base,
                boxShadow: isSelected ? [AppShadows.sm] : null,
              ),
              child: Text(
                options[index],
                style: typography.bodySm.copyWith(
                  fontWeight: isSelected
                      ? AppTypography.semiBold
                      : AppTypography.regular,
                  color: isSelected ? Colors.white : colors.bodySecondaryColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Color _getThemeColor(AppColorsExtension colors) {
    switch (activeColor) {
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
