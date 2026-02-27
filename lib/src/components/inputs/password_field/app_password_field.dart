import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

class AppPasswordField extends AppStatefulWrapper {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const AppPasswordField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.errorText,
    this.onChanged,
    this.enabled = true,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends AppStatefulWrapperState<AppPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      labelText: widget.labelText,
      hintText: widget.hintText,
      errorText: widget.errorText,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      obscureText: _obscureText,
      prefixIcon: widget.prefixIcon,
      maxLines: 1,
      minLines: 1,
      keyboardType: TextInputType.visiblePassword,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: widget.enabled ? _toggleVisibility : null,
      ),
    );
  }
}
