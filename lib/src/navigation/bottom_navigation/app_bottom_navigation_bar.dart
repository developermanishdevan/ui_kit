import 'package:flutter/material.dart';
import '../../foundation/tokens/typography/app_typography.dart';

class AppBottomNavItem {
  const AppBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badge,
  });
  final IconData icon;
  final String label;
  final IconData? activeIcon;
  final String? badge;
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.items, required this.currentIndex, required this.onTap, super.key,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
    this.useMaterial3Style = true,
  });

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final bool showLabels;
  final bool useMaterial3Style;

  @override
  Widget build(BuildContext context) {
    if (useMaterial3Style) {
      return NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        backgroundColor: backgroundColor,
        destinations: items
            .map((item) => NavigationDestination(
                  icon: _buildIcon(item, false),
                  selectedIcon: _buildIcon(item, true),
                  label: item.label,
                ))
            .toList(),
      );
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      selectedItemColor: selectedColor ?? Theme.of(context).colorScheme.primary,
      unselectedItemColor:
          unselectedColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      showSelectedLabels: showLabels,
      showUnselectedLabels: showLabels,
      selectedLabelStyle: AppTypography.labelSmall,
      unselectedLabelStyle: AppTypography.labelSmall,
      type: BottomNavigationBarType.fixed,
      items: items
          .map((item) => BottomNavigationBarItem(
                icon: _buildIcon(item, false),
                activeIcon: _buildIcon(item, true),
                label: item.label,
              ))
          .toList(),
    );
  }

  Widget _buildIcon(AppBottomNavItem item, bool active) {
    final icon = active ? (item.activeIcon ?? item.icon) : item.icon;
    if (item.badge == null) return Icon(icon);
    return Badge(label: Text(item.badge!), child: Icon(icon));
  }
}
