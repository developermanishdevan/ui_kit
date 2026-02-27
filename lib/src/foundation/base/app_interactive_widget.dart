import 'package:flutter/material.dart';

class AppInteractiveWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final String? semanticLabel;
  final bool showHoverEffect;
  final bool disabled;
  final MouseCursor? cursor;

  const AppInteractiveWidget({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.semanticLabel,
    this.showHoverEffect = true,
    this.disabled = false,
    this.cursor,
  });

  @override
  State<AppInteractiveWidget> createState() => _AppInteractiveWidgetState();
}

class _AppInteractiveWidgetState extends State<AppInteractiveWidget> {
  bool _isHovered = false;
  bool _isPressed = false;

  void _handleHover(bool isHovered) {
    if (widget.disabled) return;
    setState(() {
      _isHovered = isHovered;
    });
    if (widget.onHover != null) {
      widget.onHover!(isHovered);
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.disabled) return;
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.disabled) return;
    setState(() {
      _isPressed = false;
    });
  }

  void _handleTapCancel() {
    if (widget.disabled) return;
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.child;

    if (widget.showHoverEffect && !widget.disabled) {
      if (_isPressed) {
        content = Opacity(opacity: 0.8, child: content);
      } else if (_isHovered) {
        content = Opacity(opacity: 0.9, child: content);
      }
    }

    content = MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      cursor: widget.disabled
          ? SystemMouseCursors.forbidden
          : widget.cursor ?? SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.disabled ? null : widget.onTap,
        onLongPress: widget.disabled ? null : widget.onLongPress,
        behavior: HitTestBehavior.opaque,
        child: content,
      ),
    );

    if (widget.semanticLabel != null) {
      content = Semantics(
        label: widget.semanticLabel,
        button: widget.onTap != null,
        enabled: !widget.disabled,
        child: content,
      );
    }

    return content;
  }
}
