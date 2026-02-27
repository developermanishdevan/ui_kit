import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppDraggableBottomSheet extends AppStatelessWrapper {
  final Widget Function(BuildContext context, ScrollController scrollController)
  builder;
  final ScrollController? scrollController;
  final bool showHandle;
  final Color? backgroundColor;

  const AppDraggableBottomSheet({
    super.key,
    required this.builder,
    this.scrollController,
    this.showHandle = true,
    this.backgroundColor,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget Function(BuildContext, ScrollController) builder,
    double initialChildSize = 0.5,
    double minChildSize = 0.25,
    double maxChildSize = 1.0,
    bool expand = false,
    bool showHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
  }) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors
          .transparent, // Background handled internally for correct corner clips and dragging
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          expand: expand,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? theme.bodyBg,
                borderRadius: BorderRadius.only(
                  topLeft: radii.base.topLeft,
                  topRight: radii.base.topRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: AppDraggableBottomSheet(
                builder: builder,
                scrollController: controller,
                showHandle: showHandle,
                backgroundColor: backgroundColor,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showHandle)
          Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: AppSpacing.s3,
                bottom: AppSpacing.s3,
              ),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.bodySecondaryColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        Expanded(
          child: builder(context, scrollController ?? ScrollController()),
        ),
      ],
    );
  }
}
