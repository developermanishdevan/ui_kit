import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  // ─── Input Formatters ──────────────────────────────────────
  static final TextInputFormatter digitsOnly =
      FilteringTextInputFormatter.digitsOnly;

  static final TextInputFormatter lettersOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'));

  static final TextInputFormatter alphanumeric =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));

  static TextInputFormatter maxLength(int n) =>
      LengthLimitingTextInputFormatter(n);

  static final TextInputFormatter phoneIn =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-() ]'));

  static final TextInputFormatter decimal =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  // ─── Display Formatters ────────────────────────────────────
  static String currency(
    num amount, {
    String symbol = '\$',
    int decimalDigits = 2,
    String locale = 'en_US',
  }) {
    final fmt = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
      locale: locale,
    );
    return fmt.format(amount);
  }

  static String compact(num amount) => NumberFormat.compact().format(amount);

  static String percentage(num value, {int decimalDigits = 1}) =>
      '${value.toStringAsFixed(decimalDigits)}%';

  static String date(DateTime dt, {String pattern = 'dd/MM/yyyy'}) =>
      DateFormat(pattern).format(dt);

  static String time(DateTime dt, {bool use24Hour = false}) =>
      DateFormat(use24Hour ? 'HH:mm' : 'hh:mm a').format(dt);

  static String dateTime(DateTime dt, {String pattern = 'dd/MM/yyyy HH:mm'}) =>
      DateFormat(pattern).format(dt);

  static String relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }

  static String fileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)}GB';
  }

  static String phone(String number) {
    final digits = number.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    }
    return number;
  }

  static String mask(String value, int visibleEnd, {String maskChar = '*'}) {
    if (value.length <= visibleEnd) return value;
    return '${maskChar * (value.length - visibleEnd)}${value.substring(value.length - visibleEnd)}';
  }

  static String initials(String fullName, {int maxChars = 2}) {
    return fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .take(maxChars)
        .map((w) => w[0].toUpperCase())
        .join();
  }

  static String truncate(String text, int maxLength,
      {String ellipsis = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - ellipsis.length)}$ellipsis';
  }
}
