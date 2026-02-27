import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppSuccessState extends AppStatelessWrapper {
  final String? title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppSuccessState({
    super.key,
    this.title,
    this.description,
    this.actionLabel = 'Continue',
    this.onAction,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppEmptyState(
      variant: AppEmptyStateVariant.success,
      title: title,
      description: description,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
