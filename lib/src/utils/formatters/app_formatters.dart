import 'package:flutter/services.dart';

class AppFormatters {
  AppFormatters._();

  static TextInputFormatter get digitsOnly =>
      FilteringTextInputFormatter.digitsOnly;

  static TextInputFormatter get lettersOnly =>
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));

  static TextInputFormatter get alphanumericOnly =>
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));

  static TextInputFormatter get decimalOnly =>
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'));

  /// Formats phone number (e.g., 1234567890 -> 123 456 7890)
  static String formatPhoneNumber(String text) {
    if (text.length <= 3) return text;
    if (text.length <= 6) return '${text.substring(0, 3)} ${text.substring(3)}';
    return '${text.substring(0, 3)} ${text.substring(3, 6)} ${text.substring(6)}';
  }
}
