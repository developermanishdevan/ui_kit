import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

enum AppTabVariant { underline, pills }

class AppTab {
  final String label;
  final IconData? icon;
  final Widget content;

  const AppTab({required this.label, required this.content, this.icon});
}

class AppTabs extends AppStatefulWrapper {
  final List<AppTab> tabs;
  final AppTabVariant variant;
  final bool isJustified;
  final bool isVertical;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;

  const AppTabs({
    super.key,
    required this.tabs,
    this.variant = AppTabVariant.underline,
    this.isJustified = false,
    this.isVertical = false,
    this.initialIndex = 0,
    this.onTabChanged,
  });

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends AppStatefulWrapperState<AppTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        widget.onTabChanged?.call(_tabController.index);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (widget.isVertical) {
      return _buildVerticalTabs(context);
    }
    return _buildHorizontalTabs(context);
  }

  Widget _buildHorizontalTabs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTabBar(context),
        SizedBox(
          height: Theme.of(context).extension<AppSpacingExtension>()!.s3,
        ),
        _buildTabContent(),
      ],
    );
  }

  Widget _buildVerticalTabs(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 150, child: _buildTabBar(context)),
        SizedBox(width: Theme.of(context).extension<AppSpacingExtension>()!.s4),
        Expanded(child: _buildTabContent()),
      ],
    );
  }

  Widget _buildTabContent() {
    return AppAnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.01),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey<int>(_tabController.index),
        child: widget.tabs[_tabController.index].content,
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    if (widget.variant == AppTabVariant.pills) {
      return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: theme.bodySecondaryBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TabBar(
          controller: _tabController,
          isScrollable: !widget.isJustified,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: theme.primary.withAlpha(50),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          labelColor: Colors.white,
          unselectedLabelColor: theme.bodySecondaryColor,
          labelStyle: Theme.of(context)
              .extension<AppTypographyExtension>()!
              .bodyBase
              .copyWith(fontWeight: AppTypography.semiBold),
          unselectedLabelStyle: Theme.of(
            context,
          ).extension<AppTypographyExtension>()!.bodyBase,
          tabs: widget.tabs.map((tab) => _buildTab(tab)).toList(),
        ),
      );
    }

    // Underline variant
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.borderColor.withAlpha(50)),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: !widget.isJustified,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: theme.primary),
        ),
        labelColor: theme.primary,
        unselectedLabelColor: theme.bodySecondaryColor,
        labelStyle: Theme.of(context)
            .extension<AppTypographyExtension>()!
            .bodyBase
            .copyWith(fontWeight: AppTypography.semiBold),
        unselectedLabelStyle: Theme.of(
          context,
        ).extension<AppTypographyExtension>()!.bodyBase,
        tabs: widget.tabs.map((tab) => _buildTab(tab)).toList(),
      ),
    );
  }

  Widget _buildTab(AppTab tab) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tab.icon != null) ...[
            Icon(tab.icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(tab.label),
        ],
      ),
    );
  }
}
