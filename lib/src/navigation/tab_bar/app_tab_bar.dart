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
    required this.tabs, required this.views, super.key,
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
          controller: _ctrl,
          isScrollable: widget.isScrollable,
          indicatorColor: widget.indicatorColor ?? AppColors.primary,
          labelColor: widget.labelColor ?? AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTypography.labelLarge,
          unselectedLabelStyle: AppTypography.labelLarge,
          tabs: widget.tabs
              .map((t) => Tab(
                    text: t.icon == null ? t.label : null,
                    icon: t.icon != null ? _badgedIcon(t) : null,
                    child: t.icon != null ? Text(t.label) : null,
                  ))
              .toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _ctrl,
            children: widget.views,
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
