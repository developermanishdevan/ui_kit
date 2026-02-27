import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

enum AppPopoverPlacement { top, bottom, start, end }

enum AppPopoverTrigger { click, hover }

class AppPopover extends AppStatefulWrapper {
  final Widget child;
  final String? title;
  final Widget content;
  final AppPopoverPlacement placement;
  final AppPopoverTrigger trigger;
  final Color? backgroundColor;
  final Color? textColor;

  const AppPopover({
    super.key,
    required this.child,
    this.title,
    required this.content,
    this.placement = AppPopoverPlacement.top,
    this.trigger = AppPopoverTrigger.click,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<AppPopover> createState() => _AppPopoverState();
}

class _AppPopoverState extends AppStatefulWrapperState<AppPopover> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isVisible = false;

  void _showPopover() {
    if (_isVisible) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isVisible = true;
    });
  }

  void _hidePopover() {
    if (!_isVisible) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isVisible = false;
    });
  }

  void _togglePopover() {
    if (_isVisible) {
      _hidePopover();
    } else {
      _showPopover();
    }
  }

  OverlayEntry _createOverlayEntry() {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dismiss layer for click trigger
          if (widget.trigger == AppPopoverTrigger.click)
            GestureDetector(
              onTap: _hidePopover,
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: _getTargetAnchor(),
            followerAnchor: _getFollowerAnchor(),
            offset: _getOffset(),
            child: Material(
              color: Colors.transparent,
              child: _PopoverContent(
                title: widget.title,
                content: widget.content,
                placement: widget.placement,
                backgroundColor: widget.backgroundColor ?? theme.bodyBg,
                textColor: widget.textColor ?? theme.textEmphasis,
                borderColor: theme.borderColor.withAlpha(50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Alignment _getTargetAnchor() {
    switch (widget.placement) {
      case AppPopoverPlacement.top:
        return Alignment.topCenter;
      case AppPopoverPlacement.bottom:
        return Alignment.bottomCenter;
      case AppPopoverPlacement.start:
        return Alignment.centerLeft;
      case AppPopoverPlacement.end:
        return Alignment.centerRight;
    }
  }

  Alignment _getFollowerAnchor() {
    switch (widget.placement) {
      case AppPopoverPlacement.top:
        return Alignment.bottomCenter;
      case AppPopoverPlacement.bottom:
        return Alignment.topCenter;
      case AppPopoverPlacement.start:
        return Alignment.centerRight;
      case AppPopoverPlacement.end:
        return Alignment.centerLeft;
    }
  }

  Offset _getOffset() {
    const double gap = 8.0;
    switch (widget.placement) {
      case AppPopoverPlacement.top:
        return const Offset(0, -gap);
      case AppPopoverPlacement.bottom:
        return const Offset(0, gap);
      case AppPopoverPlacement.start:
        return const Offset(-gap, 0);
      case AppPopoverPlacement.end:
        return const Offset(gap, 0);
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: AppInteractiveWidget(
        showHoverEffect: false,
        cursor: SystemMouseCursors.basic,
        onHover: widget.trigger == AppPopoverTrigger.hover
            ? (isHovered) {
                if (isHovered) {
                  _showPopover();
                } else {
                  _hidePopover();
                }
              }
            : null,
        onTap: widget.trigger == AppPopoverTrigger.click
            ? _togglePopover
            : null,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _hidePopover();
    super.dispose();
  }
}

class _PopoverContent extends AppStatelessWrapper {
  final String? title;
  final Widget content;
  final AppPopoverPlacement placement;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const _PopoverContent({
    this.title,
    required this.content,
    required this.placement,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 250),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 15,
                spreadRadius: -5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: theme
                        .bodySecondaryBg, // Matches the grey header in React
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(6),
                    ),
                    border: Border(bottom: BorderSide(color: borderColor)),
                  ),
                  child: Text(
                    title!,
                    style: Theme.of(context)
                        .extension<AppTypographyExtension>()!
                        .bodyBase
                        .copyWith(
                          fontWeight: AppTypography.bold,
                          color: textColor,
                        ),
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.all(16),
                child: DefaultTextStyle(
                  style: Theme.of(context)
                      .extension<AppTypographyExtension>()!
                      .bodyBase
                      .copyWith(color: textColor.withAlpha(200), height: 1.4),
                  child: content,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: _getArrowTop(),
          bottom: _getArrowBottom(),
          left: _getArrowLeft(),
          right: _getArrowRight(),
          child: CustomPaint(
            size: const Size(12, 6),
            painter: _PopoverArrowPainter(
              placement: placement,
              color: placement == AppPopoverPlacement.bottom && title != null
                  ? theme.bodySecondaryBg
                  : backgroundColor,
              borderColor: borderColor,
            ),
          ),
        ),
      ],
    );
  }

  double? _getArrowTop() {
    if (placement == AppPopoverPlacement.bottom) return -6;
    if (placement == AppPopoverPlacement.start ||
        placement == AppPopoverPlacement.end) {
      return 0;
    }
    return null;
  }

  double? _getArrowBottom() {
    if (placement == AppPopoverPlacement.top) return -6;
    if (placement == AppPopoverPlacement.start ||
        placement == AppPopoverPlacement.end) {
      return 0;
    }
    return null;
  }

  double? _getArrowLeft() {
    if (placement == AppPopoverPlacement.top ||
        placement == AppPopoverPlacement.bottom) {
      return 0;
    }
    if (placement == AppPopoverPlacement.end) return -12;
    return null;
  }

  double? _getArrowRight() {
    if (placement == AppPopoverPlacement.top ||
        placement == AppPopoverPlacement.bottom) {
      return 0;
    }
    if (placement == AppPopoverPlacement.start) return -12;
    return null;
  }
}

class _PopoverArrowPainter extends CustomPainter {
  final AppPopoverPlacement placement;
  final Color color;
  final Color borderColor;

  _PopoverArrowPainter({
    required this.placement,
    required this.color,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();

    switch (placement) {
      case AppPopoverPlacement.top:
        path.moveTo(size.width / 2 - 6, 0);
        path.lineTo(size.width / 2, size.height);
        path.lineTo(size.width / 2 + 6, 0);
        break;
      case AppPopoverPlacement.bottom:
        path.moveTo(size.width / 2 - 6, size.height);
        path.lineTo(size.width / 2, 0);
        path.lineTo(size.width / 2 + 6, size.height);
        break;
      case AppPopoverPlacement.start:
        path.moveTo(0, size.height / 2 - 6);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height / 2 + 6);
        break;
      case AppPopoverPlacement.end:
        path.moveTo(size.width, size.height / 2 - 6);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width, size.height / 2 + 6);
        break;
    }

    canvas.drawPath(path, paint);
    // We only draw the two angled lines for the arrow border to blend with popover
    final borderPath = Path();
    switch (placement) {
      case AppPopoverPlacement.top:
        borderPath.moveTo(size.width / 2 - 6, 0);
        borderPath.lineTo(size.width / 2, size.height);
        borderPath.lineTo(size.width / 2 + 6, 0);
        break;
      case AppPopoverPlacement.bottom:
        borderPath.moveTo(size.width / 2 - 6, size.height);
        borderPath.lineTo(size.width / 2, 0);
        borderPath.lineTo(size.width / 2 + 6, size.height);
        break;
      case AppPopoverPlacement.start:
        borderPath.moveTo(0, size.height / 2 - 6);
        borderPath.lineTo(size.width, size.height / 2);
        borderPath.lineTo(0, size.height / 2 + 6);
        break;
      case AppPopoverPlacement.end:
        borderPath.moveTo(size.width, size.height / 2 - 6);
        borderPath.lineTo(0, size.height / 2);
        borderPath.lineTo(size.width, size.height / 2 + 6);
        break;
    }
    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
