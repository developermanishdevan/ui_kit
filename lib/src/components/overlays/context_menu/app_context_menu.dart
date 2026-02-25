import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppContextMenuItem {
  const AppContextMenuItem({
    required this.label,
    required this.onTap,
    this.icon,
    this.isDestructive = false,
    this.enabled = true,
    this.dividerAfter = false,
  });
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isDestructive;
  final bool enabled;
  final bool dividerAfter;
}

class AppContextMenu extends StatelessWidget {
  const AppContextMenu({
    required this.items,
    required this.child,
    super.key,
  });

  final List<AppContextMenuItem> items;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _show(context),
      onSecondaryTap: () => _show(context),
      child: child,
    );
  }

  void _show(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + box.size.height,
        offset.dx + box.size.width,
        offset.dy,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      items: items.expand<PopupMenuEntry>((item) {
        final tile = PopupMenuItem(
          enabled: item.enabled,
          onTap: item.onTap,
          child: Row(
            children: [
              if (item.icon != null) ...[
                Icon(item.icon,
                    size: 18,
                    color: item.isDestructive
                        ? AppColors.error
                        : item.enabled
                            ? AppColors.textPrimary
                            : AppColors.textTertiary),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(item.label,
                  style: AppTypography.bodyMedium.copyWith(
                    color: item.isDestructive
                        ? AppColors.error
                        : item.enabled
                            ? AppColors.textPrimary
                            : AppColors.textTertiary,
                  )),
            ],
          ),
        );
        return item.dividerAfter
            ? <PopupMenuEntry>[tile, const PopupMenuDivider()]
            : <PopupMenuEntry>[tile];
      }).toList(),
    );
  }
}
