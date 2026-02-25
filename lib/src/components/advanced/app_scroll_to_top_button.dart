import 'package:flutter/material.dart';

class AppScrollToTopButton extends StatefulWidget {
  const AppScrollToTopButton({
    required this.controller, required this.child, super.key,
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
          right: 16,
          bottom: 16,
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: _visible
                ? FloatingActionButton.small(
                    heroTag: 'scroll_to_top',
                    onPressed: () => widget.controller.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(widget.icon, color: Colors.white),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
