import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// Defines the position of the content relative to the timeline line.
enum AppTimelinePosition { left, right, alternate }

/// Defines the variant of the timeline indicator.
enum AppTimelineVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

/// A class representing a single event or point in an [AppTimeline].
class AppTimelineItem {
  /// The main label or title for this item.
  final Widget title;

  /// Optional secondary text or subtitle.
  final Widget? subtitle;

  /// Optional timestamp or date to display.
  final Widget? timestamp;

  /// Custom widget for the indicator. If null, a default dot is used.
  final Widget? indicator;

  /// The color variant for the indicator.
  final AppTimelineVariant variant;

  /// Optional custom content to display below title/subtitle.
  final Widget? content;

  /// Whether this item is considered "active" or "current".
  final bool isActive;

  const AppTimelineItem({
    required this.title,
    this.subtitle,
    this.timestamp,
    this.indicator,
    this.variant = AppTimelineVariant.primary,
    this.content,
    this.isActive = false,
  });
}

/// A premium Timeline component for displaying chronological events or processes.
/// Following the UI Kit design system with tokenized spacing, colors, and typography.
class AppTimeline extends AppStatelessWrapper {
  /// The list of items to display in the timeline.
  final List<AppTimelineItem> items;

  /// The position of the timeline line and indicators.
  final AppTimelinePosition position;

  /// Whether the timeline is displayed vertically or horizontally.
  final Axis axis;

  /// Whether to show the line connecting the items.
  final bool showLine;

  const AppTimeline({
    super.key,
    required this.items,
    this.position = AppTimelinePosition.right,
    this.axis = Axis.vertical,
    this.showLine = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    if (axis == Axis.horizontal) {
      return _buildHorizontalTimeline(context);
    }
    return _buildVerticalTimeline(context);
  }

  Widget _buildVerticalTimeline(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(items.length, (index) {
        return _buildVerticalItem(context, index);
      }),
    );
  }

  Widget _buildVerticalItem(BuildContext context, int index) {
    final item = items[index];
    final isLast = index == items.length - 1;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    Widget indicator = _buildIndicator(context, item);
    Widget content = _buildItemContent(context, item);
    Widget? timestamp = item.timestamp != null
        ? _buildTimestamp(context, item)
        : null;

    if (position == AppTimelinePosition.alternate) {
      final isEven = index % 2 == 0;
      return IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: spacing.s3,
                  bottom: isLast ? 0 : spacing.s4,
                ),
                child: isEven
                    ? content
                    : Align(alignment: Alignment.centerRight, child: timestamp),
              ),
            ),
            _buildIndicatorColumn(context, indicator, isLast, item),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: spacing.s3,
                  bottom: isLast ? 0 : spacing.s4,
                ),
                child: isEven
                    ? (timestamp != null
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: timestamp,
                            )
                          : const SizedBox())
                    : content,
              ),
            ),
          ],
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (position == AppTimelinePosition.left) ...[
            if (timestamp != null)
              SizedBox(
                width: 80,
                child: Padding(
                  padding: EdgeInsets.only(right: spacing.s3),
                  child: timestamp,
                ),
              ),
            _buildIndicatorColumn(context, indicator, isLast, item),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: spacing.s3,
                  bottom: isLast ? 0 : spacing.s4,
                ),
                child: content,
              ),
            ),
          ] else ...[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: spacing.s3,
                  bottom: isLast ? 0 : spacing.s4,
                ),
                child: content,
              ),
            ),
            _buildIndicatorColumn(context, indicator, isLast, item),
            if (timestamp != null)
              SizedBox(
                width: 80,
                child: Padding(
                  padding: EdgeInsets.only(left: spacing.s3),
                  child: timestamp,
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildIndicatorColumn(
    BuildContext context,
    Widget indicator,
    bool isLast,
    AppTimelineItem item,
  ) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Column(
      children: [
        indicator,
        if (!isLast && showLine)
          Expanded(
            child: Container(
              width: 2,
              margin: EdgeInsets.symmetric(vertical: spacing.s1),
              decoration: BoxDecoration(
                color: colors.borderColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildIndicator(BuildContext context, AppTimelineItem item) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    if (item.indicator != null) return item.indicator!;

    final color = _getVariantColor(colors, item.variant);

    return Container(
      width: spacing.s2,
      height: spacing.s2,
      margin: EdgeInsets.only(
        top: spacing.s1 / 1.5,
      ), // Precise alignment with text cap-height
      decoration: BoxDecoration(
        color: item.isActive ? color : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
        boxShadow: item.isActive
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
    );
  }

  Widget _buildItemContent(BuildContext context, AppTimelineItem item) {
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Column(
      crossAxisAlignment: position == AppTimelinePosition.left
          ? CrossAxisAlignment.start
          : (position == AppTimelinePosition.right
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start),
      children: [
        DefaultTextStyle(
          style: typography.bodyBase.copyWith(
            fontWeight: item.isActive
                ? AppTypography.bold
                : AppTypography.semiBold,
            color: colors.textEmphasis,
          ),
          child: item.title,
        ),
        if (item.subtitle != null) ...[
          SizedBox(height: spacing.s1 / 2),
          DefaultTextStyle(
            style: typography.bodySm.copyWith(color: colors.bodySecondaryColor),
            child: item.subtitle!,
          ),
        ],
        if (item.content != null) ...[
          SizedBox(height: spacing.s2),
          item.content!,
        ],
      ],
    );
  }

  Widget _buildTimestamp(BuildContext context, AppTimelineItem item) {
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final colors = context.theme.extension<AppColorsExtension>()!;

    return DefaultTextStyle(
      style: typography.bodyXs.copyWith(
        color: colors.bodySecondaryColor,
        fontWeight: AppTypography.medium,
      ),
      child: item.timestamp!,
    );
  }

  Widget _buildHorizontalTimeline(BuildContext context) {
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;

          return SizedBox(
            width: 160,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildIndicator(context, item),
                    if (!isLast && showLine)
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: EdgeInsets.symmetric(horizontal: spacing.s1),
                          color: context.theme
                              .extension<AppColorsExtension>()!
                              .borderColor,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spacing.s3),
                Padding(
                  padding: EdgeInsets.only(right: spacing.s3),
                  child: _buildItemContent(context, item),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Color _getVariantColor(AppColorsExtension colors, AppTimelineVariant v) {
    switch (v) {
      case AppTimelineVariant.primary:
        return colors.primary;
      case AppTimelineVariant.secondary:
        return colors.secondary;
      case AppTimelineVariant.success:
        return colors.success;
      case AppTimelineVariant.danger:
        return colors.danger;
      case AppTimelineVariant.warning:
        return colors.warning;
      case AppTimelineVariant.info:
        return colors.info;
      case AppTimelineVariant.light:
        return colors.light;
      case AppTimelineVariant.dark:
        return colors.dark;
    }
  }
}
