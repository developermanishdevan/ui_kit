import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppFullScreenDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    Widget? footer,
  }) {
    // Utilize the existing AppModal with fullScreen size
    return AppModal.show<T>(
      context,
      title: title,
      content: AppModalBody(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: content,
      ),
      size: AppModalSize.fullScreen,
      scrollable: true,
      footer: footer,
    );
  }
}
