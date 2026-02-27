import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppMaintenanceState extends AppStatelessWrapper {
  final String? title;
  final String? description;

  const AppMaintenanceState({super.key, this.title, this.description});

  @override
  Widget buildWidget(BuildContext context) {
    return AppEmptyState(
      variant: AppEmptyStateVariant.maintenance,
      title: title,
      description: description,
    );
  }
}
