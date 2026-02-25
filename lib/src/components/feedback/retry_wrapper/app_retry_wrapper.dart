import 'package:flutter/material.dart';

enum _RetryState { loading, data, error }

class AppRetryWrapper extends StatefulWidget {
  const AppRetryWrapper({
    required this.future, required this.builder, super.key,
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
      if (mounted) {
        setState(() {
          _state = _RetryState.error;
          _error = e;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (_state) {
      _RetryState.loading => widget.loadingBuilder?.call(context) ??
          const Center(child: CircularProgressIndicator()),
      _RetryState.error => widget.errorBuilder?.call(context, _error) ??
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('Something went wrong'),
              const SizedBox(height: 12),
              FilledButton(onPressed: _load, child: const Text('Retry')),
            ]),
          ),
      _RetryState.data => widget.builder(context),
    };
  }
}
