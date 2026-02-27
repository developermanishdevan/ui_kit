import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium App Top Bar (AppBar) component.
class AppTopBar extends AppStatelessWrapper implements PreferredSizeWidget {
  final String? titleText;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  const AppTopBar({
    super.key,
    this.titleText,
    this.titleWidget,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.bottom,
    this.backgroundColor,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;

    Widget? activeTitle = titleWidget;
    if (titleText != null) {
      activeTitle = Text(
        titleText!,
        style: typography.h6.copyWith(
          color: theme.textEmphasis,
          fontWeight: AppTypography.semiBold,
        ),
      );
    }

    return AppBar(
      title: activeTitle,
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? theme.bodyBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: theme.textEmphasis),
      bottom: bottom,
      shape: Border(bottom: BorderSide(color: theme.borderColor, width: 1)),
    );
  }
}
