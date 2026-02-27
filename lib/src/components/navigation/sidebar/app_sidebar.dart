import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppSidebar extends AppStatelessWrapper {
  final Widget? header;
  final List<Widget> children;
  final Widget? footer;
  final double width;
  final bool isCollapsed;

  const AppSidebar({
    super.key,
    this.header,
    required this.children,
    this.footer,
    this.width = 260,
    this.isCollapsed = false,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    final currentWidth = isCollapsed ? 80.0 : width;

    return AppAnimatedContainer(
      duration: AppDurations.normal,
      width: currentWidth,
      decoration: BoxDecoration(
        color: theme.bodySecondaryBg,
        border: Border(right: BorderSide(color: theme.borderColor)),
      ),
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
              Padding(
                padding: EdgeInsets.all(isCollapsed ? spacing.s2 : spacing.s4),
                child: footer!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppSidebarItem extends AppStatelessWrapper {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isCollapsed;
  final Widget? trailing;
  final int? badgeCount;

  const AppSidebarItem({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.isSelected = false,
    this.isCollapsed = false,
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

    if (isCollapsed) {
      Widget collapsedContent = Container(
        decoration: BoxDecoration(color: bgColor, borderRadius: radii.base),
        padding: EdgeInsets.symmetric(vertical: spacing.s3),
        alignment: Alignment.center,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (icon != null) Icon(icon, size: 24, color: iconColor),
            if (badgeCount != null)
              Positioned(
                top: -6,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: theme.primary,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 10,
                    minHeight: 10,
                  ),
                ),
              ),
          ],
        ),
      );

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing.s2, vertical: 2),
        child: AppTooltip(
          message: label,
          placement: AppTooltipPlacement.top,
          child: AppInteractiveWidget(onTap: onTap, child: collapsedContent),
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

class AppSidebarMenu extends AppStatelessWrapper {
  final String title;
  final IconData? icon;
  final List<Widget> children;
  final bool isExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final bool isSidebarCollapsed;
  final bool hasSelectedChild;

  const AppSidebarMenu({
    super.key,
    required this.title,
    this.icon,
    required this.children,
    this.isExpanded = false,
    this.onExpansionChanged,
    this.isSidebarCollapsed = false,
    this.hasSelectedChild = false,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    if (isSidebarCollapsed) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing.s2, vertical: 2),
        child: AppTooltip(
          message: title,
          placement: AppTooltipPlacement.top,
          child: AppInteractiveWidget(
            onTap: () => onExpansionChanged?.call(!isExpanded),
            child: Container(
              decoration: BoxDecoration(
                color: hasSelectedChild
                    ? theme.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: radii.base,
              ),
              padding: EdgeInsets.symmetric(vertical: spacing.s3),
              alignment: Alignment.center,
              child: icon != null
                  ? Icon(
                      icon,
                      size: 24,
                      color: hasSelectedChild
                          ? theme.primary
                          : theme.bodySecondaryColor,
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInteractiveWidget(
          onTap: () => onExpansionChanged?.call(!isExpanded),
          child: Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: hasSelectedChild && !isExpanded
                  ? theme.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 15,
                    color: hasSelectedChild
                        ? theme.primary
                        : theme.bodySecondaryColor,
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: typography.bodySm.copyWith(
                      fontWeight: AppTypography.semiBold,
                      color: hasSelectedChild ? theme.primary : theme.bodyColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.25 : 0,
                  duration: AppDurations.quick,
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: theme.bodySecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        AppSizeAnimation(
          duration: AppDurations.quick,
          curve: Curves.easeInOut,
          child: isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(left: 12, top: 2, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
