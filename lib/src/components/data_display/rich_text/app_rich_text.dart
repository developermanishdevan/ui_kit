import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';

class AppRichTextItem {
  const AppRichTextItem({
    required this.text,
    this.style,
    this.onTap,
  });

  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;
}

class AppRichText extends StatelessWidget {
  const AppRichText({
    required this.items, super.key,
    this.baseStyle,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.maxLines,
  });

  final List<AppRichTextItem> items;
  final TextStyle? baseStyle;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      text: TextSpan(
        style: baseStyle ?? AppTypography.bodyMedium,
        children: items
            .map((item) => TextSpan(
                  text: item.text,
                  style: item.style,
                  recognizer: item.onTap != null
                      ? (TapGestureRecognizer()..onTap = item.onTap)
                      : null,
                ))
            .toList(),
      ),
    );
  }
}
