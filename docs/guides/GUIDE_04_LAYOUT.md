# Guide 04 — Layout System

## 4.1 Responsive Foundation

### AppBreakpoints — `responsive/app_breakpoints.dart`

```dart
abstract final class AppBreakpoints {
  static const double xs     = 0;      // phone portrait
  static const double sm     = 480;    // phone landscape
  static const double md     = 768;    // tablet portrait
  static const double lg     = 1024;   // tablet landscape / small desktop
  static const double xl     = 1280;   // desktop
  static const double xl2    = 1536;   // large desktop
}
```

### AppDeviceType — `responsive/app_device_type.dart`

```dart
import 'package:flutter/material.dart';
import 'app_breakpoints.dart';

enum AppDeviceType { mobile, mobileLandscape, tablet, desktop, largeDesktop }

extension AppDeviceTypeX on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  AppDeviceType get deviceType {
    final w = screenWidth;
    if (w < AppBreakpoints.sm)  return AppDeviceType.mobile;
    if (w < AppBreakpoints.md)  return AppDeviceType.mobileLandscape;
    if (w < AppBreakpoints.lg)  return AppDeviceType.tablet;
    if (w < AppBreakpoints.xl)  return AppDeviceType.desktop;
    return AppDeviceType.largeDesktop;
  }

  bool get isMobile        => deviceType == AppDeviceType.mobile;
  bool get isTablet        => deviceType == AppDeviceType.tablet;
  bool get isDesktop       => deviceType == AppDeviceType.desktop ||
                              deviceType == AppDeviceType.largeDesktop;
  bool get isSmallScreen   => screenWidth < AppBreakpoints.md;
  bool get isLargeScreen   => screenWidth >= AppBreakpoints.lg;
}
```

### AppResponsiveBuilder — `responsive/app_responsive_builder.dart`

```dart
import 'package:flutter/material.dart';
import 'app_device_type.dart';

/// Renders different widgets based on screen size.
/// All builders are optional; falls back to the most applicable smaller size.
///
/// ```dart
/// AppResponsiveBuilder(
///   mobile : (_) => MobileView(),
///   tablet : (_) => TabletView(),
///   desktop: (_) => DesktopView(),
/// )
/// ```
class AppResponsiveBuilder extends StatelessWidget {
  const AppResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final WidgetBuilder? largeDesktop;

  @override
  Widget build(BuildContext context) {
    final type = context.deviceType;
    return switch (type) {
      AppDeviceType.largeDesktop => (largeDesktop ?? desktop ?? tablet ?? mobile)(context),
      AppDeviceType.desktop      => (desktop ?? tablet ?? mobile)(context),
      AppDeviceType.tablet       => (tablet ?? mobile)(context),
      _                          => mobile(context),
    };
  }
}
```

### AppResponsive — `responsive/app_responsive.dart`

```dart
import 'package:flutter/material.dart';
import 'app_device_type.dart';

/// Returns a value based on current device type.
/// Usage: `AppResponsive.value(context, mobile: 1, tablet: 2, desktop: 3)`
class AppResponsive {
  const AppResponsive._();

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    return switch (context.deviceType) {
      AppDeviceType.largeDesktop => largeDesktop ?? desktop ?? tablet ?? mobile,
      AppDeviceType.desktop      => desktop ?? tablet ?? mobile,
      AppDeviceType.tablet       => tablet ?? mobile,
      _                          => mobile,
    };
  }
}
```

---

## 4.2 Structure Widgets

### AppScaffold — `layout/structure/app_scaffold/app_scaffold.dart`

```dart
import 'package:flutter/material.dart';

/// Opinionated scaffold with sensible defaults.
/// Wraps [Scaffold] and adds safety area handling.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:                     appBar,
      body:                       body,
      floatingActionButton:       floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar:        bottomNavigationBar,
      bottomSheet:                bottomSheet,
      drawer:                     drawer,
      endDrawer:                  endDrawer,
      backgroundColor:            backgroundColor ?? Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset:   resizeToAvoidBottomInset,
      extendBody:                 extendBody,
      extendBodyBehindAppBar:     extendBodyBehindAppBar,
    );
  }
}
```

### AppScreen — `layout/structure/app_screen/app_screen.dart`

```dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/spacing/app_spacing.dart';

/// A full-screen content container with optional padding and scroll.
class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.child,
    this.padding,
    this.scrollable = false,
    this.backgroundColor,
    this.alignment,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool scrollable;
  final Color? backgroundColor;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding ??
          EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: child,
    );

    if (scrollable) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    }

    return Container(
      color: backgroundColor,
      alignment: alignment,
      child: content,
    );
  }
}
```

### AppContainer — `layout/structure/app_container/app_container.dart`

```dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/spacing/app_spacing.dart';
import '../../foundation/tokens/radius/app_radius.dart';

/// Constrained content container (max-width) for desktop layouts.
class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.child,
    this.maxWidth = 1200.0,
    this.padding,
    this.center = true,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;
  final bool center;

  @override
  Widget build(BuildContext context) {
    Widget content = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.base),
        child: child,
      ),
    );
    return center ? Center(child: content) : content;
  }
}
```

### AppKeyboardAwareView — `layout/structure/app_keyboard_aware_view/app_keyboard_aware_view.dart`

```dart
import 'package:flutter/material.dart';

/// Scrollable view that pushes content above the keyboard.
class AppKeyboardAwareView extends StatelessWidget {
  const AppKeyboardAwareView({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: padding,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: child,
      ),
    );
  }
}
```

---

## 4.3 Flex Widgets

### AppRow — `layout/flex/app_row/app_row.dart`

```dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/spacing/app_spacing.dart';

/// Row with built-in gap support.
class AppRow extends StatelessWidget {
  const AppRow({
    super.key,
    required this.children,
    this.gap = AppSpacing.sm,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
  });

  final List<Widget> children;
  final double gap;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final separated = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      separated.add(children[i]);
      if (i < children.length - 1) separated.add(SizedBox(width: gap));
    }
    return Row(
      mainAxisAlignment:  mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize:       mainAxisSize,
      children:           separated,
    );
  }
}
```

### AppColumn — `layout/flex/app_column/app_column.dart`

```dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/spacing/app_spacing.dart';

/// Column with built-in gap support.
class AppColumn extends StatelessWidget {
  const AppColumn({
    super.key,
    required this.children,
    this.gap = AppSpacing.sm,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  });

  final List<Widget> children;
  final double gap;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final separated = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      separated.add(children[i]);
      if (i < children.length - 1) separated.add(SizedBox(height: gap));
    }
    return Column(
      mainAxisAlignment:  mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize:       mainAxisSize,
      children:           separated,
    );
  }
}
```

---

## 4.4 Grid Widgets

### AppGrid — `layout/grid/app_grid/app_grid.dart`

```dart
import 'package:flutter/material.dart';

/// Fixed column grid.
class AppGrid extends StatelessWidget {
  const AppGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 12.0,
    this.crossAxisSpacing = 12.0,
    this.childAspectRatio = 1.0,
    this.shrinkWrap = true,
    this.physics,
    this.padding,
  });

  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount:    crossAxisCount,
      mainAxisSpacing:   mainAxisSpacing,
      crossAxisSpacing:  crossAxisSpacing,
      childAspectRatio:  childAspectRatio,
      shrinkWrap:        shrinkWrap,
      padding:           padding,
      physics:           physics ?? (shrinkWrap ? const NeverScrollableScrollPhysics() : null),
      children:          children,
    );
  }
}
```

### AppResponsiveGrid — `layout/grid/app_responsive_grid/app_responsive_grid.dart`

```dart
import 'package:flutter/material.dart';
import '../../responsive/app_device_type.dart';

/// Grid that changes column count based on screen width.
class AppResponsiveGrid extends StatelessWidget {
  const AppResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns   = 1,
    this.tabletColumns   = 2,
    this.desktopColumns  = 3,
    this.spacing = 16.0,
    this.childAspectRatio = 1.0,
    this.shrinkWrap = true,
    this.padding,
  });

  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final double childAspectRatio;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final cols = AppResponsive.value(
      context,
      mobile:  mobileColumns,
      tablet:  tabletColumns,
      desktop: desktopColumns,
    );

    return GridView.count(
      crossAxisCount:   cols,
      mainAxisSpacing:  spacing,
      crossAxisSpacing: spacing,
      childAspectRatio: childAspectRatio,
      shrinkWrap:       shrinkWrap,
      padding:          padding,
      physics:          shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      children:         children,
    );
  }
}
```

---

## 4.5 Scroll Widgets

### AppListView — `layout/scroll/app_list_view/app_list_view.dart`

```dart
import 'package:flutter/material.dart';

class AppListView extends StatelessWidget {
  const AppListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.scrollController,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:       itemCount,
      itemBuilder:     itemBuilder,
      padding:         padding,
      shrinkWrap:      shrinkWrap,
      physics:         physics ?? const BouncingScrollPhysics(),
      controller:      scrollController,
    );
  }
}
```

### AppInfiniteScrollList — `layout/scroll/app_infinite_scroll_list/app_infinite_scroll_list.dart`

```dart
import 'package:flutter/material.dart';

/// ListView with built-in infinite scroll trigger.
class AppInfiniteScrollList extends StatefulWidget {
  const AppInfiniteScrollList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onLoadMore,
    this.hasMore = true,
    this.loadingWidget,
    this.padding,
    this.scrollController,
    this.threshold = 200.0,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Future<void> Function() onLoadMore;
  final bool hasMore;
  final Widget? loadingWidget;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;
  final double threshold;

  @override
  State<AppInfiniteScrollList> createState() => _AppInfiniteScrollListState();
}

class _AppInfiniteScrollListState extends State<AppInfiniteScrollList> {
  late final ScrollController _controller;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.scrollController ?? ScrollController();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_loading || !widget.hasMore) return;
    final maxExtent = _controller.position.maxScrollExtent;
    final current   = _controller.position.pixels;
    if (current >= maxExtent - widget.threshold) {
      _load();
    }
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    await widget.onLoadMore();
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller:  _controller,
      padding:     widget.padding,
      physics:     const BouncingScrollPhysics(),
      itemCount:   widget.itemCount + (_loading ? 1 : 0),
      itemBuilder: (ctx, i) {
        if (i == widget.itemCount) {
          return widget.loadingWidget ??
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
        }
        return widget.itemBuilder(ctx, i);
      },
    );
  }
}
```

### AppPullToRefresh — `layout/scroll/app_pull_to_refresh/app_pull_to_refresh.dart`

```dart
import 'package:flutter/material.dart';

class AppPullToRefresh extends StatelessWidget {
  const AppPullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:       onRefresh,
      color:           color ?? Theme.of(context).colorScheme.primary,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      child:           child,
    );
  }
}
```

---

## 4.6 Accessibility Widgets

### AppSafeArea — `layout/structure/app_safe_area/app_safe_area.dart`

```dart
import 'package:flutter/material.dart';

class AppSafeArea extends StatelessWidget {
  const AppSafeArea({
    super.key,
    required this.child,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.minimumPadding = EdgeInsets.zero,
  });

  final Widget child;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final EdgeInsets minimumPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top:     top,
      bottom:  bottom,
      left:    left,
      right:   right,
      minimum: minimumPadding,
      child:   child,
    );
  }
}
```
