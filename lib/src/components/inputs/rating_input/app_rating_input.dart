import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Rating input field.
class AppRatingInput extends AppStatefulWrapper {
  final double initialRating;
  final int count;
  final ValueChanged<double>? onRatingChanged;
  final Color? color;
  final double size;
  final bool enabled;
  final String? labelText;

  const AppRatingInput({
    super.key,
    this.initialRating = 0,
    this.count = 5,
    this.onRatingChanged,
    this.color,
    this.size = 32,
    this.enabled = true,
    this.labelText,
  });

  @override
  State<AppRatingInput> createState() => _AppRatingInputState();
}

class _AppRatingInputState extends AppStatefulWrapperState<AppRatingInput> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final ratingColor = widget.color ?? Colors.amber;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: typography.bodyBase.copyWith(
              fontWeight: AppTypography.medium,
              color: colors.textEmphasis,
            ),
          ),
          SizedBox(height: spacing.s1),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.count, (index) {
            final starIndex = index + 1;
            final isFull = starIndex <= _currentRating;
            final isHalf =
                starIndex > _currentRating && starIndex - 0.5 <= _currentRating;

            return GestureDetector(
              onTap: widget.enabled
                  ? () {
                      setState(() {
                        _currentRating = starIndex.toDouble();
                      });
                      if (widget.onRatingChanged != null) {
                        widget.onRatingChanged!(_currentRating);
                      }
                    }
                  : null,
              child: Padding(
                padding: EdgeInsets.only(right: spacing.s1),
                child: Icon(
                  isFull
                      ? Icons.star
                      : isHalf
                      ? Icons.star_half
                      : Icons.star_border,
                  color: widget.enabled
                      ? ratingColor
                      : ratingColor.withValues(alpha: 0.5),
                  size: widget.size,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
