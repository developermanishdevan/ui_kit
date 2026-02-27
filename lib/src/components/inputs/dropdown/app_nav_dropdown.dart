import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

abstract class AppDropdownComponent {
  const AppDropdownComponent();
}

class AppDropdownItem extends AppDropdownComponent {
  final String label;
  final VoidCallback? onTap;

  const AppDropdownItem({required this.label, this.onTap});
}

class AppDropdownHeader extends AppDropdownComponent {
  final String label;

  const AppDropdownHeader({required this.label});
}

class AppDropdownDivider extends AppDropdownComponent {
  const AppDropdownDivider();
}

class AppDropdownMenu extends AppStatelessWrapper {
  final Widget toggle;
  final List<AppDropdownComponent> items;
  final bool isDark;

  const AppDropdownMenu({
    super.key,
    required this.toggle,
    required this.items,
    this.isDark = false,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final radius = Theme.of(context).extension<AppRadiusExtension>()!;

    final bgColor = isDark ? theme.dark : theme.bodyBg;
    final textColor = isDark ? Colors.white : theme.textEmphasis;
    final headerColor = isDark ? Colors.white70 : theme.bodySecondaryColor;
    final dividerColor = isDark ? Colors.white12 : theme.borderColor;
    final hoverColor = isDark ? Colors.white10 : theme.bodySecondaryBg;

    return MenuAnchor(
      builder: (context, controller, child) {
        return InkWell(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          mouseCursor: SystemMouseCursors.click,
          borderRadius: radius.base,
          child: IgnorePointer(child: toggle),
        );
      },
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(bgColor),
        elevation: WidgetStatePropertyAll(8),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: radius.base,
            side: BorderSide(
              color: isDark ? Colors.transparent : theme.borderColor,
            ),
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: AppSpacing.s2),
        ),
      ),
      menuChildren: items.map((component) {
        if (component is AppDropdownHeader) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s3,
              vertical: AppSpacing.s2,
            ),
            child: Text(
              component.label,
              style: typography.bodyXs.copyWith(
                fontWeight: AppTypography.semiBold,
                color: headerColor,
                letterSpacing: 0.5,
              ),
            ),
          );
        } else if (component is AppDropdownDivider) {
          return Divider(
            height: AppSpacing.s2 * 2,
            thickness: 1,
            color: dividerColor,
          );
        } else if (component is AppDropdownItem) {
          return MenuItemButton(
            onPressed: component.onTap ?? () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return hoverColor;
                }
                return Colors.transparent;
              }),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: AppSpacing.s3,
                  vertical: AppSpacing.s2,
                ),
              ),
              minimumSize: const WidgetStatePropertyAll(Size(120, 0)),
            ),
            child: Text(
              component.label,
              style: typography.bodySm.copyWith(color: textColor),
            ),
          );
        }
        return const SizedBox.shrink();
      }).toList(),
    );
  }
}
