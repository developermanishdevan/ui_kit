import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

enum AppPaginationSize { sm, md, lg }

enum AppPaginationShape { square, rounded }

class AppPagination extends AppStatelessWrapper {
  final int totalPages;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final AppPaginationSize size;
  final AppPaginationShape shape;
  final bool showArrows;
  final bool showLabels;
  final MainAxisAlignment alignment;

  const AppPagination({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageChanged,
    this.size = AppPaginationSize.md,
    this.shape = AppPaginationShape.square,
    this.showArrows = true,
    this.showLabels = true,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppSemantics(
      label: 'Pagination nav',
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: alignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showArrows)
              _buildPageItem(
                context,
                label: showLabels ? 'Previous' : null,
                icon: !showLabels ? Icons.chevron_left : null,
                onTap: currentPage > 1
                    ? () => onPageChanged(currentPage - 1)
                    : null,
                isDisabled: currentPage == 1,
                isFirst: true,
              ),
            ...List.generate(totalPages, (index) {
              final pageNum = index + 1;
              final isItemSelected = pageNum == currentPage;
              return _buildPageItem(
                context,
                label: pageNum.toString(),
                isActive: isItemSelected,
                onTap: () => onPageChanged(pageNum),
                isFirst: !showArrows && index == 0,
                isLast: !showArrows && index == totalPages - 1,
              );
            }),
            if (showArrows)
              _buildPageItem(
                context,
                label: showLabels ? 'Next' : null,
                icon: !showLabels ? Icons.chevron_right : null,
                onTap: currentPage < totalPages
                    ? () => onPageChanged(currentPage + 1)
                    : null,
                isDisabled: currentPage == totalPages,
                isLast: true,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageItem(
    BuildContext context, {
    String? label,
    IconData? icon,
    bool isActive = false,
    bool isDisabled = false,
    VoidCallback? onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    EdgeInsetsGeometry padding;
    TextStyle textStyle;
    double minWidth;
    double iconSize;

    switch (size) {
      case AppPaginationSize.sm:
        padding = EdgeInsets.symmetric(
          horizontal: spacing.s1,
          vertical: spacing.s1,
        );
        textStyle = typography.bodySm;
        minWidth = 32;
        iconSize = 14;
        break;
      case AppPaginationSize.lg:
        padding = EdgeInsets.symmetric(
          horizontal: spacing.s3,
          vertical: spacing.s2,
        );
        textStyle = typography.bodyLg;
        minWidth = 48;
        iconSize = 22;
        break;
      case AppPaginationSize.md:
        padding = EdgeInsets.symmetric(
          horizontal: spacing.s2,
          vertical: spacing.s1,
        );
        textStyle = typography.bodyBase;
        minWidth = 40;
        iconSize = 18;
        break;
    }

    final isRounded = shape == AppPaginationShape.rounded;

    // Background color
    Color bgColor = Colors.transparent;
    if (isActive) {
      bgColor = colors.primary;
    }

    // Border Radius
    BorderRadius borderRadius = BorderRadius.zero;
    if (isRounded) {
      borderRadius = radii.base;
    } else {
      if (isFirst) {
        borderRadius = BorderRadius.only(
          topLeft: radii.base.topLeft,
          bottomLeft: radii.base.bottomLeft,
        );
      } else if (isLast) {
        borderRadius = BorderRadius.only(
          topRight: radii.base.topRight,
          bottomRight: radii.base.bottomRight,
        );
      }
    }

    // Border Logic
    Border border;
    if (isRounded) {
      border = Border.all(color: colors.borderColor);
    } else {
      border = Border(
        top: BorderSide(color: colors.borderColor),
        bottom: BorderSide(color: colors.borderColor),
        right: BorderSide(color: colors.borderColor),
        left: isFirst ? BorderSide(color: colors.borderColor) : BorderSide.none,
      );
    }

    return AppInteractiveWidget(
      onTap: isDisabled ? null : onTap,
      disabled: isDisabled,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          border: isActive ? Border.all(color: colors.primary) : border,
          borderRadius: borderRadius,
        ),
        constraints: BoxConstraints(minWidth: minWidth),
        alignment: Alignment.center,
        margin: isRounded
            ? EdgeInsets.symmetric(horizontal: spacing.s1 / 2)
            : EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: iconSize,
                color: _getTextColor(
                  colors,
                  isActive,
                  isDisabled,
                  label == null,
                ),
              ),
            if (label != null)
              Text(
                label,
                style: textStyle.copyWith(
                  height: 1.2,
                  fontWeight: isActive
                      ? AppTypography.bold
                      : AppTypography.regular,
                  color: _getTextColor(
                    colors,
                    isActive,
                    isDisabled,
                    int.tryParse(label) != null,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getTextColor(
    AppColorsExtension colors,
    bool isActive,
    bool isDisabled,
    bool isNumber,
  ) {
    if (isDisabled) return colors.bodySecondaryColor.withValues(alpha: 0.5);
    if (isActive) return Colors.white;
    return isNumber ? colors.bodyColor : colors.primary;
  }
}
