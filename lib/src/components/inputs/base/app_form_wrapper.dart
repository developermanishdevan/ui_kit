import 'package:flutter/material.dart';

import '../../../../ui_kit.dart';

/// A wrapper for forms that provides easy access to validation and saving.
class AppFormWrapper extends AppStatefulWrapper {
  final Widget child;
  final VoidCallback? onSaved;
  final AutovalidateMode autovalidateMode;

  const AppFormWrapper({
    super.key,
    required this.child,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  @override
  State<AppFormWrapper> createState() => _AppFormWrapperState();
}

class _AppFormWrapperState extends AppStatefulWrapperState<AppFormWrapper> {
  final _formKey = GlobalKey<FormState>();

  bool validate() => _formKey.currentState?.validate() ?? false;

  void save() {
    _formKey.currentState?.save();
    widget.onSaved?.call();
  }

  void reset() => _formKey.currentState?.reset();

  @override
  Widget buildWidget(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: widget.autovalidateMode,
      child: widget.child,
    );
  }
}
