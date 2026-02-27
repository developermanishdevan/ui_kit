import 'package:flutter/material.dart';
import 'app_semantics.dart';

/// A wrapper for creating accessible buttons that ensures compliance with basic
/// accessibility guidelines (minimum touch targets, semantic labels).
class AppAccessibleButton extends StatelessWidget {
  /// The widget below this one in the tree.
  final Widget child;

  /// Called when a tap is triggered.
  final VoidCallback? onPressed;

  /// Called when a long press is triggered.
  final VoidCallback? onLongPress;

  /// A text description of the button's action for screen readers.
  final String label;

  /// A brief description of the result of the action.
  final String? hint;

  /// Whether this button should be focused initially.
  final bool autofocus;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// The cursor for a mouse pointer when it enters or is hovering over the widget.
  final MouseCursor? mouseCursor;

  /// The highlight color that's typically used to indicate that the button is
  /// pressed, hovered, or focused.
  final WidgetStateProperty<Color?>? overlayColor;

  /// Whether to wrap the button in an [AppSemantics] widget.
  final bool useSemantics;

  /// Whether to show the Material ripple effect.
  final bool showRipple;

  /// The shape of the ripple boundary.
  final ShapeBorder? customBorder;

  /// The minimum size of the touch target. Material guidelines recommend 48.0.
  final double minTouchTargetSize;

  const AppAccessibleButton({
    super.key,
    required this.child,
    required this.label,
    this.onPressed,
    this.onLongPress,
    this.hint,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
    this.overlayColor,
    this.useSemantics = true,
    this.showRipple = true,
    this.customBorder,
    this.minTouchTargetSize = 48.0,
  });

  bool get _enabled => onPressed != null || onLongPress != null;

  @override
  Widget build(BuildContext context) {
    Widget result = child;

    // Minimum touch target size required for accessibility guidelines.
    result = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minTouchTargetSize,
        minHeight: minTouchTargetSize,
      ),
      child: Center(heightFactor: 1.0, widthFactor: 1.0, child: result),
    );

    if (showRipple) {
      result = InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        autofocus: autofocus,
        focusNode: focusNode,
        mouseCursor: mouseCursor,
        overlayColor: overlayColor,
        customBorder: customBorder,
        child: result,
      );
    } else {
      result = GestureDetector(
        onTap: onPressed,
        onLongPress: onLongPress,
        behavior: HitTestBehavior.opaque,
        child: result,
      );

      // Since InkWell handles focus natively, we must provide our own Focus widget
      // when ripple is disabled.
      result = Focus(focusNode: focusNode, autofocus: autofocus, child: result);
    }

    if (useSemantics) {
      result = AppSemantics(
        label: label,
        hint: hint,
        button: true,
        enabled: _enabled,
        child: result,
      );
    }

    return result;
  }
}
