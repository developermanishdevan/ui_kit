import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
    bool dismissible = true,
  }) {
    return AppModal.show<T>(
      context,
      title: title,
      content: AppModalBody(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: content,
      ),
      dismissible: dismissible,
      size: AppModalSize.sm,
      footer: actions != null
          ? AppModalFooter(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: actions,
            )
          : null,
    );
  }

  static Future<T?> showAlert<T>({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'OK',
  }) {
    return show<T>(
      context: context,
      title: title,
      content: Text(message),
      actions: [
        AppButton(
          label: confirmLabel,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
