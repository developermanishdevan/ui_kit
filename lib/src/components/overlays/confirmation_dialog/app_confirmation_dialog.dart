import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppConfirmationDialog {
  /// Shows a definitive yes/no dialog and returns a boolean value
  /// [true] if the user agreed, [false] if canceled or dismissed.
  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    AppButtonVariant confirmVariant = AppButtonVariant.solid,
    bool isDestructive = false,
  }) async {
    final result = await AppDialog.show<bool>(
      context: context,
      title: title,
      content: Text(message),
      actions: [
        AppButton(
          label: cancelLabel,
          variant: AppButtonVariant.outline,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppButton(
          label: confirmLabel,
          variant: confirmVariant,
          color: isDestructive ? AppButtonColor.danger : AppButtonColor.primary,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );

    return result ?? false;
  }
}
