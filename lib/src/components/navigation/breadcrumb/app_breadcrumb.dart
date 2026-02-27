import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

class AppBreadcrumbItem {
  final String label;
  final VoidCallback? onTap;
  final bool isActive;
  final Widget? icon;

  const AppBreadcrumbItem({
    required this.label,
    this.onTap,
    this.isActive = false,
    this.icon,
  });
}

class AppBreadcrumb extends AppStatelessWrapper {
  final List<AppBreadcrumbItem> items;
  final Widget? separator;

  const AppBreadcrumb({super.key, required this.items, this.separator});

  @override
  Widget buildWidget(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final defaultSeparator = Icon(
      Icons.chevron_right,
      size: 16,
      color: theme.bodySecondaryColor,
    );

    List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final bool isLast = i == items.length - 1;

      children.add(_BreadcrumbLink(item: item, theme: theme));

      if (!isLast) {
        children.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: separator ?? defaultSeparator,
          ),
        );
      }
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }
}

class _BreadcrumbLink extends AppStatefulWrapper {
  final AppBreadcrumbItem item;
  final AppColorsExtension theme;

  const _BreadcrumbLink({required this.item, required this.theme});

  @override
  State<_BreadcrumbLink> createState() => _BreadcrumbLinkState();
}

class _BreadcrumbLinkState extends AppStatefulWrapperState<_BreadcrumbLink> {
  bool _isHovered = false;

  @override
  Widget buildWidget(BuildContext context) {
    final isInteractive = widget.item.onTap != null && !widget.item.isActive;

    Color textColor;
    if (widget.item.isActive) {
      textColor = widget.theme.bodySecondaryColor;
    } else if (_isHovered) {
      textColor = widget.theme.primary;
    } else {
      textColor = widget.theme.bodyColor;
    }

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.item.icon != null) ...[
          widget.item.icon!,
          const SizedBox(width: 4),
        ],
        Text(
          widget.item.label,
          style: Theme.of(context)
              .extension<AppTypographyExtension>()!
              .bodySm
              .copyWith(
                color: textColor,
                fontWeight: widget.item.isActive
                    ? AppTypography.medium
                    : AppTypography.regular,
              ),
        ),
      ],
    );

    if (isInteractive) {
      return AppInteractiveWidget(
        onHover: (isHovered) => setState(() => _isHovered = isHovered),
        onTap: widget.item.onTap,
        showHoverEffect: false,
        child: content,
      );
    }

    return content;
  }
}
