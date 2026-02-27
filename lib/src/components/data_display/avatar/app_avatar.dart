import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppAvatarSize {
  static const double xs = 24.0;
  static const double sm = 32.0;
  static const double md = 48.0;
  static const double lg = 64.0;
  static const double xl = 80.0;
}

enum AppAvatarShape { square, rounded, circle }

class AppAvatar extends AppStatelessWrapper {
  final String? imageUrl;
  final Widget? child;
  final double size;
  final AppAvatarShape shape;
  final bool hasThumbnail;
  final Color? backgroundColor;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.child,
    this.size = AppAvatarSize.md,
    this.shape = AppAvatarShape.rounded,
    this.hasThumbnail = false,
    this.backgroundColor,
  });

  factory AppAvatar.xs({
    Key? key,
    String? imageUrl,
    Widget? child,
    AppAvatarShape shape = AppAvatarShape.rounded,
    bool hasThumbnail = false,
  }) => AppAvatar(
    key: key,
    imageUrl: imageUrl,
    size: AppAvatarSize.xs,
    shape: shape,
    hasThumbnail: hasThumbnail,
    child: child,
  );

  factory AppAvatar.sm({
    Key? key,
    String? imageUrl,
    Widget? child,
    AppAvatarShape shape = AppAvatarShape.rounded,
    bool hasThumbnail = false,
  }) => AppAvatar(
    key: key,
    imageUrl: imageUrl,
    size: AppAvatarSize.sm,
    shape: shape,
    hasThumbnail: hasThumbnail,
    child: child,
  );

  factory AppAvatar.md({
    Key? key,
    String? imageUrl,
    Widget? child,
    AppAvatarShape shape = AppAvatarShape.rounded,
    bool hasThumbnail = false,
  }) => AppAvatar(
    key: key,
    imageUrl: imageUrl,
    size: AppAvatarSize.md,
    shape: shape,
    hasThumbnail: hasThumbnail,
    child: child,
  );

  factory AppAvatar.lg({
    Key? key,
    String? imageUrl,
    Widget? child,
    AppAvatarShape shape = AppAvatarShape.rounded,
    bool hasThumbnail = false,
  }) => AppAvatar(
    key: key,
    imageUrl: imageUrl,
    size: AppAvatarSize.lg,
    shape: shape,
    hasThumbnail: hasThumbnail,
    child: child,
  );

  factory AppAvatar.xl({
    Key? key,
    String? imageUrl,
    Widget? child,
    AppAvatarShape shape = AppAvatarShape.rounded,
    bool hasThumbnail = false,
  }) => AppAvatar(
    key: key,
    imageUrl: imageUrl,
    size: AppAvatarSize.xl,
    shape: shape,
    hasThumbnail: hasThumbnail,
    child: child,
  );

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    BorderRadius? borderRadius;
    switch (shape) {
      case AppAvatarShape.square:
        borderRadius = BorderRadius.zero;
        break;
      case AppAvatarShape.rounded:
        borderRadius = radii.base;
        break;
      case AppAvatarShape.circle:
        borderRadius = BorderRadius.circular(size / 2);
        break;
    }

    Widget content;
    if (imageUrl != null) {
      content = Image.network(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(colors),
      );
    } else if (child != null) {
      content = SizedBox(
        width: size,
        height: size,
        child: Center(child: child),
      );
    } else {
      content = _buildPlaceholder(colors);
    }

    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.bodySecondaryBg,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(borderRadius: borderRadius, child: content),
    );

    if (hasThumbnail) {
      avatar = Container(
        padding: EdgeInsets.all(spacing.s1),
        decoration: BoxDecoration(
          color: colors.bodyBg,
          border: Border.all(color: colors.borderColor, width: 1.0),
          borderRadius: borderRadius,
        ),
        child: avatar,
      );
    }

    return AppSemantics(label: 'Avatar', image: true, child: avatar);
  }

  Widget _buildPlaceholder(AppColorsExtension colors) {
    return Icon(
      Icons.person,
      size: size * 0.6,
      color: colors.bodySecondaryColor,
    );
  }
}
