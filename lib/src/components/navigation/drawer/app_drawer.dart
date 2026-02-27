import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppDrawer extends AppStatelessWrapper {
  final Widget? header;
  final List<Widget> children;
  final Widget? footer;
  final double width;

  const AppDrawer({
    super.key,
    this.header,
    required this.children,
    this.footer,
    this.width = 304,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Drawer(
      width: width,
      backgroundColor: theme.bodyBg,
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (header != null) ...[header!, const AppDivider()],
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: spacing.s2),
                children: children,
              ),
            ),
            if (footer != null) ...[
              const AppDivider(),
              Padding(padding: EdgeInsets.all(spacing.s4), child: footer!),
            ],
          ],
        ),
      ),
    );
  }
}

class AppDrawerItem extends AppStatelessWrapper {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isSelected;
  final Widget? trailing;
  final int? badgeCount;

  const AppDrawerItem({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.isSelected = false,
    this.trailing,
    this.badgeCount,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final textColor = isSelected ? theme.primary : theme.bodyColor;
    final iconColor = isSelected ? theme.primary : theme.bodySecondaryColor;
    final bgColor = isSelected
        ? theme.primary.withValues(alpha: 0.1)
        : Colors.transparent;

    Widget? actualTrailing = trailing;
    if (badgeCount != null) {
      actualTrailing = Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: theme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          badgeCount.toString(),
          style: typography.bodyXs.copyWith(
            color: Colors.white,
            fontWeight: AppTypography.bold,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.s3, vertical: 2),
      child: AppInteractiveWidget(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(color: bgColor, borderRadius: radii.base),
          padding: EdgeInsets.symmetric(
            horizontal: spacing.s3,
            vertical: spacing.s3,
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: iconColor),
                SizedBox(width: spacing.s3),
              ],
              Expanded(
                child: Text(
                  label,
                  style: typography.bodySm.copyWith(
                    color: textColor,
                    fontWeight: isSelected
                        ? AppTypography.semiBold
                        : AppTypography.medium,
                  ),
                ),
              ),
              ?actualTrailing,
            ],
          ),
        ),
      ),
    );
  }
}
