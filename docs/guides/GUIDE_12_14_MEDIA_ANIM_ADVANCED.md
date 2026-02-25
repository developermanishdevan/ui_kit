# Guide 12-14 — Media, Animations & Advanced Enterprise

---

# PART A: Media Components

## 12.1 AppImage

```dart
// lib/src/components/media/image/app_image.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';

enum AppImageFit { cover, contain, fill, scaleDown, fitWidth, fitHeight }

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.fit = AppImageFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.onTap,
    this.isAsset = false,
    this.semanticLabel,
  });

  final String source;
  final double? width;
  final double? height;
  final AppImageFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final VoidCallback? onTap;
  final bool isAsset;
  final String? semanticLabel;

  BoxFit get _fit => switch (fit) {
    AppImageFit.cover      => BoxFit.cover,
    AppImageFit.contain    => BoxFit.contain,
    AppImageFit.fill       => BoxFit.fill,
    AppImageFit.scaleDown  => BoxFit.scaleDown,
    AppImageFit.fitWidth   => BoxFit.fitWidth,
    AppImageFit.fitHeight  => BoxFit.fitHeight,
  };

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (isAsset) {
      image = Image.asset(source, width: width, height: height, fit: _fit,
        errorBuilder: (_, __, ___) => errorWidget ?? _placeholder(),
        semanticLabel: semanticLabel,
      );
    } else {
      image = Image.network(
        source, width: width, height: height, fit: _fit,
        loadingBuilder: (ctx, child, progress) =>
            progress == null ? child : (placeholder ?? _skeleton()),
        errorBuilder: (_, __, ___) => errorWidget ?? _placeholder(),
        semanticLabel: semanticLabel,
      );
    }

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return onTap != null
        ? GestureDetector(onTap: onTap, child: image)
        : image;
  }

  Widget _skeleton() => Container(
    width: width, height: height, color: AppColors.grey100,
  );

  Widget _placeholder() => Container(
    width: width, height: height, color: AppColors.grey100,
    child: const Center(child: Icon(Icons.image_not_supported, color: AppColors.grey300)),
  );
}
```

---

## 12.2 AppIcon / AppIconBadge

```dart
// lib/src/components/media/icon/app_icon.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/icon_sizes/app_icon_sizes.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size = AppIconSizes.lg,
    this.color,
    this.semanticLabel,
  });

  final IconData icon;
  final double size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => Icon(
    icon, size: size,
    color: color ?? Theme.of(context).colorScheme.onSurface,
    semanticLabel: semanticLabel,
  );
}

class AppIconBadge extends StatelessWidget {
  const AppIconBadge({
    super.key,
    required this.icon,
    this.count,
    this.dot = false,
    this.size = AppIconSizes.lg,
    this.iconColor,
    this.badgeColor,
    this.onTap,
  });

  final IconData icon;
  final int? count;
  final bool dot;
  final double size;
  final Color? iconColor;
  final Color? badgeColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconW = Icon(icon, size: size, color: iconColor);
    Widget w;

    if (dot) {
      w = Badge(child: iconW);
    } else if (count != null && count! > 0) {
      w = Badge(
        label: Text('${count! > 99 ? '99+' : count}'),
        backgroundColor: badgeColor ?? Theme.of(context).colorScheme.error,
        child: iconW,
      );
    } else {
      w = iconW;
    }

    return onTap != null
        ? GestureDetector(onTap: onTap, child: w)
        : w;
  }
}
```

---

## 12.3 AppHeroWrapper

```dart
// lib/src/components/media/hero_wrapper/app_hero_wrapper.dart
import 'package:flutter/material.dart';

class AppHeroWrapper extends StatelessWidget {
  const AppHeroWrapper({
    super.key,
    required this.tag,
    required this.child,
    this.transitionOnUserGestures = false,
  });

  final Object tag;
  final Widget child;
  final bool transitionOnUserGestures;

  @override
  Widget build(BuildContext context) => Hero(
    tag: tag,
    transitionOnUserGestures: transitionOnUserGestures,
    child: child,
  );
}
```

---

# PART B: Animation System

## 13.1 AppFadeAnimation

```dart
// lib/src/animations/fade/app_fade_animation.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

class AppFadeAnimation extends StatefulWidget {
  const AppFadeAnimation({
    super.key,
    required this.child,
    this.duration = AppDurations.medium,
    this.delay = Duration.zero,
    this.curve = Curves.easeIn,
    this.begin = 0.0,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double begin;

  @override
  State<AppFadeAnimation> createState() => _AppFadeAnimationState();
}

class _AppFadeAnimationState extends State<AppFadeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _anim = Tween<double>(begin: widget.begin, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: widget.curve));

    if (widget.delay == Duration.zero) {
      _ctrl.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _anim, child: widget.child);
}
```

---

## 13.2 AppSlideAnimation

```dart
// lib/src/animations/slide/app_slide_animation.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

enum AppSlideDirection { fromTop, fromBottom, fromLeft, fromRight }

class AppSlideAnimation extends StatefulWidget {
  const AppSlideAnimation({
    super.key,
    required this.child,
    this.direction = AppSlideDirection.fromBottom,
    this.duration  = AppDurations.medium,
    this.delay     = Duration.zero,
    this.curve     = Curves.easeOut,
    this.distance  = 0.3,
    this.fade      = true,
  });

  final Widget child;
  final AppSlideDirection direction;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double distance;
  final bool fade;

  @override
  State<AppSlideAnimation> createState() => _AppSlideAnimationState();
}

class _AppSlideAnimationState extends State<AppSlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);

    final begin = switch (widget.direction) {
      AppSlideDirection.fromTop    => Offset(0, -widget.distance),
      AppSlideDirection.fromBottom => Offset(0,  widget.distance),
      AppSlideDirection.fromLeft   => Offset(-widget.distance, 0),
      AppSlideDirection.fromRight  => Offset( widget.distance, 0),
    };

    final curved = CurvedAnimation(parent: _ctrl, curve: widget.curve);
    _slide = Tween<Offset>(begin: begin, end: Offset.zero).animate(curved);
    _fade  = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    Widget w = SlideTransition(position: _slide, child: widget.child);
    if (widget.fade) w = FadeTransition(opacity: _fade, child: w);
    return w;
  }
}
```

---

## 13.3 AppScaleAnimation / AppStaggeredAnimation

```dart
// lib/src/animations/scale/app_scale_animation.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

class AppScaleAnimation extends StatefulWidget {
  const AppScaleAnimation({
    super.key,
    required this.child,
    this.duration = AppDurations.medium,
    this.delay    = Duration.zero,
    this.curve    = Curves.elasticOut,
    this.begin    = 0.0,
    this.alignment = Alignment.center,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double begin;
  final Alignment alignment;

  @override
  State<AppScaleAnimation> createState() => _AppScaleAnimationState();
}

class _AppScaleAnimationState extends State<AppScaleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _anim = Tween<double>(begin: widget.begin, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: widget.curve));
    Future.delayed(widget.delay, () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: _anim, alignment: widget.alignment, child: widget.child,
  );
}


// lib/src/animations/staggered/app_staggered_animation.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

/// Animates a list of children with staggered delays.
class AppStaggeredAnimation extends StatefulWidget {
  const AppStaggeredAnimation({
    super.key,
    required this.children,
    this.staggerDelay   = const Duration(milliseconds: 80),
    this.itemDuration   = AppDurations.medium,
    this.direction      = AppSlideDirection.fromBottom,
    this.initialDelay   = Duration.zero,
  });

  final List<Widget> children;
  final Duration staggerDelay;
  final Duration itemDuration;
  final AppSlideDirection direction;
  final Duration initialDelay;

  @override
  State<AppStaggeredAnimation> createState() => _AppStaggeredAnimationState();
}

class _AppStaggeredAnimationState extends State<AppStaggeredAnimation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.children.length, (i) {
        return AppSlideAnimation(
          delay: widget.initialDelay +
              (widget.staggerDelay * i),
          duration:  widget.itemDuration,
          direction: widget.direction,
          child: widget.children[i],
        );
      }),
    );
  }
}

// Import this at the top freely — this mirrors Guide 13.2
// ignore: avoid_relative_lib_imports
import '../slide/app_slide_animation.dart';
```

---

## 13.4 AppAnimatedSwitcher / AppAnimatedContainer

```dart
// lib/src/animations/animated_switcher/app_animated_switcher.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

class AppAnimatedSwitcher extends StatelessWidget {
  const AppAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration = AppDurations.normal,
    this.transitionBuilder,
    this.layoutBuilder,
  });

  final Widget child;
  final Duration duration;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;
  final AnimatedSwitcherLayoutBuilder? layoutBuilder;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration:          duration,
    transitionBuilder: transitionBuilder ?? AnimatedSwitcher.defaultTransitionBuilder,
    layoutBuilder:     layoutBuilder     ?? AnimatedSwitcher.defaultLayoutBuilder,
    child:             child,
  );
}

// lib/src/animations/animated_container/app_animated_container.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/durations/app_durations.dart';

class AppAnimatedContainer extends StatelessWidget {
  const AppAnimatedContainer({
    super.key,
    this.child,
    this.duration   = AppDurations.medium,
    this.curve      = Curves.easeInOut,
    this.width,
    this.height,
    this.color,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
  });

  final Widget? child;
  final Duration duration;
  final Curve curve;
  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration:    duration,
    curve:       curve,
    width:       width,
    height:      height,
    color:       decoration == null ? color : null,
    padding:     padding,
    margin:      margin,
    decoration:  decoration,
    alignment:   alignment,
    child:       child,
  );
}
```

---

# PART C: Advanced Enterprise Components

## 14.1 AppAsyncStateWrapper

```dart
// lib/src/components/advanced/app_async_state_wrapper.dart
import 'package:flutter/material.dart';
import '../feedback/loader/app_loader.dart';
import '../feedback/error_state/app_error_state.dart';
import '../feedback/empty_state/app_empty_state.dart';

enum AppAsyncStatus { initial, loading, success, error, empty }

class AppAsyncStateWrapper<T> extends StatelessWidget {
  const AppAsyncStateWrapper({
    super.key,
    required this.status,
    required this.builder,
    this.data,
    this.error,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.onRetry,
  });

  final AppAsyncStatus status;
  final Widget Function(T data) builder;
  final T? data;
  final Object? error;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      AppAsyncStatus.initial || AppAsyncStatus.loading =>
        loadingWidget ?? const Center(child: AppLoader()),
      AppAsyncStatus.error   =>
        errorWidget ?? AppErrorState(onRetry: onRetry),
      AppAsyncStatus.empty   =>
        emptyWidget ?? const AppEmptyState(),
      AppAsyncStatus.success => data != null
          ? builder(data!)
          : (emptyWidget ?? const AppEmptyState()),
    };
  }
}
```

---

## 14.2 AppPermissionGate / AppRoleGuard / AppFeatureFlagWrapper

```dart
// lib/src/components/advanced/app_permission_gate.dart
import 'package:flutter/material.dart';

class AppPermissionGate extends StatelessWidget {
  const AppPermissionGate({
    super.key,
    required this.hasPermission,
    required this.child,
    this.fallback,
    this.showFallback = false,
  });

  final bool hasPermission;
  final Widget child;
  final Widget? fallback;
  final bool showFallback;

  @override
  Widget build(BuildContext context) {
    if (hasPermission) return child;
    if (showFallback) return fallback ?? const SizedBox.shrink();
    return const SizedBox.shrink();
  }
}

class AppRoleGuard extends StatelessWidget {
  const AppRoleGuard({
    super.key,
    required this.allowedRoles,
    required this.userRole,
    required this.child,
    this.fallback,
  });

  final List<String> allowedRoles;
  final String userRole;
  final Widget child;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    if (allowedRoles.contains(userRole)) return child;
    return fallback ?? const SizedBox.shrink();
  }
}

class AppFeatureFlagWrapper extends StatelessWidget {
  const AppFeatureFlagWrapper({
    super.key,
    required this.enabled,
    required this.child,
    this.fallback,
  });

  final bool enabled;
  final Widget child;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) =>
      enabled ? child : (fallback ?? const SizedBox.shrink());
}
```

---

## 14.3 AppErrorBoundary

```dart
// lib/src/components/advanced/app_error_boundary.dart
import 'package:flutter/material.dart';
import '../feedback/error_state/app_error_state.dart';

class AppErrorBoundary extends StatefulWidget {
  const AppErrorBoundary({
    super.key,
    required this.child,
    this.fallback,
    this.onError,
  });

  final Widget child;
  final Widget? fallback;
  final void Function(Object, StackTrace)? onError;

  @override
  State<AppErrorBoundary> createState() => _AppErrorBoundaryState();
}

class _AppErrorBoundaryState extends State<AppErrorBoundary> {
  bool _hasError = false;
  Object? _error;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.fallback ?? AppErrorState(
        title:   'Something went wrong',
        message: _error?.toString(),
        onRetry: () => setState(() => _hasError = false),
      );
    }

    return ErrorWidget.builder == _originalBuilder
        ? widget.child
        : widget.child;
  }

  static ErrorWidgetBuilder? _originalBuilder;
}
```

---

## 14.4 AppOfflineWrapper

```dart
// lib/src/components/advanced/app_offline_wrapper.dart
import 'package:flutter/material.dart';
import '../feedback/no_internet_state/app_no_internet_state.dart';

class AppOfflineWrapper extends StatelessWidget {
  const AppOfflineWrapper({
    super.key,
    required this.isOnline,
    required this.child,
    this.offlineBanner = true,
    this.onRetry,
  });

  final bool isOnline;
  final Widget child;
  final bool offlineBanner;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    if (!isOnline && !offlineBanner) {
      return AppNoInternetState(onRetry: onRetry);
    }

    return Stack(
      children: [
        child,
        if (!isOnline && offlineBanner)
          Positioned(
            top:   0, left: 0, right: 0,
            child: Material(
              color: Colors.red[700],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('No internet connection',
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                    ),
                    if (onRetry != null)
                      TextButton(
                        onPressed: onRetry,
                        style: TextButton.styleFrom(foregroundColor: Colors.white),
                        child: const Text('Retry'),
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
```

---

## 14.5 AppScrollToTopButton

```dart
// lib/src/components/advanced/app_scroll_to_top_button.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/colors/app_colors.dart';

class AppScrollToTopButton extends StatefulWidget {
  const AppScrollToTopButton({
    super.key,
    required this.controller,
    required this.child,
    this.showAtOffset = 300.0,
    this.icon = Icons.keyboard_arrow_up,
  });

  final ScrollController controller;
  final Widget child;
  final double showAtOffset;
  final IconData icon;

  @override
  State<AppScrollToTopButton> createState() => _AppScrollToTopButtonState();
}

class _AppScrollToTopButtonState extends State<AppScrollToTopButton> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  void _onScroll() {
    final show = widget.controller.offset > widget.showAtOffset;
    if (show != _visible) setState(() => _visible = show);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          right: 16, bottom: 16,
          child: AnimatedOpacity(
            opacity:  _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: _visible
                ? FloatingActionButton.small(
                    heroTag: 'scroll_to_top',
                    onPressed: () => widget.controller.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    backgroundColor: AppColors.primary,
                    child: Icon(widget.icon, color: AppColors.white),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
```

---

## 14.6 AppFormSection / AppValidationMessage

```dart
// lib/src/components/advanced/app_form_section.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/spacing/app_spacing.dart';
import '../../foundation/tokens/typography/app_typography.dart';
import '../../foundation/tokens/colors/app_colors.dart';

class AppFormSection extends StatelessWidget {
  const AppFormSection({
    super.key,
    required this.title,
    required this.children,
    this.description,
    this.collapsed = false,
    this.collapsible = false,
  });

  final String title;
  final String? description;
  final List<Widget> children;
  final bool collapsed;
  final bool collapsible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: AppTypography.titleMedium),
        if (description != null) ...[
          const SizedBox(height: 2),
          Text(description!, style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
          )),
        ],
        const SizedBox(height: AppSpacing.md),
        ...children.map((c) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: c,
        )),
      ],
    );
  }
}

class AppValidationMessage extends StatelessWidget {
  const AppValidationMessage(this.message, {
    super.key,
    this.isError = true,
  });

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isError ? Icons.error_outline : Icons.check_circle_outline,
          size: 14,
          color: isError ? AppColors.error : AppColors.success,
        ),
        const SizedBox(width: 4),
        Text(message, style: AppTypography.caption.copyWith(
          color: isError ? AppColors.error : AppColors.success,
        )),
      ],
    );
  }
}
```
