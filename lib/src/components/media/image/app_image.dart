import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';

enum AppImageFit { cover, contain, fill, scaleDown, fitWidth, fitHeight }

class AppImage extends StatelessWidget {
  const AppImage({
    required this.source, super.key,
    this.width,
    this.height,
    this.fit = AppImageFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.onTap,
    this.isAsset = false,
    this.semanticLabel,
  });

  final String source;
  final double? width;
  final double? height;
  final AppImageFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final VoidCallback? onTap;
  final bool isAsset;
  final String? semanticLabel;

  BoxFit get _fit => switch (fit) {
        AppImageFit.cover => BoxFit.cover,
        AppImageFit.contain => BoxFit.contain,
        AppImageFit.fill => BoxFit.fill,
        AppImageFit.scaleDown => BoxFit.scaleDown,
        AppImageFit.fitWidth => BoxFit.fitWidth,
        AppImageFit.fitHeight => BoxFit.fitHeight,
      };

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (isAsset) {
      image = Image.asset(
        source,
        width: width,
        height: height,
        fit: _fit,
        errorBuilder: (_, __, ___) => errorWidget ?? _placeholder(),
        semanticLabel: semanticLabel,
      );
    } else {
      image = Image.network(
        source,
        width: width,
        height: height,
        fit: _fit,
        loadingBuilder: (ctx, child, progress) =>
            progress == null ? child : (placeholder ?? _skeleton()),
        errorBuilder: (_, __, ___) => errorWidget ?? _placeholder(),
        semanticLabel: semanticLabel,
      );
    }

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return onTap != null ? GestureDetector(onTap: onTap, child: image) : image;
  }

  Widget _skeleton() => Container(
        width: width,
        height: height,
        color: AppColors.grey100,
      );

  Widget _placeholder() => Container(
        width: width,
        height: height,
        color: AppColors.grey100,
        child: const Center(
            child: Icon(Icons.image_not_supported, color: AppColors.grey300)),
      );
}
