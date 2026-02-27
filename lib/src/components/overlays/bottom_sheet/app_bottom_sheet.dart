import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppBottomSheet extends AppStatelessWrapper {
  final Widget child;
  final bool showHandle;
  final EdgeInsets padding;
  final Color? backgroundColor;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.showHandle = true,
    this.padding = const EdgeInsets.all(AppSpacing.s4),
    this.backgroundColor,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool showHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useRootNavigator = false,
    EdgeInsets padding = const EdgeInsets.all(AppSpacing.s4),
    Color? backgroundColor,
  }) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useRootNavigator: useRootNavigator,
      backgroundColor: backgroundColor ?? theme.bodyBg,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: radii.base.topLeft,
          topRight: radii.base.topRight,
        ),
      ),
      builder: (context) => AppBottomSheet(
        showHandle: showHandle,
        padding: padding,
        backgroundColor: backgroundColor,
        child: child,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showHandle)
            Center(
              child: Container(
                margin: const EdgeInsets.only(
                  top: AppSpacing.s2,
                  bottom: AppSpacing.s2,
                ),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.bodySecondaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}
