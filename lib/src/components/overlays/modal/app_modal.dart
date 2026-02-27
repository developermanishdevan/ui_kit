import '../../../../ui_kit.dart';
import 'package:flutter/material.dart';

enum AppModalSize { sm, md, lg, xl, fullScreen }

class AppModal extends AppStatelessWrapper {
  final String? title;
  final Widget content;
  final Widget? footer;
  final AppModalSize size;
  final bool centered;
  final bool scrollable;
  final Color? backgroundColor;
  final Color? textColor;

  const AppModal({
    super.key,
    this.title,
    required this.content,
    this.footer,
    this.size = AppModalSize.md,
    this.centered = true,
    this.scrollable = false,
    this.backgroundColor,
    this.textColor,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required Widget content,
    Widget? footer,
    AppModalSize size = AppModalSize.md,
    bool centered = true,
    bool scrollable = false,
    bool dismissible = true,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => AppModal(
        title: title,
        content: content,
        footer: footer,
        size: size,
        centered: centered,
        scrollable: scrollable,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    final double maxWidth = _getMaxWidth(context);
    final Color effectiveBg = backgroundColor ?? theme.bodyBg;
    final Color effectiveText = textColor ?? theme.textEmphasis;

    Widget modalContent = Material(
      color: effectiveBg,
      borderRadius: size == AppModalSize.fullScreen
          ? BorderRadius.zero
          : BorderRadius.circular(4),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) _buildHeader(context, effectiveText),
          if (scrollable)
            Flexible(child: SingleChildScrollView(child: content))
          else
            content,
          ?footer,
        ],
      ),
    );

    if (size == AppModalSize.fullScreen) {
      return Dialog.fullscreen(
        backgroundColor: effectiveBg,
        child: modalContent,
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      alignment: centered ? Alignment.center : Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: modalContent,
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color textColor) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 16, 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.borderColor.withAlpha(50)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title!,
              style: Theme.of(context)
                  .extension<AppTypographyExtension>()!
                  .h5
                  .copyWith(
                    fontWeight: AppTypography.semiBold,
                    color: textColor,
                  ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 20, color: textColor.withAlpha(150)),
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  double _getMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    switch (size) {
      case AppModalSize.sm:
        return 300;
      case AppModalSize.md:
        return 500;
      case AppModalSize.lg:
        return 800;
      case AppModalSize.xl:
        return 1140;
      case AppModalSize.fullScreen:
        return width;
    }
  }
}

class AppModalBody extends AppStatelessWrapper {
  final Widget child;
  final EdgeInsets padding;

  const AppModalBody({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: padding,
      child: DefaultTextStyle(
        style: Theme.of(context)
            .extension<AppTypographyExtension>()!
            .bodyBase
            .copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodyColor,
            ),
        child: child,
      ),
    );
  }
}

class AppModalFooter extends AppStatelessWrapper {
  final List<Widget> children;
  final EdgeInsets padding;

  const AppModalFooter({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: theme.borderColor.withAlpha(50))),
      ),
      child: Wrap(alignment: WrapAlignment.end, spacing: 8, children: children),
    );
  }
}
