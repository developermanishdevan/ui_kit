import 'package:flutter/material.dart';
import '../feedback/empty_state/app_empty_state.dart';

class AppErrorBoundary extends StatefulWidget {
  const AppErrorBoundary({
    required this.child, super.key,
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.fallback ??
          AppErrorState(
            title: 'Something went wrong',
            message: _error?.toString(),
            onRetry: () => setState(() => _hasError = false),
          );
    }

    return widget.child;
  }
}
