import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppAvatarGroup extends AppStatelessWrapper {
  final List<AppAvatar> avatars;
  final int max;
  final double overlap;

  const AppAvatarGroup({
    super.key,
    required this.avatars,
    this.max = 5,
    this.overlap = 0.3,
  });

  @override
  Widget buildWidget(BuildContext context) {
    if (avatars.isEmpty) return const SizedBox.shrink();

    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    int count = avatars.length;
    bool hasOverflow = false;
    int showCount = count;
    int overflowCount = 0;

    if (count > max) {
      hasOverflow = true;
      showCount = max;
      overflowCount = count - max;
    }

    final baseSize = avatars.first.size;
    final shape = avatars.first.shape;
    final avatarSize = baseSize + 4.0; // border stroke 2px on each side

    final overlapAmount = baseSize * overlap;
    final stepDistance = avatarSize - overlapAmount;

    final totalElements = showCount + (hasOverflow ? 1 : 0);
    final totalWidth = (totalElements - 1) * stepDistance + avatarSize;

    final List<Widget> children = [];

    // Add overflow marker (rendered underneath, added first so it's lower in Stack)
    if (hasOverflow) {
      children.add(
        Positioned(
          left: showCount * stepDistance,
          child: _buildOverflowAvatar(
            overflowCount,
            baseSize,
            shape,
            colors,
            typography,
            radii,
          ),
        ),
      );
    }

    // Add avatars. We iterate backwards so the first item ends up at the end of the list and paints ON TOP.
    for (int i = showCount - 1; i >= 0; i--) {
      final avatar = avatars[i];
      children.add(
        Positioned(
          left: i * stepDistance,
          child: _buildAvatarWithGroupBorder(avatar, colors, radii),
        ),
      );
    }

    return AppSemantics(
      label: 'Avatar Group with $count members',
      child: SizedBox(
        width: totalWidth,
        height: avatarSize,
        child: Stack(clipBehavior: Clip.none, children: children),
      ),
    );
  }

  Widget _buildAvatarWithGroupBorder(
    AppAvatar avatar,
    AppColorsExtension colors,
    AppRadiusExtension radii,
  ) {
    return Container(
      width: avatar.size + 4.0,
      height: avatar.size + 4.0,
      decoration: BoxDecoration(
        color: colors.bodyBg,
        shape: avatar.shape == AppAvatarShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        borderRadius: avatar.shape != AppAvatarShape.circle
            ? _getBorderRadiusFromShape(avatar.shape, avatar.size + 4.0, radii)
            : null,
      ),
      child: Center(child: avatar),
    );
  }

  Widget _buildOverflowAvatar(
    int count,
    double size,
    AppAvatarShape shape,
    AppColorsExtension colors,
    AppTypographyExtension typography,
    AppRadiusExtension radii,
  ) {
    return Container(
      width: size + 4.0,
      height: size + 4.0,
      decoration: BoxDecoration(
        color: colors.bodyBg,
        shape: shape == AppAvatarShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        borderRadius: shape != AppAvatarShape.circle
            ? _getBorderRadiusFromShape(shape, size + 4.0, radii)
            : null,
      ),
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: colors.bodySecondaryBg,
            shape: shape == AppAvatarShape.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
            borderRadius: shape != AppAvatarShape.circle
                ? _getBorderRadiusFromShape(shape, size, radii)
                : null,
          ),
          child: Center(
            child: Text(
              '+$count',
              style: typography.bodySm.copyWith(
                fontWeight: AppTypography.semiBold,
                color: colors.bodyColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _getBorderRadiusFromShape(
    AppAvatarShape shape,
    double size,
    AppRadiusExtension radii,
  ) {
    switch (shape) {
      case AppAvatarShape.square:
        return BorderRadius.zero;
      case AppAvatarShape.rounded:
        return radii.base;
      case AppAvatarShape.circle:
        return BorderRadius.circular(size / 2);
    }
  }
}
