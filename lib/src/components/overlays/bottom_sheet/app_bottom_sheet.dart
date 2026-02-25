import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.child, super.key,
    this.title,
    this.actions,
    this.padding,
    this.showDragHandle = true,
    this.maxChildSize = 0.9,
  });

  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? padding;
  final bool showDragHandle;
  final double maxChildSize;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    List<Widget>? actions,
    bool isDismissible = true,
    bool showDragHandle = true,
    bool isScrollControlled = true,
    double maxChildSize = 0.9,
    EdgeInsetsGeometry? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      showDragHandle: showDragHandle,
      useSafeArea: true,
      builder: (_) => AppBottomSheet(
        title: title,
        actions: actions,
        padding: padding,
        showDragHandle: showDragHandle,
        maxChildSize: maxChildSize,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.25,
      maxChildSize: maxChildSize,
      expand: false,
      builder: (_, ctrl) => Column(
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.base, AppSpacing.sm, AppSpacing.base, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(title!, style: AppTypography.headlineSmall),
                  ),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              controller: ctrl,
              padding: padding ?? const EdgeInsets.all(AppSpacing.base),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
