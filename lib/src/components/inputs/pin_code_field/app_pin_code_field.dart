import 'package:flutter/material.dart';
import '../otp_field/app_otp_field.dart';

class AppPinCodeField extends StatelessWidget {
  const AppPinCodeField({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
    this.enabled = true,
    this.autoFocus = true,
    this.errorText,
    this.label,
  });

  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool autoFocus;
  final String? errorText;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return AppOtpField(
      length: length,
      onCompleted: onCompleted,
      onChanged: onChanged,
      obscure: true, // Key difference from standard OTP
      enabled: enabled,
      autoFocus: autoFocus,
      errorText: errorText,
      label: label,
    );
  }
}
