import 'package:flutter/material.dart';
import 'app_base_widget.dart';

/// A wrapper around [StatefulWidget] to integrate consistently with the UI Kit.
abstract class AppStatefulWrapper extends StatefulWidget {
  const AppStatefulWrapper({super.key});
}

/// A wrapper around [State] providing base UI kit mixins out of the box.
abstract class AppStatefulWrapperState<T extends AppStatefulWrapper>
    extends State<T>
    with AppBaseWidgetMixin {
  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  /// Builds the widget tree taking advantage of the wrapper.
  Widget buildWidget(BuildContext context);
}
