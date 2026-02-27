import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppBottomNavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final int? badgeCount;

  const AppBottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.badgeCount,
  });
}

class AppBottomNav extends AppStatelessWrapper {
  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int>? onChanged;

  const AppBottomNav({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onChanged,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Container(
      decoration: BoxDecoration(
        color: theme.bodyBg,
        border: Border(top: BorderSide(color: theme.borderColor, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.s3,
          vertical: spacing.s2,
        ),
        child: Row(
          mainAxisAlignment: items.length <= 3
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = currentIndex == index;
            final color = isSelected ? theme.primary : theme.bodySecondaryColor;

            return AppSemantics(
              label: item.label,
              selected: isSelected,
              child: GestureDetector(
                onTap: () => onChanged?.call(index),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.s2,
                    vertical: spacing.s1,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AppAnimatedSwitcher(
                            child: Icon(
                              isSelected
                                  ? (item.activeIcon ?? item.icon)
                                  : item.icon,
                              key: ValueKey(isSelected),
                              color: color,
                              size: 24,
                            ),
                          ),
                          if (item.badgeCount != null)
                            Positioned(
                              top: -4,
                              right: -8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.danger,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  item.badgeCount! > 99
                                      ? '99+'
                                      : item.badgeCount.toString(),
                                  style: typography.bodyXs.copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: AppTypography.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: spacing.s1),
                      Text(
                        item.label,
                        style: typography.bodyXs.copyWith(
                          color: color,
                          fontWeight: isSelected
                              ? AppTypography.semiBold
                              : AppTypography.medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
