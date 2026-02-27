import 'package:flutter/material.dart';

class AppHelpers {
  AppHelpers._();

  /// Unfocuses the current focused text field
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Safely executes a delayed action
  static Future<void> delay(int milliseconds, VoidCallback action) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
    action();
  }
}
