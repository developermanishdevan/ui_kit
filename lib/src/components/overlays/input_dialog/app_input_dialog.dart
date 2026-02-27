import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppInputDialog {
  static Future<String?> show({
    required BuildContext context,
    required String title,
    String? message,
    String? hintText,
    String? initialValue,
    String confirmLabel = 'Submit',
    String cancelLabel = 'Cancel',
    TextInputAction textInputAction = TextInputAction.done,
  }) async {
    final TextEditingController controller = TextEditingController(
      text: initialValue,
    );

    final result = await AppModal.show<String>(
      context,
      title: title,
      size: AppModalSize.sm,
      content: AppModalBody(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (message != null) ...[
              Text(message),
              const SizedBox(height: AppSpacing.s4),
            ],
            AppTextField(controller: controller, hintText: hintText),
          ],
        ),
      ),
      footer: AppModalFooter(
        children: [
          AppButton(
            label: cancelLabel,
            variant: AppButtonVariant.outline,
            onPressed: () => Navigator.of(context).pop(),
          ),
          AppButton(
            label: confirmLabel,
            variant: AppButtonVariant.solid,
            color: AppButtonColor.primary,
            onPressed: () => Navigator.of(context).pop(controller.text),
          ),
        ],
      ),
    );

    return result;
  }
}
