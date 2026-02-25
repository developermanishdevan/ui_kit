import 'package:flutter/material.dart';

class AppNavRailItem {
  const AppNavRailItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
  });
  final IconData icon;
  final String label;
  final IconData? selectedIcon;
}

class AppNavigationRail extends StatelessWidget {
  const AppNavigationRail({
    required this.items, required this.selectedIndex, required this.onDestinationSelected, super.key,
    this.leading,
    this.trailing,
    this.extended = false,
    this.backgroundColor,
    this.labelType,
  });

  final List<AppNavRailItem> items;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget? leading;
  final Widget? trailing;
  final bool extended;
  final Color? backgroundColor;
  final NavigationRailLabelType? labelType;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations: items
          .map((item) => NavigationRailDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.selectedIcon ?? item.icon),
                label: Text(item.label),
              ))
          .toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      leading: leading,
      trailing: trailing,
      extended: extended,
      backgroundColor: backgroundColor,
      labelType:
          extended ? null : (labelType ?? NavigationRailLabelType.selected),
    );
  }
}
