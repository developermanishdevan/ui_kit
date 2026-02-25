import 'package:flutter/material.dart';

/// Mixin for widgets with press/hover/focus states.
mixin AppInteractiveState<T extends StatefulWidget> on State<T> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  bool get isHovered => _isHovered;
  bool get isPressed => _isPressed;
  bool get isFocused => _isFocused;

  void onHoverChanged(bool hovered) => setState(() => _isHovered = hovered);

  void onPressChanged(bool pressed) => setState(() => _isPressed = pressed);

  void onFocusChanged(bool focused) => setState(() => _isFocused = focused);

  double get interactiveOpacity {
    if (_isPressed) return 0.7;
    if (_isHovered) return 0.9;
    return 1.0;
  }
}
