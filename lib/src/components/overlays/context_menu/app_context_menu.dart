import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppContextMenuEntry<T> {
  final T value;
  final String label;
  final IconData? icon;
  final bool isDestructive;

  const AppContextMenuEntry({
    required this.value,
    required this.label,
    this.icon,
    this.isDestructive = false,
  });
}

class AppContextMenu<T> extends AppStatelessWrapper {
  final Widget child;
  final List<AppContextMenuEntry<T>> items;
  final ValueChanged<T> onSelected;
  final Offset? offset;

  const AppContextMenu({
    super.key,
    required this.child,
    required this.items,
    required this.onSelected,
    this.offset,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return PopupMenuButton<T>(
      onSelected: onSelected,
      color: theme.bodyBg,
      shape: RoundedRectangleBorder(
        borderRadius: radii.base,
        side: BorderSide(color: theme.borderColorTranslucent, width: 1),
      ),
      elevation: 8,
      offset: offset ?? const Offset(0, 0),
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem<T>(
            value: item.value,
            textStyle: typography.bodySm.copyWith(
              color: item.isDestructive ? theme.danger : theme.textEmphasis,
            ),
            child: Row(
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    size: 16,
                    color: item.isDestructive
                        ? theme.danger
                        : theme.bodySecondaryColor,
                  ),
                  const SizedBox(width: AppSpacing.s2),
                ],
                Text(item.label),
              ],
            ),
          );
        }).toList();
      },
      child: child,
    );
  }
}
