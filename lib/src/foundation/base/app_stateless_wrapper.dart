import 'package:flutter/material.dart';
import 'app_base_widget.dart';

/// A wrapper around [StatelessWidget] providing base UI kit mixins out of the box.
abstract class AppStatelessWrapper extends StatelessWidget
    with AppBaseWidgetMixin {
  const AppStatelessWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  /// Builds the widget tree taking advantage of the wrapper.
  Widget buildWidget(BuildContext context);
}
