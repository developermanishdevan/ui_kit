import 'package:flutter/material.dart';

class AppSemantics extends StatelessWidget {
  final Widget child;
  final String label;
  final String? value;
  final String? hint;
  final bool? heading;
  final bool? button;
  final bool? textField;
  final bool? checked;
  final bool? selected;
  final bool? enabled;
  final bool? image;

  const AppSemantics({
    super.key,
    required this.child,
    required this.label,
    this.value,
    this.hint,
    this.heading,
    this.button,
    this.textField,
    this.checked,
    this.selected,
    this.enabled,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      value: value,
      hint: hint,
      header: heading,
      button: button,
      textField: textField,
      checked: checked,
      selected: selected,
      enabled: enabled,
      image: image,
      child: child,
    );
  }
}
