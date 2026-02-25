import 'package:flutter/material.dart';
import '../../foundation/tokens/colors/app_colors.dart';
import '../../foundation/tokens/typography/app_typography.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.bottom,
    this.showBackButton = true,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final bool showBackButton;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return AppBar(
      title: titleWidget ??
          (title != null
              ? Text(title!,
                  style: AppTypography.titleLarge.copyWith(
                    color: foregroundColor ?? AppColors.textPrimary,
                  ))
              : null),
      leading: leading ??
          (showBackButton && canPop
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null),
      automaticallyImplyLeading: showBackButton,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      foregroundColor: foregroundColor ?? AppColors.textPrimary,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      bottom: bottom,
    );
  }
}

/// Transparent app bar for hero/image headers
class AppTransparentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AppTransparentAppBar({
    super.key,
    this.actions,
    this.foregroundColor = AppColors.white,
  });

  final List<Widget>? actions;
  final Color foregroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: foregroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: actions,
    );
  }
}
