import 'package:flutter/material.dart';

/// ListView with built-in infinite scroll trigger.
class AppInfiniteScrollList extends StatefulWidget {
  const AppInfiniteScrollList({
    required this.itemCount, required this.itemBuilder, required this.onLoadMore, super.key,
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
    final current = _controller.position.pixels;
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
      controller: _controller,
      padding: widget.padding,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.itemCount + (_loading ? 1 : 0),
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
