import 'package:flutter/material.dart';

class AppFormWrapper extends StatefulWidget {
  const AppFormWrapper({
    required this.child, super.key,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  final Widget child;
  final VoidCallback? onSaved;
  final AutovalidateMode autovalidateMode;

  @override
  State<AppFormWrapper> createState() => AppFormWrapperState();
}

class AppFormWrapperState extends State<AppFormWrapper> {
  final _formKey = GlobalKey<FormState>();

  bool validate() => _formKey.currentState?.validate() ?? false;
  void save() {
    _formKey.currentState?.save();
    widget.onSaved?.call();
  }

  void reset() => _formKey.currentState?.reset();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: widget.autovalidateMode,
      child: widget.child,
    );
  }
}
