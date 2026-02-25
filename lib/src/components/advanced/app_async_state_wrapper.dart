import 'package:flutter/material.dart';
import '../feedback/loader/app_loader.dart';
import '../feedback/empty_state/app_empty_state.dart';

enum AppAsyncStatus { initial, loading, success, error, empty }

class AppAsyncStateWrapper<T> extends StatelessWidget {
  const AppAsyncStateWrapper({
    required this.status, required this.builder, super.key,
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
      AppAsyncStatus.initial ||
      AppAsyncStatus.loading =>
        loadingWidget ?? const Center(child: AppLoader()),
      AppAsyncStatus.error => errorWidget ?? AppErrorState(onRetry: onRetry),
      AppAsyncStatus.empty => emptyWidget ?? const AppEmptyState(),
      AppAsyncStatus.success =>
        data != null ? builder(data as T) : (emptyWidget ?? const AppEmptyState()),
    };
  }
}
