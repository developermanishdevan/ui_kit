# Guide 10-11 — Feedback & Overlay System

---

# PART A: Feedback Components

## 10.1 AppLoader / AppCircularLoader

```dart
// lib/src/components/feedback/loader/app_loader.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.size = 40.0,
    this.color,
    this.strokeWidth = 3.0,
    this.message,
  });

  final double size;
  final Color? color;
  final double strokeWidth;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox(
      width: size, height: size,
      child: CircularProgressIndicator(
        color:       color ?? AppColors.primary,
        strokeWidth: strokeWidth,
      ),
    );
    if (message == null) return indicator;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        indicator,
        const SizedBox(height: 16),
        Text(message!, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class AppLinearLoader extends StatelessWidget {
  const AppLinearLoader({super.key, this.value, this.color, this.height = 4.0});
  final double? value;
  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: value, color: color ?? AppColors.primary,
        minHeight: height,
      ),
    );
  }
}
```

---

## 10.2 AppSkeleton / AppShimmer

```dart
// lib/src/components/feedback/skeleton/app_skeleton.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';

class AppSkeleton extends StatefulWidget {
  const AppSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.isCircle = false,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final bool isCircle;

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.4, end: 0.9).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width:  widget.isCircle ? widget.height : widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColors.grey200.withOpacity(_anim.value),
          shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: widget.isCircle
              ? null
              : (widget.borderRadius ?? AppRadius.smAll),
        ),
      ),
    );
  }
}
```

---

## 10.3 AppSnackbar

```dart
// lib/src/components/feedback/snackbar/app_snackbar.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

enum AppSnackbarType { info, success, warning, error }

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    AppSnackbarType type = AppSnackbarType.info,
    String? action,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    final (bg, fg, icon) = switch (type) {
      AppSnackbarType.success => (AppColors.success, AppColors.white, Icons.check_circle),
      AppSnackbarType.warning => (AppColors.warning, AppColors.white, Icons.warning_amber),
      AppSnackbarType.error   => (AppColors.error,   AppColors.white, Icons.error),
      AppSnackbarType.info    => (AppColors.grey900,  AppColors.white, Icons.info),
    };

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration:    duration,
          behavior:    SnackBarBehavior.floating,
          backgroundColor: bg,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          margin: const EdgeInsets.all(AppSpacing.base),
          content: Row(
            children: [
              Icon(icon, color: fg, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(message,
                  style: AppTypography.bodyMedium.copyWith(color: fg)),
              ),
            ],
          ),
          action: action != null
              ? SnackBarAction(
                  label:      action,
                  textColor:  fg,
                  onPressed:  onAction ?? () {},
                )
              : null,
        ),
      );
  }
}
```

---

## 10.4 AppAlert

```dart
// lib/src/components/feedback/alert/app_alert.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

enum AppAlertType { info, success, warning, error }

class AppAlert extends StatelessWidget {
  const AppAlert({
    super.key,
    required this.message,
    this.title,
    this.type = AppAlertType.info,
    this.onDismiss,
    this.action,
    this.onAction,
    this.icon,
  });

  final String message;
  final String? title;
  final AppAlertType type;
  final VoidCallback? onDismiss;
  final String? action;
  final VoidCallback? onAction;
  final IconData? icon;

  static const _configs = {
    AppAlertType.info:    (AppColors.infoLight,    AppColors.info,    Icons.info_outline),
    AppAlertType.success: (AppColors.successLight, AppColors.success, Icons.check_circle_outline),
    AppAlertType.warning: (AppColors.warningLight, AppColors.warning, Icons.warning_amber_outlined),
    AppAlertType.error:   (AppColors.errorLight,   AppColors.error,   Icons.error_outline),
  };

  @override
  Widget build(BuildContext context) {
    final (bg, fg, defaultIcon) = _configs[type]!;
    final effectiveIcon = icon ?? defaultIcon;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: fg.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(effectiveIcon, color: fg, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(title!, style: AppTypography.labelLarge.copyWith(color: fg)),
                Text(message, style: AppTypography.bodySmall.copyWith(
                  color: fg.withOpacity(0.85),
                )),
                if (action != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  GestureDetector(
                    onTap: onAction,
                    child: Text(action!,
                      style: AppTypography.labelSmall.copyWith(
                        color: fg, decoration: TextDecoration.underline,
                      )),
                  ),
                ],
              ],
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, size: 18, color: fg.withOpacity(0.7)),
            ),
        ],
      ),
    );
  }
}
```

---

## 10.5 State Widgets (Empty, Error, Success)

```dart
// lib/src/components/feedback/empty_state/app_empty_state.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    this.icon = Icons.inbox_outlined,
    this.title = 'Nothing here',
    this.message,
    this.action,
    this.onAction,
    this.iconSize = 64.0,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? action;
  final VoidCallback? onAction;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) => _StateWidget(
    icon:     icon,
    title:    title,
    message:  message,
    action:   action,
    onAction: onAction,
    iconSize: iconSize,
    iconColor: iconColor ?? AppColors.grey300,
  );
}

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    this.title = 'Something went wrong',
    this.message,
    this.onRetry,
  });
  final String title;
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => _StateWidget(
    icon:     Icons.error_outline,
    title:    title,
    message:  message,
    action:   onRetry != null ? 'Try Again' : null,
    onAction: onRetry,
    iconColor: AppColors.error,
  );
}

class AppSuccessState extends StatelessWidget {
  const AppSuccessState({
    super.key,
    this.title = 'All done!',
    this.message,
    this.action,
    this.onAction,
  });
  final String title;
  final String? message;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => _StateWidget(
    icon:     Icons.check_circle_outline,
    title:    title,
    message:  message,
    action:   action,
    onAction: onAction,
    iconColor: AppColors.success,
  );
}

class AppNoInternetState extends StatelessWidget {
  const AppNoInternetState({super.key, this.onRetry});
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => _StateWidget(
    icon:     Icons.wifi_off,
    title:    'No internet connection',
    message:  'Please check your network and try again.',
    action:   onRetry != null ? 'Retry' : null,
    onAction: onRetry,
    iconColor: AppColors.grey400,
  );
}

class _StateWidget extends StatelessWidget {
  const _StateWidget({
    required this.icon,
    required this.title,
    this.message,
    this.action,
    this.onAction,
    this.iconSize = 64.0,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? action;
  final VoidCallback? onAction;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize, color: iconColor ?? AppColors.grey300),
            const SizedBox(height: AppSpacing.base),
            Text(title, style: AppTypography.headlineSmall, textAlign: TextAlign.center),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(message!, style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ), textAlign: TextAlign.center),
            ],
            if (action != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.xl),
              FilledButton(onPressed: onAction, child: Text(action!)),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## 10.6 AppRetryWrapper

```dart
// lib/src/components/feedback/retry_wrapper/app_retry_wrapper.dart
import 'package:flutter/material.dart';

enum _RetryState { loading, data, error }

class AppRetryWrapper extends StatefulWidget {
  const AppRetryWrapper({
    super.key,
    required this.future,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
    this.onRetry,
  });

  final Future<void> Function() future;
  final Widget Function(BuildContext) builder;
  final Widget Function(BuildContext, Object?)? errorBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final VoidCallback? onRetry;

  @override
  State<AppRetryWrapper> createState() => _AppRetryWrapperState();
}

class _AppRetryWrapperState extends State<AppRetryWrapper> {
  _RetryState _state = _RetryState.loading;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _state = _RetryState.loading);
    try {
      await widget.future();
      if (mounted) setState(() => _state = _RetryState.data);
    } catch (e) {
      if (mounted) setState(() { _state = _RetryState.error; _error = e; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      _RetryState.loading => widget.loadingBuilder?.call(context)
          ?? const Center(child: CircularProgressIndicator()),
      _RetryState.error   => widget.errorBuilder?.call(context, _error)
          ?? Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('Something went wrong'),
                const SizedBox(height: 12),
                FilledButton(onPressed: _load, child: const Text('Retry')),
              ]),
            ),
      _RetryState.data    => widget.builder(context),
    };
  }
}
```

---

# PART B: Overlay Components

## 11.1 AppDialog / AppConfirmationDialog

```dart
// lib/src/components/overlays/dialog/app_dialog.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.icon,
    this.iconColor,
    this.scrollable = false,
    this.width,
  });

  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final IconData? icon;
  final Color? iconColor;
  final bool scrollable;
  final double? width;

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    Widget? content,
    List<Widget>? actions,
    IconData? icon,
    Color? iconColor,
    bool barrierDismissible = true,
    bool scrollable = false,
  }) {
    return showDialog<T>(
      context:             context,
      barrierDismissible:  barrierDismissible,
      builder:             (_) => AppDialog(
        title:     title,
        content:   content,
        actions:   actions,
        icon:      icon,
        iconColor: iconColor,
        scrollable: scrollable,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon != null ? Icon(icon, color: iconColor, size: 32) : null,
      title: title != null
          ? Text(title!, style: AppTypography.headlineMedium, textAlign: TextAlign.center)
          : null,
      content:     content,
      actions:     actions,
      scrollable:  scrollable,
    );
  }
}

/// Pre-built confirmation dialog.
class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel  = 'Cancel',
    this.isDestructive = false,
    this.icon,
  });

  final String title;
  final String? message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;
  final IconData? icon;

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel  = 'Cancel',
    bool isDestructive  = false,
    IconData? icon,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AppConfirmationDialog(
        title:          title,
        message:        message,
        confirmLabel:   confirmLabel,
        cancelLabel:    cancelLabel,
        isDestructive:  isDestructive,
        icon:           icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AppDialog(
      icon:      icon,
      iconColor: isDestructive ? cs.error : cs.primary,
      title:     title,
      content:   message != null
          ? Text(message!, style: AppTypography.bodyMedium, textAlign: TextAlign.center)
          : null,
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel),
        ),
        const SizedBox(width: 8),
        FilledButton(
          style: isDestructive
              ? FilledButton.styleFrom(backgroundColor: cs.error)
              : null,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
```

---

## 11.2 AppBottomSheet

```dart
// lib/src/components/overlays/bottom_sheet/app_bottom_sheet.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
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
      context:           context,
      isDismissible:     isDismissible,
      isScrollControlled: isScrollControlled,
      showDragHandle:    showDragHandle,
      useSafeArea:       true,
      builder: (_) => AppBottomSheet(
        title:        title,
        actions:      actions,
        padding:      padding,
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
      minChildSize:     0.25,
      maxChildSize:     maxChildSize,
      expand:           false,
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
```

---

## 11.3 AppTooltip

```dart
// lib/src/components/overlays/tooltip/app_tooltip.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.preferBelow = true,
    this.triggerMode,
    this.showDuration,
    this.waitDuration,
  });

  final String message;
  final Widget child;
  final bool preferBelow;
  final TooltipTriggerMode? triggerMode;
  final Duration? showDuration;
  final Duration? waitDuration;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message:       message,
      preferBelow:   preferBelow,
      triggerMode:   triggerMode,
      showDuration:  showDuration,
      waitDuration:  waitDuration,
      decoration: BoxDecoration(
        color: AppColors.grey900,
        borderRadius: AppRadius.smAll,
      ),
      textStyle: AppTypography.caption.copyWith(color: AppColors.white),
      child: child,
    );
  }
}
```

---

## 11.4 AppModal

```dart
// lib/src/components/overlays/modal/app_modal.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';

class AppModal extends StatelessWidget {
  const AppModal({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth = 560.0,
    this.barrierDismissible = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double maxWidth;
  final bool barrierDismissible;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    double maxWidth = 560.0,
    bool barrierDismissible = true,
    EdgeInsetsGeometry? padding,
  }) {
    return showGeneralDialog<T>(
      context:           context,
      barrierDismissible: barrierDismissible,
      barrierLabel:      'Modal',
      barrierColor:      AppColors.overlayMedium,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim, _) => AppModal(
        maxWidth: maxWidth,
        padding:  padding,
        barrierDismissible: barrierDismissible,
        child: child,
      ),
      transitionBuilder: (ctx, anim, _, child2) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOut),
          ),
          child: child2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.xl),
          child: child,
        ),
      ),
    );
  }
}
```

---

## 11.5 AppContextMenu

```dart
// lib/src/components/overlays/context_menu/app_context_menu.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

class AppContextMenuItem {
  const AppContextMenuItem({
    required this.label,
    required this.onTap,
    this.icon,
    this.isDestructive = false,
    this.enabled = true,
    this.dividerAfter = false,
  });
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isDestructive;
  final bool enabled;
  final bool dividerAfter;
}

class AppContextMenu extends StatelessWidget {
  const AppContextMenu({
    super.key,
    required this.items,
    required this.child,
  });

  final List<AppContextMenuItem> items;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _show(context),
      onSecondaryTap: () => _show(context),
      child: child,
    );
  }

  void _show(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx, offset.dy + box.size.height,
        offset.dx + box.size.width, offset.dy,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      items: items.expand((item) {
        final tile = PopupMenuItem(
          enabled:  item.enabled,
          onTap:    item.onTap,
          child: Row(
            children: [
              if (item.icon != null) ...[
                Icon(item.icon, size: 18,
                  color: item.isDestructive ? AppColors.error
                      : item.enabled ? AppColors.textPrimary : AppColors.textTertiary),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(item.label,
                style: AppTypography.bodyMedium.copyWith(
                  color: item.isDestructive ? AppColors.error
                      : item.enabled ? AppColors.textPrimary : AppColors.textTertiary,
                )),
            ],
          ),
        );
        return item.dividerAfter
            ? [tile, const PopupMenuDivider()]
            : [tile];
      }).toList(),
    );
  }
}
```
