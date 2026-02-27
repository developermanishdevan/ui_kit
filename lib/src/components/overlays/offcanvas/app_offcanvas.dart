import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

enum AppOffcanvasPlacement { top, bottom, start, end }

class AppOffcanvas extends AppStatelessWrapper {
  final String? title;
  final Widget content;
  final AppOffcanvasPlacement placement;
  final bool showCloseButton;
  final double? size; // Width for start/end, Height for top/bottom
  final BorderRadius? borderRadius;
  final bool isRounded;

  const AppOffcanvas({
    super.key,
    this.title,
    required this.content,
    this.placement = AppOffcanvasPlacement.start,
    this.showCloseButton = true,
    this.size,
    this.borderRadius,
    this.isRounded = false,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget content,
    String? title,
    AppOffcanvasPlacement placement = AppOffcanvasPlacement.start,
    bool showCloseButton = true,
    double? size,
    BorderRadius? borderRadius,
    bool isRounded = false,
    bool dismissible = true,
  }) {
    if (placement == AppOffcanvasPlacement.bottom) {
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: dismissible,
        builder: (context) => AppOffcanvas(
          title: title,
          content: content,
          placement: placement,
          showCloseButton: showCloseButton,
          size: size,
          borderRadius: borderRadius,
          isRounded: isRounded,
        ),
      );
    }

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      barrierLabel: 'Offcanvas',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AppOffcanvas(
          title: title,
          content: content,
          placement: placement,
          showCloseButton: showCloseButton,
          size: size,
          borderRadius: borderRadius,
          isRounded: isRounded,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin;
        switch (placement) {
          case AppOffcanvasPlacement.top:
            begin = const Offset(0, -1);
            break;
          case AppOffcanvasPlacement.bottom:
            begin = const Offset(0, 1);
            break;
          case AppOffcanvasPlacement.start:
            begin = const Offset(-1, 0);
            break;
          case AppOffcanvasPlacement.end:
            begin = const Offset(1, 0);
            break;
        }

        return SlideTransition(
          position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Widget offcanvasContent = Material(
      color: theme.bodyBg,
      elevation: 16,
      borderRadius: _getBorderRadius(),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: placement == AppOffcanvasPlacement.top,
        bottom: placement == AppOffcanvasPlacement.bottom,
        child: Column(
          children: [
            if (title != null || showCloseButton) _buildHeader(context),
            Expanded(child: content),
          ],
        ),
      ),
    );

    switch (placement) {
      case AppOffcanvasPlacement.start:
        return Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: size ?? (screenWidth > 400 ? 400 : screenWidth * 0.8),
            height: screenHeight,
            child: offcanvasContent,
          ),
        );
      case AppOffcanvasPlacement.end:
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: size ?? (screenWidth > 400 ? 400 : screenWidth * 0.8),
            height: screenHeight,
            child: offcanvasContent,
          ),
        );
      case AppOffcanvasPlacement.top:
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: screenWidth,
            height: size ?? 300,
            child: offcanvasContent,
          ),
        );
      case AppOffcanvasPlacement.bottom:
        return SizedBox(
          width: screenWidth,
          height: size ?? 300,
          child: offcanvasContent,
        );
    }
  }

  BorderRadius _getBorderRadius() {
    if (borderRadius != null) return borderRadius!;
    if (!isRounded) return BorderRadius.zero;

    const radius = Radius.circular(16);
    switch (placement) {
      case AppOffcanvasPlacement.start:
        return const BorderRadius.only(topRight: radius, bottomRight: radius);
      case AppOffcanvasPlacement.end:
        return const BorderRadius.only(topLeft: radius, bottomLeft: radius);
      case AppOffcanvasPlacement.top:
        return const BorderRadius.only(bottomLeft: radius, bottomRight: radius);
      case AppOffcanvasPlacement.bottom:
        return const BorderRadius.only(topLeft: radius, topRight: radius);
    }
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 16, 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.borderColor.withAlpha(50)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null)
            Expanded(
              child: Text(
                title!,
                style: Theme.of(context)
                    .extension<AppTypographyExtension>()!
                    .h5
                    .copyWith(
                      fontWeight: AppTypography.semiBold,
                      color: theme.textEmphasis,
                    ),
              ),
            ),
          if (showCloseButton)
            IconButton(
              icon: Icon(
                Icons.close,
                size: 20,
                color: theme.textEmphasis.withAlpha(150),
              ),
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 20,
            ),
        ],
      ),
    );
  }
}

class AppOffcanvasBody extends AppStatelessWrapper {
  final Widget child;
  final EdgeInsets padding;

  const AppOffcanvasBody({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: padding,
      child: DefaultTextStyle(
        style: Theme.of(context)
            .extension<AppTypographyExtension>()!
            .bodyBase
            .copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodyColor,
            ),
        child: child,
      ),
    );
  }
}
