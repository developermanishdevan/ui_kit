import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A class representing a segment of rich text with its own styling and interaction.
class AppRichSpan {
  /// The text content of the span.
  final String text;

  /// Optional custom style for this span. If provided, it overrides default styles.
  final TextStyle? style;

  /// Optional callback when this span is tapped.
  final VoidCallback? onTap;

  /// Optional color for this span.
  final Color? color;

  /// Whether this span should be bold.
  final bool isBold;

  /// Whether this span should be italic.
  final bool isItalic;

  /// Whether this span should be underlined.
  final bool isUnderlined;

  const AppRichSpan({
    required this.text,
    this.style,
    this.onTap,
    this.color,
    this.isBold = false,
    this.isItalic = false,
    this.isUnderlined = false,
  });
}

/// A component that displays rich text with multiple styles and interactive spans.
/// Adheres to the UI Kit's typography and color tokens.
class AppRichText extends AppStatelessWrapper {
  /// The list of text spans to display.
  final List<AppRichSpan> spans;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// An optional maximum number of lines for the text to span.
  final int? maxLines;

  /// The base style for the text. Defaults to bodyBase.
  final TextStyle? baseStyle;

  const AppRichText({
    super.key,
    required this.spans,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.maxLines,
    this.baseStyle,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;

    final defaultBaseStyle =
        baseStyle ?? typography.bodyBase.copyWith(color: colors.bodyColor);

    return AppSemantics(
      label: 'Rich Text',
      child: RichText(
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        text: TextSpan(
          style: defaultBaseStyle,
          children: spans.map((span) {
            TextStyle spanStyle = span.style ?? defaultBaseStyle;

            if (span.color != null) {
              spanStyle = spanStyle.copyWith(color: span.color);
            }
            if (span.isBold) {
              spanStyle = spanStyle.copyWith(fontWeight: AppTypography.bold);
            }
            if (span.isItalic) {
              spanStyle = spanStyle.copyWith(fontStyle: FontStyle.italic);
            }
            if (span.isUnderlined) {
              spanStyle = spanStyle.copyWith(
                decoration: TextDecoration.underline,
              );
            }
            if (span.onTap != null && span.color == null) {
              // Default link color if not specified
              spanStyle = spanStyle.copyWith(color: colors.primary);
            }

            return TextSpan(
              text: span.text,
              style: spanStyle,
              recognizer: span.onTap != null
                  ? (TapGestureRecognizer()..onTap = span.onTap)
                  : null,
            );
          }).toList(),
        ),
      ),
    );
  }
}
