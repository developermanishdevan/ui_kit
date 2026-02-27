import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppPermissionDeniedState extends AppStatelessWrapper {
  final String? title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppPermissionDeniedState({
    super.key,
    this.title,
    this.description,
    this.actionLabel = 'Request Access',
    this.onAction,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppEmptyState(
      variant: AppEmptyStateVariant.permission,
      title: title,
      description: description,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
