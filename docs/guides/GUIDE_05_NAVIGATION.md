# Guide 05 — Navigation System

## 5.1 AppAppBar

```dart
// lib/src/navigation/app_bar/app_app_bar.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/colors/app_colors.dart';
import '../../foundation/tokens/typography/app_typography.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.bottom,
    this.showBackButton = true,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final bool showBackButton;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return AppBar(
      title: titleWidget ?? (title != null
        ? Text(title!, style: AppTypography.titleLarge.copyWith(
            color: foregroundColor ?? AppColors.textPrimary,
          ))
        : null),
      leading: leading ?? (showBackButton && canPop
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          )
        : null),
      automaticallyImplyLeading: showBackButton,
      actions:           actions,
      centerTitle:       centerTitle,
      backgroundColor:   backgroundColor ?? Theme.of(context).colorScheme.surface,
      foregroundColor:   foregroundColor ?? AppColors.textPrimary,
      elevation:         elevation,
      surfaceTintColor:  Colors.transparent,
      bottom:            bottom,
    );
  }
}

/// Transparent app bar for hero/image headers
class AppTransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTransparentAppBar({
    super.key,
    this.actions,
    this.foregroundColor = AppColors.white,
  });

  final List<Widget>? actions;
  final Color foregroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:  Colors.transparent,
      foregroundColor:  foregroundColor,
      elevation:        0,
      scrolledUnderElevation: 0,
      actions: actions,
    );
  }
}
```

---

## 5.2 AppBottomNavigationBar

```dart
// lib/src/navigation/bottom_navigation/app_bottom_navigation_bar.dart
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
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
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
        destinations: items.map((item) => NavigationDestination(
          icon:        _buildIcon(item, false),
          selectedIcon:_buildIcon(item, true),
          label:       item.label,
        )).toList(),
      );
    }

    return BottomNavigationBar(
      currentIndex:           currentIndex,
      onTap:                  onTap,
      backgroundColor:        backgroundColor ?? Theme.of(context).colorScheme.surface,
      selectedItemColor:      selectedColor ?? Theme.of(context).colorScheme.primary,
      unselectedItemColor:    unselectedColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      showSelectedLabels:     showLabels,
      showUnselectedLabels:   showLabels,
      selectedLabelStyle:     AppTypography.labelSmall,
      unselectedLabelStyle:   AppTypography.labelSmall,
      type: BottomNavigationBarType.fixed,
      items: items.map((item) => BottomNavigationBarItem(
        icon:       _buildIcon(item, false),
        activeIcon: _buildIcon(item, true),
        label:      item.label,
      )).toList(),
    );
  }

  Widget _buildIcon(AppBottomNavItem item, bool active) {
    final icon = active ? (item.activeIcon ?? item.icon) : item.icon;
    if (item.badge == null) return Icon(icon);
    return Badge(label: Text(item.badge!), child: Icon(icon));
  }
}
```

---

## 5.3 AppTabBar

```dart
// lib/src/navigation/tab_bar/app_tab_bar.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/colors/app_colors.dart';
import '../../foundation/tokens/typography/app_typography.dart';

class AppTabBarItem {
  const AppTabBarItem({required this.label, this.icon, this.badge});
  final String label;
  final IconData? icon;
  final int? badge;
}

/// Self-contained TabBar + TabBarView widget.
class AppTabView extends StatefulWidget {
  const AppTabView({
    super.key,
    required this.tabs,
    required this.views,
    this.initialIndex = 0,
    this.isScrollable = false,
    this.indicatorColor,
    this.labelColor,
    this.onTabChanged,
  });

  final List<AppTabBarItem> tabs;
  final List<Widget> views;
  final int initialIndex;
  final bool isScrollable;
  final Color? indicatorColor;
  final Color? labelColor;
  final ValueChanged<int>? onTabChanged;

  @override
  State<AppTabView> createState() => _AppTabViewState();
}

class _AppTabViewState extends State<AppTabView>
    with SingleTickerProviderStateMixin {
  late final TabController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TabController(
      length: widget.tabs.length,
      initialIndex: widget.initialIndex,
      vsync: this,
    );
    _ctrl.addListener(() {
      if (!_ctrl.indexIsChanging) widget.onTabChanged?.call(_ctrl.index);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller:    _ctrl,
          isScrollable:  widget.isScrollable,
          indicatorColor: widget.indicatorColor ?? AppColors.primary,
          labelColor:    widget.labelColor ?? AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle:    AppTypography.labelLarge,
          unselectedLabelStyle: AppTypography.labelLarge,
          tabs: widget.tabs.map((t) => Tab(
            text:  t.icon == null ? t.label : null,
            icon:  t.icon != null ? _badgedIcon(t) : null,
            child: t.icon != null ? Text(t.label) : null,
          )).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _ctrl,
            children:   widget.views,
          ),
        ),
      ],
    );
  }

  Widget _badgedIcon(AppTabBarItem t) {
    if (t.badge == null) return Icon(t.icon);
    return Badge(
      label: Text('${t.badge}'),
      child: Icon(t.icon),
    );
  }
}
```

---

## 5.4 AppDrawer

```dart
// lib/src/navigation/drawer/app_drawer.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/colors/app_colors.dart';
import '../../foundation/tokens/spacing/app_spacing.dart';
import '../../foundation/tokens/typography/app_typography.dart';

class AppDrawerItem {
  const AppDrawerItem({
    required this.icon,
    required this.label,
    this.route,
    this.onTap,
    this.badge,
    this.dividerAfter = false,
  });
  final IconData icon;
  final String label;
  final String? route;
  final VoidCallback? onTap;
  final String? badge;
  final bool dividerAfter;
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.items,
    this.header,
    this.footer,
    this.width = 280.0,
    this.activeRoute,
  });

  final List<AppDrawerItem> items;
  final Widget? header;
  final Widget? footer;
  final double width;
  final String? activeRoute;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: width,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            if (header != null) header!,
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                children: items.map((item) {
                  final isActive = activeRoute != null &&
                      activeRoute == item.route;
                  return _buildItem(context, item, isActive);
                }).toList(),
              ),
            ),
            if (footer != null) ...[
              const Divider(height: 1),
              footer!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, AppDrawerItem item, bool isActive) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: isActive
              ? BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: ListTile(
            leading: Icon(
              item.icon,
              color: isActive ? cs.primary : AppColors.textSecondary,
            ),
            title: Text(
              item.label,
              style: AppTypography.bodyMedium.copyWith(
                color:      isActive ? cs.primary : AppColors.textPrimary,
                fontWeight: isActive
                    ? AppTypography.weightSemiBold
                    : AppTypography.weightRegular,
              ),
            ),
            trailing: item.badge != null
                ? Badge(label: Text(item.badge!))
                : null,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onTap: () {
              Navigator.of(context).pop();
              if (item.onTap != null) {
                item.onTap!();
              } else if (item.route != null) {
                Navigator.of(context).pushNamed(item.route!);
              }
            },
          ),
        ),
        if (item.dividerAfter)
          const Divider(height: 16, indent: 16, endIndent: 16),
      ],
    );
  }
}
```

---

## 5.5 AppBreadcrumb

```dart
// lib/src/navigation/breadcrumb/app_breadcrumb.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/colors/app_colors.dart';
import '../../foundation/tokens/typography/app_typography.dart';

class AppBreadcrumbItem {
  const AppBreadcrumbItem({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;
}

class AppBreadcrumb extends StatelessWidget {
  const AppBreadcrumb({
    super.key,
    required this.items,
    this.separator = '/',
    this.activeColor,
    this.inactiveColor,
    this.style,
  });

  final List<AppBreadcrumbItem> items;
  final String separator;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final active   = activeColor   ?? AppColors.primary;
    final inactive = inactiveColor ?? AppColors.textSecondary;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(items.length * 2 - 1, (i) {
        if (i.isOdd) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(separator, style: (style ?? AppTypography.bodySmall)
                .copyWith(color: inactive)),
          );
        }
        final idx  = i ~/ 2;
        final item = items[idx];
        final isLast = idx == items.length - 1;
        return GestureDetector(
          onTap: item.onTap,
          child: Text(
            item.label,
            style: (style ?? AppTypography.bodySmall).copyWith(
              color: isLast ? inactive : active,
              decoration: (!isLast && item.onTap != null)
                  ? TextDecoration.underline : null,
            ),
          ),
        );
      }),
    );
  }
}
```

---

## 5.6 AppNavigationRail

```dart
// lib/src/navigation/navigation_rail/app_navigation_rail.dart
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
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onDestinationSelected,
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
      destinations: items.map((item) => NavigationRailDestination(
        icon:         Icon(item.icon),
        selectedIcon: Icon(item.selectedIcon ?? item.icon),
        label:        Text(item.label),
      )).toList(),
      selectedIndex:           selectedIndex,
      onDestinationSelected:   onDestinationSelected,
      leading:                 leading,
      trailing:                trailing,
      extended:                extended,
      backgroundColor:         backgroundColor,
      labelType: extended ? null : (labelType ?? NavigationRailLabelType.selected),
    );
  }
}
```

---

## 5.7 AppRouteTransition

```dart
// lib/src/navigation/route_transitions/app_route_transition.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

enum AppTransitionType { fade, slide, slideUp, scale, rotate }

class AppRouteTransition<T> extends PageRouteBuilder<T> {
  AppRouteTransition({
    required Widget page,
    this.type = AppTransitionType.slide,
    super.settings,
    Duration duration = AppDurations.page,
  }) : super(
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (ctx, anim, secAnim, child) {
      final curved = CurvedAnimation(
        parent: anim, curve: Curves.easeInOut,
      );
      return switch (type) {
        AppTransitionType.fade    => FadeTransition(opacity: curved, child: child),
        AppTransitionType.scale   => ScaleTransition(scale: curved, child: child),
        AppTransitionType.slideUp => SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(curved),
          child: child,
        ),
        AppTransitionType.rotate  => RotationTransition(turns: curved, child: child),
        _                         => SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(curved),
          child: child,
        ),
      };
    },
  );

  final AppTransitionType type;
}
```

---

## 5.8 AppPageIndicator

```dart
// lib/src/navigation/app_page_indicator.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/colors/app_colors.dart';

class AppPageIndicator extends StatelessWidget {
  const AppPageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8.0,
    this.activeDotWidth = 24.0,
    this.spacing = 6.0,
  });

  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? inactiveColor;
  final double dotSize;
  final double activeDotWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final active   = activeColor   ?? AppColors.primary;
    final inactive = inactiveColor ?? AppColors.grey300;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width:  isActive ? activeDotWidth : dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color:        isActive ? active : inactive,
            borderRadius: BorderRadius.circular(dotSize / 2),
          ),
        );
      }),
    );
  }
}
```
