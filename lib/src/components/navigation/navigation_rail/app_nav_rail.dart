import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppNavRailItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final int? badgeCount;

  const AppNavRailItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.badgeCount,
  });
}

class AppNavRail extends AppStatelessWrapper {
  final List<AppNavRailItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final Widget? leading;
  final Widget? trailing;
  final bool extended;

  const AppNavRail({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.leading,
    this.trailing,
    this.extended = false,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;

    return Container(
      decoration: BoxDecoration(
        color: theme.bodyBg,
        border: Border(right: BorderSide(color: theme.borderColor)),
      ),
      child: NavigationRail(
        backgroundColor: Colors.transparent,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        leading: leading,
        trailing: trailing,
        extended: extended,
        indicatorColor: theme.primary.withValues(alpha: 0.15),
        selectedIconTheme: IconThemeData(color: theme.primary, size: 24),
        unselectedIconTheme: IconThemeData(
          color: theme.bodySecondaryColor,
          size: 24,
        ),
        selectedLabelTextStyle: typography.bodyXs.copyWith(
          color: theme.primary,
          fontWeight: AppTypography.semiBold,
        ),
        unselectedLabelTextStyle: typography.bodyXs.copyWith(
          color: theme.bodySecondaryColor,
          fontWeight: AppTypography.medium,
        ),
        destinations: items.map((item) {
          Widget iconWidget = Icon(item.icon);
          Widget activeIconWidget = Icon(item.activeIcon ?? item.icon);

          if (item.badgeCount != null) {
            final badge = Positioned(
              top: -4,
              right: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.danger,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  item.badgeCount! > 99 ? '99+' : item.badgeCount.toString(),
                  style: typography.bodyXs.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: AppTypography.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );

            iconWidget = Stack(
              clipBehavior: Clip.none,
              children: [iconWidget, badge],
            );
            activeIconWidget = Stack(
              clipBehavior: Clip.none,
              children: [activeIconWidget, badge],
            );
          }

          return NavigationRailDestination(
            icon: iconWidget,
            selectedIcon: activeIconWidget,
            label: Text(item.label),
          );
        }).toList(),
      ),
    );
  }
}
