import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';
import 'package:ui_kit/src/foundation/tokens/icon_sizes/app_icon_sizes.dart';

class AppRatingInput extends StatelessWidget {
  const AppRatingInput({
    required this.rating,
    required this.onChanged,
    super.key,
    this.maxRating = 5,
    this.iconSize = AppIconSizes.lg,
    this.activeColor = AppColors.amber500,
    this.inactiveColor = AppColors.grey200,
    this.spacing = AppSpacing.xs,
    this.allowHalfRating = false,
    this.readOnly = false,
  });

  final double rating;
  final ValueChanged<double>? onChanged;
  final int maxRating;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final double spacing;
  final bool allowHalfRating;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (i) {
        final starValue = i + 1.0;
        final isActive = rating >= starValue;
        final isHalf =
            allowHalfRating && rating >= starValue - 0.5 && rating < starValue;

        return Padding(
          padding: EdgeInsets.only(right: i < maxRating - 1 ? spacing : 0),
          child: GestureDetector(
            onTap: readOnly ? null : () => onChanged?.call(starValue),
            child: Icon(
              isActive
                  ? Icons.star
                  : isHalf
                      ? Icons.star_half
                      : Icons.star_border,
              size: iconSize,
              color: (isActive || isHalf) ? activeColor : inactiveColor,
            ),
          ),
        );
      }),
    );
  }
}
