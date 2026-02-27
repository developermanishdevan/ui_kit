import 'package:ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

// Foundation
import 'src/typography_section.dart';

// Components — Buttons
import 'src/buttons_section.dart';

// Components — Inputs
import 'src/form_basics_section.dart';
import 'src/input_picker_section.dart';
import 'src/form_validation_section.dart';
import 'src/file_upload_section.dart';
import 'src/dropdown_section.dart';

// Components — Selection
import 'src/selection_section.dart';

// Components — Feedback
import 'src/alert_section.dart';
import 'src/spinner_section.dart';
import 'src/progress_section.dart';
import 'src/toast_section.dart';
import 'src/snackbar_section.dart';
import 'src/shimmer_section.dart';
import 'src/skeleton_section.dart';
import 'src/app_loader_section.dart';
import 'src/retry_wrapper_section.dart';
import 'src/banner_section.dart';
import 'src/empty_state_section.dart';

// Components — Data Display
import 'src/cards_section.dart';
import 'src/avatar_section.dart';
import 'src/badge_section.dart';
import 'src/accordion_section.dart';
import 'src/carousel_section.dart';
import 'src/collapse_section.dart';
import 'src/dividers_section.dart';
import 'src/expandable_tile_section.dart';
import 'src/key_value_row_section.dart';
import 'src/list_tile_section.dart';
import 'src/rich_text_section.dart';
import 'src/stepper_section.dart';
import 'src/timeline_section.dart';
import 'src/apex_chart_section.dart';
import 'src/basic_tables_section.dart';
import 'src/gridjs_section.dart';

// Components — Navigation
import 'src/breadcrumb_section.dart';
import 'src/tabs_section.dart';
import 'src/pagination_section.dart';
import 'src/app_top_bar_section.dart';
import 'src/bottom_nav_section.dart';
import 'src/drawer_section.dart';
import 'src/nav_rail_section.dart';
import 'src/sidebar_section.dart';

// Components — Overlays
import 'src/modal_section.dart';
import 'src/offcanvas_section.dart';
import 'src/popover_section.dart';
import 'src/tooltip_section.dart';
import 'src/bottom_sheet_section.dart';
import 'src/dialog_section.dart';
import 'src/context_menu_section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Kit Playground',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: PlaygroundPage(
        onToggleTheme: _toggleTheme,
        isDark: _themeMode == ThemeMode.dark,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────────────────────

class _NavItem {
  final String label;
  final IconData icon;
  final Widget section;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.section,
  });
}

class _NavGroup {
  final String title;
  final IconData groupIcon;
  final List<_NavItem> items;

  const _NavGroup({
    required this.title,
    required this.groupIcon,
    required this.items,
  });
}

final List<_NavGroup> _navGroups = [
  _NavGroup(
    title: 'Foundation',
    groupIcon: Icons.palette_outlined,
    items: [
      _NavItem(
        label: 'Typography',
        icon: Icons.text_fields_rounded,
        section: const TypographySection(),
      ),
    ],
  ),
  _NavGroup(
    title: 'Buttons',
    groupIcon: Icons.smart_button_outlined,
    items: [
      _NavItem(
        label: 'Buttons',
        icon: Icons.touch_app_outlined,
        section: const ButtonsSection(),
      ),
    ],
  ),
  _NavGroup(
    title: 'Inputs',
    groupIcon: Icons.input_outlined,
    items: [
      _NavItem(
        label: 'Form Basics',
        icon: Icons.edit_outlined,
        section: const FormBasicsSection(),
      ),
      _NavItem(
        label: 'Input Pickers',
        icon: Icons.calendar_month_outlined,
        section: const InputPickerSection(),
      ),
      _NavItem(
        label: 'Form Validation',
        icon: Icons.rule_outlined,
        section: const FormValidationSection(),
      ),
      _NavItem(
        label: 'File Upload',
        icon: Icons.upload_file_outlined,
        section: const FileUploadSection(),
      ),
      _NavItem(
        label: 'Dropdown',
        icon: Icons.arrow_drop_down_circle_outlined,
        section: const DropdownSection(),
      ),
    ],
  ),
  _NavGroup(
    title: 'Selection',
    groupIcon: Icons.checklist_rounded,
    items: [
      _NavItem(
        label: 'Selection',
        icon: Icons.check_circle_outline,
        section: const SelectionSection(),
      ),
    ],
  ),
  _NavGroup(
    title: 'Feedback',
    groupIcon: Icons.feedback_outlined,
    items: [
      _NavItem(
        label: 'Alerts',
        icon: Icons.warning_amber_outlined,
        section: const AlertSection(),
      ),
      _NavItem(
        label: 'Spinners',
        icon: Icons.rotate_right_outlined,
        section: const SpinnerSection(),
      ),
      _NavItem(
        label: 'Progress',
        icon: Icons.data_usage_outlined,
        section: const ProgressSection(),
      ),
      _NavItem(
        label: 'Toasts',
        icon: Icons.notifications_outlined,
        section: const ToastSection(),
      ),
      _NavItem(
        label: 'Snackbars',
        icon: Icons.chat_bubble_outline,
        section: const SnackbarSection(),
      ),
      _NavItem(
        label: 'Shimmer',
        icon: Icons.blur_linear_outlined,
        section: const ShimmerSection(),
      ),
      _NavItem(
        label: 'Skeleton',
        icon: Icons.space_dashboard_outlined,
        section: const SkeletonSection(),
      ),

      _NavItem(
        label: 'App Loader',
        icon: Icons.hourglass_empty_outlined,
        section: const AppLoaderSection(),
      ),
      _NavItem(
        label: 'Retry Wrapper',
        icon: Icons.replay_outlined,
        section: const RetryWrapperSection(),
      ),
      _NavItem(
        label: 'Banner',
        icon: Icons.announcement_outlined,
        section: const BannerSection(),
      ),
      _NavItem(
        label: 'Empty State',
        icon: Icons.inbox_outlined,
        section: const EmptyStateSection(),
      ),
    ],
  ),
  _NavGroup(
    title: 'Data Display',
    groupIcon: Icons.grid_view_outlined,
    items: [
      _NavItem(
        label: 'Cards',
        icon: Icons.credit_card_outlined,
        section: const CardsSection(),
      ),
      _NavItem(
        label: 'Avatars',
        icon: Icons.account_circle_outlined,
        section: const AvatarSection(),
      ),
      _NavItem(
        label: 'Badges',
        icon: Icons.new_releases_outlined,
        section: const BadgeSection(),
      ),
      _NavItem(
        label: 'Accordion',
        icon: Icons.unfold_more_outlined,
        section: const AccordionSection(),
      ),
      _NavItem(
        label: 'Collapse',
        icon: Icons.compress_outlined,
        section: const CollapseSection(),
      ),
      _NavItem(
        label: 'Carousel',
        icon: Icons.view_carousel_outlined,
        section: const CarouselSection(),
      ),
      _NavItem(
        label: 'Dividers',
        icon: Icons.horizontal_rule_outlined,
        section: const DividersSection(),
      ),
      _NavItem(
        label: 'Expandable Tile',
        icon: Icons.expand_outlined,
        section: const ExpandableTileSection(),
      ),
      _NavItem(
        label: 'Key Value Row',
        icon: Icons.table_rows_outlined,
        section: const KeyValueRowSection(),
      ),
      _NavItem(
        label: 'List Tile',
        icon: Icons.list_outlined,
        section: const ListTileSection(),
      ),
      _NavItem(
        label: 'Rich Text',
        icon: Icons.format_align_left_outlined,
        section: const RichTextSection(),
      ),
      _NavItem(
        label: 'Stepper',
        icon: Icons.linear_scale_outlined,
        section: const StepperSection(),
      ),
      _NavItem(
        label: 'Timeline',
        icon: Icons.timeline_outlined,
        section: const TimelineSection(),
      ),
      _NavItem(
        label: 'Charts',
        icon: Icons.bar_chart_outlined,
        section: const ApexChartSection(),
      ),
      _NavItem(
        label: 'Basic Tables',
        icon: Icons.table_chart_outlined,
        section: const BasicTablesSection(),
      ),
      _NavItem(
        label: 'Grid Table',
        icon: Icons.grid_on_outlined,
        section: const GridJsSection(),
      ),
    ],
  ),
  _NavGroup(
    title: 'Navigation',
    groupIcon: Icons.navigation_outlined,
    items: [
      _NavItem(
        label: 'Breadcrumb',
        icon: Icons.account_tree_outlined,
        section: const BreadcrumbSection(),
      ),
      _NavItem(
        label: 'App Top Bar',
        icon: Icons.horizontal_split_outlined,
        section: const AppTopBarSection(),
      ),
      _NavItem(
        label: 'Bottom Navigation',
        icon: Icons.call_to_action_outlined,
        section: const BottomNavSection(),
      ),
      _NavItem(
        label: 'Drawer',
        icon: Icons.menu_open_outlined,
        section: const DrawerSection(),
      ),
      _NavItem(
        label: 'Navigation Rail',
        icon: Icons.vertical_split_outlined,
        section: const NavRailSection(),
      ),
      _NavItem(
        label: 'Sidebar',
        icon: Icons.view_sidebar_outlined,
        section: const SidebarSection(),
      ),
      _NavItem(
        label: 'Tabs',
        icon: Icons.tab_outlined,
        section: const TabsSection(),
      ),
      _NavItem(
        label: 'Pagination',
        icon: Icons.pages_outlined,
        section: const PaginationSection(),
      ),
    ],
  ),
  _NavGroup(
    title: 'Overlays',
    groupIcon: Icons.layers_outlined,
    items: [
      _NavItem(
        label: 'Modals',
        icon: Icons.open_in_new_outlined,
        section: const ModalSection(),
      ),
      _NavItem(
        label: 'Offcanvas',
        icon: Icons.menu_open_outlined,
        section: const OffcanvasSection(),
      ),
      _NavItem(
        label: 'Popovers',
        icon: Icons.bubble_chart_outlined,
        section: const PopoverSection(),
      ),
      _NavItem(
        label: 'Tooltips',
        icon: Icons.info_outline,
        section: const TooltipSection(),
      ),
      _NavItem(
        label: 'Bottom Sheets',
        icon: Icons.vertical_align_top_outlined,
        section: const BottomSheetSection(),
      ),
      _NavItem(
        label: 'Dialogs',
        icon: Icons.chat_bubble_outline,
        section: const DialogSection(),
      ),
      _NavItem(
        label: 'Context Menu',
        icon: Icons.more_vert_outlined,
        section: const ContextMenuSection(),
      ),
    ],
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// PLAYGROUND PAGE
// ─────────────────────────────────────────────────────────────────────────────

class PlaygroundPage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;
  const PlaygroundPage({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  // Flat index across all items
  int _selectedGroupIndex = 0;
  int _selectedItemIndex = 0;

  // Track which groups are expanded
  late final List<bool> _groupExpanded;

  @override
  void initState() {
    super.initState();
    _groupExpanded = List.generate(_navGroups.length, (i) => i == 0);
  }

  _NavItem get _currentItem =>
      _navGroups[_selectedGroupIndex].items[_selectedItemIndex];

  void _onSelect(int groupIndex, int itemIndex) {
    setState(() {
      _selectedGroupIndex = groupIndex;
      _selectedItemIndex = itemIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: theme.bodyBg,
      appBar: isMobile
          ? AppTopBar(
              titleText: _currentItem.label,
              actions: [
                _ThemeToggle(
                  isDark: widget.isDark,
                  onToggle: widget.onToggleTheme,
                ),
                const SizedBox(width: AppSpacing.s2),
              ],
            )
          : null,
      drawer: isMobile
          ? AppDrawer(
              header: _buildSidebarHeader(theme),
              children: [
                for (int gi = 0; gi < _navGroups.length; gi++)
                  _buildGroupTile(context, theme, gi),
              ],
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile)
            AppSidebar(
              header: _buildSidebarHeader(theme),
              children: [
                for (int gi = 0; gi < _navGroups.length; gi++)
                  _buildGroupTile(context, theme, gi),
              ],
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMobile) _buildTopBar(context, theme),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, anim) =>
                        FadeTransition(opacity: anim, child: child),
                    child: SingleChildScrollView(
                      key: ValueKey('$_selectedGroupIndex-$_selectedItemIndex'),
                      padding: const EdgeInsets.all(AppSpacing.s4),
                      child: _currentItem.section,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Top bar (desktop) ──────────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context, AppColorsExtension theme) {
    final group = _navGroups[_selectedGroupIndex];
    return SizedBox(
      height: 52,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: AppTopBar(
          backgroundColor: theme.bodyBg,
          titleWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(group.groupIcon, size: 16, color: theme.bodySecondaryColor),
              const SizedBox(width: 6),
              Text(
                group.title,
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  Icons.chevron_right,
                  size: 14,
                  color: theme.bodySecondaryColor,
                ),
              ),
              Text(
                _currentItem.label,
                style: AppTypography.bodySm.copyWith(
                  color: theme.textEmphasis,
                  fontWeight: AppTypography.semiBold,
                ),
              ),
            ],
          ),
          actions: [
            _ThemeToggle(isDark: widget.isDark, onToggle: widget.onToggleTheme),
            const SizedBox(width: AppSpacing.s4),
          ],
        ),
      ),
    );
  }

  // ── Sidebar Helpers ────────────────────────────────────────────────────────

  Widget _buildSidebarHeader(AppColorsExtension theme) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.primary, theme.info],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.widgets_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UI Kit',
                style: AppTypography.bodyBase.copyWith(
                  fontWeight: AppTypography.bold,
                  color: theme.textEmphasis,
                ),
              ),
              Text(
                'Component Playground',
                style: AppTypography.bodyXs.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupTile(
    BuildContext context,
    AppColorsExtension theme,
    int gi,
  ) {
    final group = _navGroups[gi];
    final isExpanded = _groupExpanded[gi];
    final hasSelectedChild = _selectedGroupIndex == gi;

    return AppSidebarMenu(
      title: group.title,
      icon: group.groupIcon,
      isExpanded: isExpanded,
      hasSelectedChild: hasSelectedChild,
      onExpansionChanged: (expanded) {
        setState(() => _groupExpanded[gi] = expanded);
      },
      children: [
        for (int ii = 0; ii < group.items.length; ii++)
          _buildItemTile(context, theme, gi, ii),
      ],
    );
  }

  Widget _buildItemTile(
    BuildContext context,
    AppColorsExtension theme,
    int gi,
    int ii,
  ) {
    final item = _navGroups[gi].items[ii];
    final isSelected = _selectedGroupIndex == gi && _selectedItemIndex == ii;

    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: InkWell(
        onTap: () {
          _onSelect(gi, ii);
          if (MediaQuery.of(context).size.width < 768 &&
              Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
        borderRadius: BorderRadius.circular(6),
        child: AnimatedContainer(
          duration: AppDurations.quick,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected
                ? theme.primary.withAlpha(20)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                width: 2,
                height: 16,
                decoration: BoxDecoration(
                  color: isSelected ? theme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                item.icon,
                size: 14,
                color: isSelected ? theme.primary : theme.bodySecondaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                item.label,
                style: AppTypography.bodySm.copyWith(
                  fontWeight: isSelected
                      ? AppTypography.semiBold
                      : AppTypography.regular,
                  color: isSelected ? theme.primary : theme.bodyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// THEME TOGGLE BUTTON
// ─────────────────────────────────────────────────────────────────────────────

class _ThemeToggle extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;
  const _ThemeToggle({required this.isDark, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 52,
        height: 28,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isDark ? theme.primary : theme.borderColor,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 4),
                  ],
                ),
                child: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  size: 13,
                  color: isDark ? theme.primary : Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
