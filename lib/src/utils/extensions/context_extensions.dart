import 'package:flutter/material.dart';

extension AppContextExtensions on BuildContext {
  /// Shorthand to access Theme.of(context)
  ThemeData get theme => Theme.of(this);

  /// Shorthand to access MediaQuery.of(context)
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Shorthand to get screen size
  Size get screenSize => mediaQuery.size;

  /// Shorthand to check if keyboard is visible
  bool get isKeyboardVisible => mediaQuery.viewInsets.bottom > 0;

  /// Shorthand to unfocus
  void uncontextFocus() => FocusScope.of(this).unfocus();
}
