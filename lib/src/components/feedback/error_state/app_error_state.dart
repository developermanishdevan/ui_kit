import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppErrorState extends AppStatelessWrapper {
  final String? title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppErrorState({
    super.key,
    this.title,
    this.description,
    this.actionLabel = 'Try Again',
    this.onAction,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppEmptyState(
      variant: AppEmptyStateVariant.error,
      title: title,
      description: description,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
