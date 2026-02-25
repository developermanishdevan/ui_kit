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
    required this.items, super.key,
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
                  final isActive =
                      activeRoute != null && activeRoute == item.route;
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
                color: isActive ? cs.primary : AppColors.textPrimary,
                fontWeight: isActive
                    ? AppTypography.weightSemiBold
                    : AppTypography.weightRegular,
              ),
            ),
            trailing:
                item.badge != null ? Badge(label: Text(item.badge!)) : null,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
