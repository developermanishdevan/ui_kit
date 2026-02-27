import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppCarouselItem {
  final Widget child;
  final Duration? interval;
  final Widget? caption;

  const AppCarouselItem({required this.child, this.interval, this.caption});
}

class AppCarousel extends AppStatefulWrapper {
  final List<AppCarouselItem> items;
  final bool showControls;
  final bool showIndicators;
  final bool autoplay;
  final Duration defaultInterval;
  final bool isDark;
  final bool isFade;
  final bool allowTouchSwipe;

  const AppCarousel({
    super.key,
    required this.items,
    this.showControls = true,
    this.showIndicators = true,
    this.autoplay = true,
    this.defaultInterval = const Duration(seconds: 5),
    this.isDark = false,
    this.isFade = false,
    this.allowTouchSwipe = true,
  });

  @override
  AppStatefulWrapperState<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends AppStatefulWrapperState<AppCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    if (widget.autoplay) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    final interval =
        widget.items[_currentIndex].interval ?? widget.defaultInterval;
    _timer = Timer(interval, () {
      if (!mounted) return;
      _nextPage();
    });
  }

  void _nextPage() {
    if (_currentIndex < widget.items.length - 1) {
      _pageController.nextPage(
        duration: AppDurations.normal,
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.animateToPage(
        0,
        duration: AppDurations.normal,
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: AppDurations.normal,
        curve: Curves.easeInOut,
      );
    } else {
      _pageController.animateToPage(
        widget.items.length - 1,
        duration: AppDurations.normal,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    final controlColor = widget.isDark
        ? Colors.black.withValues(alpha: 0.5)
        : Colors.white.withValues(alpha: 0.5);
    final indicatorActiveColor = widget.isDark ? Colors.black : Colors.white;
    final indicatorInactiveColor = widget.isDark
        ? Colors.black.withValues(alpha: 0.5)
        : Colors.white.withValues(alpha: 0.5);

    final typography = context.theme.extension<AppTypographyExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return AppSemantics(
      label: 'Carousel',
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: radii.base,
          child: Stack(
            children: [
              // Slides
              PageView.builder(
                controller: _pageController,
                itemCount: widget.items.length,
                physics: widget.allowTouchSwipe
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  if (widget.autoplay) {
                    _startTimer();
                  }
                },
                itemBuilder: (context, index) {
                  final item = widget.items[index];

                  Widget content = Stack(
                    fit: StackFit.expand,
                    children: [
                      item.child,
                      if (item.caption != null)
                        Positioned(
                          bottom: 40,
                          left: 0,
                          right: 0,
                          child: DefaultTextStyle(
                            style: typography.bodyBase.copyWith(
                              color: widget.isDark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            child: item.caption!,
                          ),
                        ),
                    ],
                  );

                  if (widget.isFade) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (_pageController.position.haveDimensions) {
                          value = _pageController.page! - index;
                          value = (1 - (value.abs() * 1.0)).clamp(0.0, 1.0);
                        } else {
                          // Handle initial state before pageController has dimensions
                          value = index == 0 ? 1.0 : 0.0;
                        }
                        return Opacity(opacity: value, child: child);
                      },
                      child: content,
                    );
                  }
                  return content;
                },
              ),

              // Controls
              if (widget.showControls && widget.items.length > 1)
                Align(
                  alignment: Alignment.centerLeft,
                  child: _CarouselControlButton(
                    icon: Icons.chevron_left,
                    color: controlColor,
                    onPressed: _previousPage,
                  ),
                ),
              if (widget.showControls && widget.items.length > 1)
                Align(
                  alignment: Alignment.centerRight,
                  child: _CarouselControlButton(
                    icon: Icons.chevron_right,
                    color: controlColor,
                    onPressed: _nextPage,
                  ),
                ),

              // Indicators
              if (widget.showIndicators && widget.items.length > 1)
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.items.length, (index) {
                      final isActive = _currentIndex == index;
                      return AppInteractiveWidget(
                        onTap: () => _pageController.animateToPage(
                          index,
                          duration: AppDurations.normal,
                          curve: Curves.easeInOut,
                        ),
                        semanticLabel: 'Go to slide ${index + 1}',
                        child: Container(
                          width: 30,
                          height: 3,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isActive
                                ? indicatorActiveColor
                                : indicatorInactiveColor,
                            borderRadius: radii.pill,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CarouselControlButton extends AppStatefulWrapper {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _CarouselControlButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  AppStatefulWrapperState<_CarouselControlButton> createState() =>
      _CarouselControlButtonState();
}

class _CarouselControlButtonState
    extends AppStatefulWrapperState<_CarouselControlButton> {
  @override
  Widget buildWidget(BuildContext context) {
    return AppInteractiveWidget(
      onTap: widget.onPressed,
      semanticLabel: widget.icon == Icons.chevron_left
          ? 'Previous slide'
          : 'Next slide',
      showHoverEffect:
          true, // AppInteractiveWidget handles hover nicely with opacity
      child: Container(
        width: 50,
        height: double.infinity,
        color: Colors.transparent, // Capture taps
        child: Center(
          child: Icon(
            widget.icon,
            color: widget.color.withValues(
              alpha: 1.0,
            ), // Hover effect manages opacity, so start solid
            size: 40,
          ),
        ),
      ),
    );
  }
}
