import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/durations/app_durations.dart';
import 'app_button_size.dart';

/// Common interface that all buttons share.
abstract class AppBaseButton extends StatefulWidget {
  const AppBaseButton({
    required this.onPressed,
    super.key,
    this.label,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = AppButtonSize.medium,
    this.width,
    this.borderRadius,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final String? label;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isDisabled;
  final AppButtonSize size;
  final double? width;
  final BorderRadius? borderRadius;
  final String? tooltip;

  bool get isInteractive => !isDisabled && !isLoading && onPressed != null;
}

/// Base state that handles press animation and loading indicator.
abstract class AppBaseButtonState<T extends AppBaseButton> extends State<T>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: AppDurations.fast,
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _animCtrl;
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget.isInteractive) _animCtrl.reverse();
  }

  void _onTapUp(TapUpDetails _) => _animCtrl.forward();
  void _onTapCancel() => _animCtrl.forward();

  Widget buildLoadingIndicator(Color color) => SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      );

  Widget buildButtonContent({
    required Color foregroundColor,
    required TextStyle labelStyle,
  }) {
    if (widget.isLoading) return buildLoadingIndicator(foregroundColor);

    final iconWidget = widget.icon != null
        ? Icon(widget.icon, size: widget.size.iconSize, color: foregroundColor)
        : null;
    final trailingWidget = widget.trailingIcon != null
        ? Icon(widget.trailingIcon,
            size: widget.size.iconSize, color: foregroundColor)
        : null;
    final labelWidget = widget.label != null
        ? Text(widget.label!,
            style: labelStyle.copyWith(color: foregroundColor))
        : null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconWidget != null) iconWidget,
        if (iconWidget != null && labelWidget != null) const SizedBox(width: 8),
        if (labelWidget != null) labelWidget,
        if (trailingWidget != null && labelWidget != null)
          const SizedBox(width: 8),
        if (trailingWidget != null) trailingWidget,
      ],
    );
  }

  Widget buildWrapper({required Widget child}) {
    Widget btn = ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Opacity(
          opacity: widget.isInteractive ? 1.0 : 0.48,
          child: child,
        ),
      ),
    );

    if (widget.tooltip != null) {
      btn = Tooltip(message: widget.tooltip!, child: btn);
    }
    return btn;
  }
}
