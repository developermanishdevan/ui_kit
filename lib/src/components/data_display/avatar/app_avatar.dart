import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';

enum AppAvatarSize { xs, sm, md, lg, xl }

extension AppAvatarSizeX on AppAvatarSize {
  double get size => switch (this) {
        AppAvatarSize.xs => 24,
        AppAvatarSize.sm => 32,
        AppAvatarSize.md => 40,
        AppAvatarSize.lg => 56,
        AppAvatarSize.xl => 80,
      };
  double get fontSize => switch (this) {
        AppAvatarSize.xs => 10,
        AppAvatarSize.sm => 12,
        AppAvatarSize.md => 16,
        AppAvatarSize.lg => 20,
        AppAvatarSize.xl => 28,
      };
}

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.size = AppAvatarSize.md,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.showBadge = false,
    this.badgeColor,
    this.shape = BoxShape.circle,
  });

  final String? imageUrl;
  final String? initials;
  final IconData? icon;
  final AppAvatarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;
  final bool showBadge;
  final Color? badgeColor;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final s = size.size;
    final bg = backgroundColor ?? AppColors.primaryLight;
    final fg = foregroundColor ?? AppColors.primary;

    Widget content;
    if (imageUrl != null) {
      content = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _initials(fg, bg),
        loadingBuilder: (ctx, child, progress) => progress == null
            ? child
            : const CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (initials != null) {
      content = _initials(fg, bg);
    } else {
      content = Icon(icon ?? Icons.person, size: s * 0.5, color: fg);
    }

    Widget avatar = Container(
      width: s,
      height: s,
      decoration: BoxDecoration(
        color: imageUrl == null ? bg : null,
        shape: shape,
        borderRadius:
            shape == BoxShape.rectangle ? BorderRadius.circular(s * 0.2) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );

    if (showBadge) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: s * 0.28,
              height: s * 0.28,
              decoration: BoxDecoration(
                color: badgeColor ?? AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
            ),
          ),
        ],
      );
    }

    return onTap != null
        ? GestureDetector(onTap: onTap, child: avatar)
        : avatar;
  }

  Widget _initials(Color fg, Color bg) => Center(
        child: Text(
          initials!.substring(0, initials!.length.clamp(0, 2)).toUpperCase(),
          style: AppTypography.labelMedium.copyWith(
            fontSize: size.fontSize,
            color: fg,
            fontWeight: AppTypography.weightBold,
          ),
        ),
      );
}
