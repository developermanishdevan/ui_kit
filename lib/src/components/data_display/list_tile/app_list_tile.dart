import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A component that displays information in a consistent list tile format.
/// Adheres to the UI Kit design system for typography, spacing, and interactivity.
class AppListTile extends AppStatelessWrapper {
  /// The title of the list tile. Can be a String or a Widget.
  final dynamic title;

  /// Optional subtitle or detail text. Can be a String or a Widget.
  final dynamic subtitle;

  /// Optional widget to display before the title (e.g., an Icon or Avatar).
  final Widget? leading;

  /// Optional widget to display after the title (e.g., an Icon or Badge).
  final Widget? trailing;

  /// Called when the user taps this list tile.
  final VoidCallback? onTap;

  /// Called when the user long-presses this list tile.
  final VoidCallback? onLongPress;

  /// Whether the tile should display a selected state.
  final bool selected;

  /// Whether the tile is interactive.
  final bool enabled;

  /// Internal padding for the tile.
  final EdgeInsetsGeometry? contentPadding;

  /// Background color for the tile.
  final Color? backgroundColor;

  /// Border radius for the tile.
  final BorderRadius? borderRadius;

  /// Whether to show a divider at the bottom.
  final bool showDivider;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.enabled = true,
    this.contentPadding,
    this.backgroundColor,
    this.borderRadius,
    this.showDivider = false,
    this.semanticLabel,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final effectiveBackgroundColor = selected
        ? (backgroundColor ?? colors.primary.withAlpha(20))
        : (backgroundColor ?? Colors.transparent);

    final effectiveTitleStyle = AppTypography.bodyBase.copyWith(
      color: selected ? colors.primary : colors.textEmphasis,
      fontWeight: selected ? AppTypography.semiBold : AppTypography.medium,
    );

    final effectiveSubtitleStyle = AppTypography.bodySm.copyWith(
      color: colors.bodySecondaryColor,
    );

    Widget content = Container(
      padding:
          contentPadding ??
          EdgeInsets.symmetric(horizontal: spacing.s4, vertical: spacing.s3),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: borderRadius ?? radii.base,
      ),
      child: Row(
        children: [
          if (leading != null) ...[leading!, SizedBox(width: spacing.s3)],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText(title, effectiveTitleStyle),
                if (subtitle != null) ...[
                  SizedBox(height: spacing.s1 / 2),
                  _buildText(subtitle, effectiveSubtitleStyle),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[SizedBox(width: spacing.s3), trailing!],
        ],
      ),
    );

    if (onTap != null || onLongPress != null) {
      content = AppInteractiveWidget(
        onTap: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        disabled: !enabled,
        semanticLabel: semanticLabel ?? _getSemanticLabel(),
        child: content,
      );
    }

    if (showDivider) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [content, AppDivider(height: 1)],
      );
    }

    return content;
  }

  Widget _buildText(dynamic text, TextStyle style) {
    if (text is Widget) return text;
    return Text(
      text.toString(),
      style: style,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  String? _getSemanticLabel() {
    if (title is String) return title as String;
    return null;
  }
}
