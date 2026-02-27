import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A component that displays a key-value pair in a row layout.
/// Commonly used for details pages, settings, or information summaries.
class AppKeyValueRow extends AppStatelessWrapper {
  /// The key/label of the row.
  final dynamic label;

  /// The value associated with the key.
  final dynamic value;

  /// Optional icon or widget to show before the label.
  final Widget? leading;

  /// Optional widget to show after the value.
  final Widget? trailing;

  /// Whether the label should be emphasized (bold).
  final bool emphasizeLabel;

  /// Custom padding for the row.
  final EdgeInsetsGeometry? padding;

  /// Whether to show a divider at the bottom of the row.
  final bool showDivider;

  /// Alignment of the row contents.
  final CrossAxisAlignment crossAxisAlignment;

  /// Space between label and value.
  final double? spacing;

  const AppKeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.leading,
    this.trailing,
    this.emphasizeLabel = true,
    this.padding,
    this.showDivider = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final appSpacing = context.theme.extension<AppSpacingExtension>()!;

    return AppSemantics(
      label: 'Key Value Pair',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: padding ?? EdgeInsets.symmetric(vertical: appSpacing.s3),
            child: Row(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: appSpacing.s2),
                ],
                Expanded(
                  flex: 2,
                  child: _buildItem(
                    label,
                    typography.bodyBase.copyWith(
                      color: colors.bodySecondaryColor,
                      fontWeight: emphasizeLabel
                          ? AppTypography.semiBold
                          : AppTypography.regular,
                    ),
                  ),
                ),
                SizedBox(width: spacing ?? appSpacing.s4),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: _buildItem(
                          value,
                          typography.bodyBase.copyWith(
                            color: colors.textEmphasis,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      if (trailing != null) ...[
                        SizedBox(width: appSpacing.s2),
                        trailing!,
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showDivider) AppDivider(height: 1),
        ],
      ),
    );
  }

  Widget _buildItem(dynamic item, TextStyle style, {TextAlign? textAlign}) {
    if (item is Widget) return item;
    return Text(item.toString(), style: style, textAlign: textAlign);
  }
}
