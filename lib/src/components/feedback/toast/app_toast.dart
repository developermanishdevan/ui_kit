import '../../../../ui_kit.dart';
import 'dart:async';
import 'package:flutter/material.dart';

enum AppToastPosition {
  topStart,
  topCenter,
  topEnd,
  bottomStart,
  bottomCenter,
  bottomEnd,
}

enum AppToastVariant {
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  light,
  dark,
}

class AppToastData {
  final String id;
  final String? title;
  final String description;
  final String? timestamp;
  final Widget? icon;
  final AppToastVariant variant;
  final Duration duration;

  AppToastData({
    required this.id,
    this.title,
    required this.description,
    this.timestamp,
    this.icon,
    this.variant = AppToastVariant.light,
    this.duration = const Duration(seconds: 5),
  });
}

class AppToast extends AppStatelessWrapper {
  final String? title;
  final String description;
  final String? timestamp;
  final Widget? icon;
  final VoidCallback? onClose;
  final AppToastVariant variant;

  const AppToast({
    super.key,
    this.title,
    required this.description,
    this.timestamp,
    this.icon,
    this.onClose,
    this.variant = AppToastVariant.light,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final isLight = variant == AppToastVariant.light;

    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (variant) {
      case AppToastVariant.primary:
        bgColor = theme.primary;
        textColor = Colors.white;
        borderColor = theme.primary;
        break;
      case AppToastVariant.secondary:
        bgColor = theme.secondary;
        textColor = Colors.white;
        borderColor = theme.secondary;
        break;
      case AppToastVariant.success:
        bgColor = theme.success;
        textColor = Colors.white;
        borderColor = theme.success;
        break;
      case AppToastVariant.danger:
        bgColor = theme.danger;
        textColor = Colors.white;
        borderColor = theme.danger;
        break;
      case AppToastVariant.warning:
        bgColor = theme.warning;
        textColor = Colors.black87;
        borderColor = theme.warning;
        break;
      case AppToastVariant.info:
        bgColor = theme.info;
        textColor = Colors.white;
        borderColor = theme.info;
        break;
      case AppToastVariant.dark:
        bgColor = theme.dark;
        textColor = Colors.white;
        borderColor = theme.dark;
        break;
      case AppToastVariant.light:
        bgColor = theme.bodyBg;
        textColor = theme.bodyColor;
        borderColor = theme.borderColor;
        break;
    }

    final bool hasHeader = title != null || timestamp != null || icon != null;

    return AppSemantics(
      label: 'Toast: ${title ?? description}',
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 15,
              spreadRadius: -5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (hasHeader) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isLight
                            ? theme.borderColor
                            : textColor.withAlpha(50),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (icon != null) ...[icon!, const SizedBox(width: 8)],
                      if (title != null)
                        Expanded(
                          child: Text(
                            title!,
                            style: typography.bodyBase.copyWith(
                              fontWeight: AppTypography.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      if (timestamp != null)
                        Text(
                          timestamp!,
                          style: typography.bodySm.copyWith(
                            color: textColor.withAlpha(150),
                          ),
                        ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: onClose,
                        borderRadius: BorderRadius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: textColor.withAlpha(150),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        style: typography.bodyBase.copyWith(
                          color: textColor.withAlpha(220),
                          height: 1.4,
                        ),
                      ),
                    ),
                    if (!hasHeader) ...[
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: onClose,
                        borderRadius: BorderRadius.circular(4),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: textColor.withAlpha(150),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppToastManager {
  static final Map<AppToastPosition, OverlayEntry?> _positionEntries = {};
  static final Map<AppToastPosition, List<AppToastData>> _toastsByPosition = {};
  static final Map<AppToastPosition, GlobalKey<_ToastListState>> _positionKeys =
      {};

  static void show(
    BuildContext context, {
    String? title,
    required String description,
    String? timestamp,
    Widget? icon,
    AppToastVariant variant = AppToastVariant.light,
    AppToastPosition position = AppToastPosition.topEnd,
    Duration duration = const Duration(seconds: 5),
  }) {
    final String id = DateTime.now().millisecondsSinceEpoch.toString();
    final data = AppToastData(
      id: id,
      title: title,
      description: description,
      timestamp: timestamp,
      icon: icon,
      variant: variant,
      duration: duration,
    );

    if (!_toastsByPosition.containsKey(position)) {
      _toastsByPosition[position] = [];
      _positionKeys[position] = GlobalKey<_ToastListState>();
    }

    _toastsByPosition[position]!.add(data);

    if (_positionEntries[position] == null) {
      final entry = OverlayEntry(
        builder: (context) => _ToastList(
          key: _positionKeys[position],
          position: position,
          onRemove: (toastData) => _removeToast(position, toastData),
        ),
      );
      _positionEntries[position] = entry;
      Overlay.of(context).insert(entry);
    } else {
      _positionKeys[position]?.currentState?.update();
    }

    if (duration != Duration.zero) {
      Timer(duration, () {
        _removeToast(position, data);
      });
    }
  }

  static void _removeToast(AppToastPosition position, AppToastData data) {
    if (_toastsByPosition[position]?.contains(data) ?? false) {
      _toastsByPosition[position]!.remove(data);
      _positionKeys[position]?.currentState?.update();

      if (_toastsByPosition[position]!.isEmpty) {
        _positionEntries[position]?.remove();
        _positionEntries[position] = null;
      }
    }
  }

  static List<AppToastData> getToasts(AppToastPosition position) {
    return _toastsByPosition[position] ?? [];
  }
}

class _ToastList extends AppStatefulWrapper {
  final AppToastPosition position;
  final Function(AppToastData) onRemove;

  const _ToastList({super.key, required this.position, required this.onRemove});

  @override
  State<_ToastList> createState() => _ToastListState();
}

class _ToastListState extends AppStatefulWrapperState<_ToastList> {
  void update() {
    if (mounted) setState(() {});
  }

  @override
  Widget buildWidget(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final toasts = AppToastManager.getToasts(widget.position);

    if (toasts.isEmpty) return const SizedBox.shrink();

    Alignment alignment;
    if (isMobile) {
      alignment = widget.position.toString().contains('top')
          ? Alignment.topCenter
          : Alignment.bottomCenter;
    } else {
      switch (widget.position) {
        case AppToastPosition.topStart:
          alignment = Alignment.topLeft;
          break;
        case AppToastPosition.topCenter:
          alignment = Alignment.topCenter;
          break;
        case AppToastPosition.topEnd:
          alignment = Alignment.topRight;
          break;
        case AppToastPosition.bottomStart:
          alignment = Alignment.bottomLeft;
          break;
        case AppToastPosition.bottomCenter:
          alignment = Alignment.bottomCenter;
          break;
        case AppToastPosition.bottomEnd:
          alignment = Alignment.bottomRight;
          break;
      }
    }

    return SafeArea(
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 350,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  isMobile ||
                      widget.position == AppToastPosition.topCenter ||
                      widget.position == AppToastPosition.bottomCenter
                  ? CrossAxisAlignment.center
                  : widget.position == AppToastPosition.topEnd ||
                        widget.position == AppToastPosition.bottomEnd
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              verticalDirection: widget.position.toString().contains('bottom')
                  ? VerticalDirection.up
                  : VerticalDirection.down,
              children: toasts.map((data) {
                return _AnimatedToast(
                  key: ValueKey(data.id),
                  data: data,
                  onClose: () => widget.onRemove(data),
                  position: widget.position,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedToast extends AppStatefulWrapper {
  final AppToastData data;
  final VoidCallback onClose;
  final AppToastPosition position;

  const _AnimatedToast({
    super.key,
    required this.data,
    required this.onClose,
    required this.position,
  });

  @override
  State<_AnimatedToast> createState() => _AnimatedToastState();
}

class _AnimatedToastState extends AppStatefulWrapperState<_AnimatedToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Offset startOffset;
    if (widget.position.toString().contains('End')) {
      startOffset = const Offset(1, 0);
    } else if (widget.position.toString().contains('Start')) {
      startOffset = const Offset(-1, 0);
    } else if (widget.position.toString().contains('top')) {
      startOffset = const Offset(0, -1);
    } else {
      startOffset = const Offset(0, 1);
    }

    _slideAnimation = Tween<Offset>(
      begin: startOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleClose() async {
    await _controller.reverse();
    widget.onClose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return AppFadeAnimation(
      opacity: _fadeAnimation.value,
      child: AppSlideAnimation(
        offset: _slideAnimation.value,
        child: AppToast(
          title: widget.data.title,
          description: widget.data.description,
          timestamp: widget.data.timestamp,
          icon: widget.data.icon,
          variant: widget.data.variant,
          onClose: _handleClose,
        ),
      ),
    );
  }
}
