import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppNoInternetState extends AppStatelessWrapper {
  final String? title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AppNoInternetState({
    super.key,
    this.title,
    this.description,
    this.actionLabel = 'Retry Connection',
    this.onAction,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppEmptyState(
      variant: AppEmptyStateVariant.noInternet,
      title: title,
      description: description,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
