import 'package:flutter/material.dart';
import '../avatar/app_avatar.dart';
import '../../../foundation/tokens/colors/app_colors.dart';
import '../../../foundation/tokens/typography/app_typography.dart';

class AppAvatarGroup extends StatelessWidget {
  const AppAvatarGroup({
    required this.avatars, super.key,
    this.maxVisible = 4,
    this.overlap = 16.0,
    this.size = AppAvatarSize.md,
    this.borderColor = AppColors.white,
    this.borderWidth = 2.0,
  });

  final List<AppAvatar> avatars;
  final int maxVisible;
  final double overlap;
  final AppAvatarSize size;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final visibleCount =
        avatars.length > maxVisible ? maxVisible : avatars.length;
    final extraCount = avatars.length - visibleCount;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < visibleCount; i++)
          Transform.translate(
            offset: Offset(-i * overlap, 0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: borderWidth),
              ),
              child: avatars[i],
            ),
          ),
        if (extraCount > 0)
          Transform.translate(
            offset: Offset(-visibleCount * overlap, 0),
            child: Container(
              width: size.size,
              height: size.size,
              decoration: BoxDecoration(
                color: AppColors.grey200,
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: borderWidth),
              ),
              child: Center(
                child: Text('+$extraCount',
                    style: AppTypography.labelSmall.copyWith(
                      fontWeight: AppTypography.weightBold,
                    )),
              ),
            ),
          ),
      ],
    );
  }
}
