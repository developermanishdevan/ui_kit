# Guide 15 — Utils System (Validators, Formatters, Extensions, Helpers)

---

## 15.1 Validators

```dart
// lib/src/utils/validators/app_validators.dart

/// A collection of reusable field validators compatible with
/// Flutter's FormField.validator callback signature.
class AppValidators {
  AppValidators._();

  // ─── Required ──────────────────────────────────────────────
  static String? required(String? value, {String message = 'This field is required.'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  // ─── Email ─────────────────────────────────────────────────
  static String? email(String? value, {String message = 'Enter a valid email address.'}) {
    if (value == null || value.trim().isEmpty) return null; // use with required()
    final re = RegExp(r'^[\w.+-]+@[\w-]+\.[a-z]{2,}$', caseSensitive: false);
    return re.hasMatch(value.trim()) ? null : message;
  }

  // ─── Password ──────────────────────────────────────────────
  static String? password(
    String? value, {
    int minLength = 8,
    bool requireUppercase = false,
    bool requireNumber    = true,
    bool requireSpecial   = false,
    String? message,
  }) {
    if (value == null || value.isEmpty) return null;
    if (value.length < minLength) {
      return message ?? 'Password must be at least $minLength characters.';
    }
    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain an uppercase letter.';
    }
    if (requireNumber && !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number.';
    }
    if (requireSpecial && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain a special character.';
    }
    return null;
  }

  // ─── Password Confirm ──────────────────────────────────────
  static String? Function(String?) confirmPassword(String? original) {
    return (value) {
      if (value != original) return 'Passwords do not match.';
      return null;
    };
  }

  // ─── Phone ─────────────────────────────────────────────────
  static String? phone(String? value, {String message = 'Enter a valid phone number.'}) {
    if (value == null || value.trim().isEmpty) return null;
    final re = RegExp(r'^\+?[0-9]{7,15}$');
    return re.hasMatch(value.trim().replaceAll(RegExp(r'[\s\-()]'), ''))
        ? null : message;
  }

  // ─── URL ───────────────────────────────────────────────────
  static String? url(String? value, {String message = 'Enter a valid URL.'}) {
    if (value == null || value.trim().isEmpty) return null;
    final uri = Uri.tryParse(value.trim());
    return (uri != null && (uri.isScheme('http') || uri.isScheme('https')))
        ? null : message;
  }

  // ─── Min / Max Length ──────────────────────────────────────
  static String? Function(String?) minLength(int min, {String? message}) {
    return (value) {
      if (value == null || value.length >= min) return null;
      return message ?? 'Minimum $min characters required.';
    };
  }

  static String? Function(String?) maxLength(int max, {String? message}) {
    return (value) {
      if (value == null || value.length <= max) return null;
      return message ?? 'Maximum $max characters allowed.';
    };
  }

  // ─── Numeric Range ─────────────────────────────────────────
  static String? Function(String?) numericRange(double min, double max, {String? message}) {
    return (value) {
      if (value == null || value.isEmpty) return null;
      final n = double.tryParse(value);
      if (n == null) return 'Enter a valid number.';
      if (n < min || n > max) return message ?? 'Value must be between $min and $max.';
      return null;
    };
  }

  // ─── Compose validators ────────────────────────────────────
  /// Runs multiple validators in sequence. Returns first non-null error.
  static String? Function(String?) compose(
      List<String? Function(String?)> validators) {
    return (value) {
      for (final v in validators) {
        final error = v(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
```

---

## 15.2 Formatters

```dart
// lib/src/utils/formatters/app_formatters.dart
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

  static final TextInputFormatter phone =
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
      symbol: symbol, decimalDigits: decimalDigits, locale: locale,
    );
    return fmt.format(amount);
  }

  static String compact(num amount) =>
      NumberFormat.compact().format(amount);

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
    if (diff.inHours   < 24) return '${diff.inHours}h ago';
    if (diff.inDays    < 7)  return '${diff.inDays}d ago';
    if (diff.inDays    < 30) return '${(diff.inDays / 7).floor()}w ago';
    if (diff.inDays    < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }

  static String fileSize(int bytes) {
    if (bytes < 1024)              return '${bytes}B';
    if (bytes < 1024 * 1024)       return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
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

  static String truncate(String text, int maxLength, {String ellipsis = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength - ellipsis.length)}$ellipsis';
  }
}
```

---

## 15.3 String Extensions

```dart
// lib/src/utils/extensions/string_extensions.dart
extension StringExtensions on String {
  // Casing
  String get capitalize => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  String get titleCase  => split(' ').map((w) => w.capitalize).join(' ');
  String get camelCase  {
    final words = split(RegExp(r'[\s_-]+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return this;
    return words.first.toLowerCase() +
        words.skip(1).map((w) => w.capitalize).join();
  }
  String get snakeCase  => replaceAllMapped(
      RegExp(r'([A-Z])'), (m) => '_${m[0]!.toLowerCase()}').toLowerCase();
  String get kebabCase  => snakeCase.replaceAll('_', '-');

  // Validation
  bool get isEmail      => RegExp(r'^[\w.+-]+@[\w-]+\.[a-z]{2,}$', caseSensitive: false).hasMatch(this);
  bool get isUrl        => Uri.tryParse(this)?.hasScheme ?? false;
  bool get isNumeric    => double.tryParse(this) != null;
  bool get isBlank      => trim().isEmpty;
  bool get isNotBlank   => !isBlank;

  // Manipulation
  String get removeWhitespace => replaceAll(RegExp(r'\s'), '');
  String truncate(int max, {String ellipsis = '...'}) =>
      length <= max ? this : '${substring(0, max - ellipsis.length)}$ellipsis';
  String repeat(int times) => List.filled(times, this).join();

  // Type conversions
  int    get toIntOrZero    => int.tryParse(this)    ?? 0;
  double get toDoubleOrZero => double.tryParse(this) ?? 0.0;
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;
  String get orEmpty     => this ?? '';
}
```

---

## 15.4 DateTime Extensions

```dart
// lib/src/utils/extensions/datetime_extensions.dart
extension DateTimeExtensions on DateTime {
  // Checks
  bool get isToday    => isSameDay(DateTime.now());
  bool get isYesterday => isSameDay(DateTime.now().subtract(const Duration(days: 1)));
  bool get isTomorrow  => isSameDay(DateTime.now().add(const Duration(days: 1)));
  bool get isPast     => isBefore(DateTime.now());
  bool get isFuture   => isAfter(DateTime.now());

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  // Formatting shortcuts
  String get toDateString => '${day.toString().padLeft(2,'0')}/${month.toString().padLeft(2,'0')}/$year';
  String get toTimeString =>
      '${hour.toString().padLeft(2,'0')}:${minute.toString().padLeft(2,'0')}';
  String get toDateTimeString => '$toDateString $toTimeString';

  // Manipulation
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay   => DateTime(year, month, day, 23, 59, 59, 999);
  DateTime get startOfWeek {
    final d = weekday;
    return DateTime(year, month, day - (d - 1));
  }
  DateTime get startOfMonth => DateTime(year, month);
  DateTime get endOfMonth   => DateTime(year, month + 1, 0);

  DateTime addDays(int days)   => add(Duration(days: days));
  DateTime addMonths(int months) => DateTime(year, month + months, day);
  DateTime addYears(int years)   => DateTime(year + years, month, day);

  // Relative
  String get relative {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60)  return 'just now';
    if (diff.inMinutes < 60)  return '${diff.inMinutes}m ago';
    if (diff.inHours   < 24)  return '${diff.inHours}h ago';
    if (diff.inDays    < 7)   return '${diff.inDays}d ago';
    return toDateString;
  }
}
```

---

## 15.5 Widget & Context Extensions

```dart
// lib/src/utils/extensions/widget_extensions.dart
import 'package:flutter/material.dart';
import '../../foundation/tokens/spacing/app_spacing.dart';

extension WidgetExtensions on Widget {
  // Padding shortcuts
  Widget padAll(double v)     => Padding(padding: EdgeInsets.all(v), child: this);
  Widget padH(double v)       => Padding(padding: EdgeInsets.symmetric(horizontal: v), child: this);
  Widget padV(double v)       => Padding(padding: EdgeInsets.symmetric(vertical: v), child: this);
  Widget padOnly({
    double left = 0, double right = 0, double top = 0, double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
    child: this,
  );

  // Margin via Container
  Widget marginAll(double v)  => Container(margin: EdgeInsets.all(v), child: this);

  // Sizing
  Widget withSize(double w, double h) => SizedBox(width: w, height: h, child: this);
  Widget expanded([int flex = 1])     => Expanded(flex: flex, child: this);
  Widget flexible([int flex = 1])     => Flexible(flex: flex, child: this);
  Widget center()                     => Center(child: this);
  Widget align(AlignmentGeometry a)   => Align(alignment: a, child: this);

  // Visibility
  Widget visible(bool show)   => Visibility(visible: show, child: this);
  Widget opacity(double v)    => Opacity(opacity: v, child: this);

  // Gestures
  Widget onTap(VoidCallback fn) => GestureDetector(onTap: fn, child: this);
  Widget inkWell(VoidCallback fn, {BorderRadius? borderRadius}) => InkWell(
    onTap: fn, borderRadius: borderRadius, child: this);

  // Clipping
  Widget clip(double radius) => ClipRRect(
    borderRadius: BorderRadius.circular(radius), child: this);
  Widget clipCircle() => ClipOval(child: this);

  // Card-like surface
  Widget card({
    double radius = 12,
    Color? color,
    List<BoxShadow>? shadows,
  }) => DecoratedBox(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: shadows,
    ),
    child: this,
  );
}

// ─── BuildContext Extensions ────────────────────────────────

extension ContextExtensions on BuildContext {
  // Theme shortcuts
  ThemeData  get theme         => Theme.of(this);
  ColorScheme get colors       => Theme.of(this).colorScheme;
  TextTheme  get textTheme     => Theme.of(this).textTheme;
  bool       get isDark        => Theme.of(this).brightness == Brightness.dark;

  // MediaQuery shortcuts
  Size   get screenSize        => MediaQuery.sizeOf(this);
  double get screenWidth       => screenSize.width;
  double get screenHeight      => screenSize.height;
  double get topPadding        => MediaQuery.paddingOf(this).top;
  double get bottomPadding     => MediaQuery.paddingOf(this).bottom;
  bool   get isKeyboardVisible => MediaQuery.viewInsetsOf(this).bottom > 0;

  // Navigation shortcuts
  NavigatorState get navigator => Navigator.of(this);
  void pop<T>([T? result])     => Navigator.of(this).pop(result);
  void push(Widget page, {bool replace = false}) {
    final route = MaterialPageRoute(builder: (_) => page);
    replace
        ? Navigator.of(this).pushReplacement(route)
        : Navigator.of(this).push(route);
  }
  void pushNamed(String name, {Object? args}) =>
      Navigator.of(this).pushNamed(name, arguments: args);

  // Scaffold shortcuts
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
  void showSnack(String msg) => messenger.showSnackBar(
    SnackBar(content: Text(msg)));
  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
```

---

## 15.6 List & Num Extensions

```dart
// lib/src/utils/extensions/list_extensions.dart
extension ListExtensions<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull  => isEmpty ? null : last;

  List<T> separatedBy(T separator) {
    if (isEmpty) return this;
    final result = <T>[];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) result.add(separator);
    }
    return result;
  }

  List<List<T>> chunked(int size) {
    final result = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      result.add(sublist(i, (i + size).clamp(0, length)));
    }
    return result;
  }

  List<T> distinct() {
    final seen = <T>{};
    return where((e) => seen.add(e)).toList();
  }
}

extension NumExtensions on num {
  // Spacing helpers
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
  SizedBox get verticalSpace   => SizedBox(height: toDouble());

  // Range checks
  bool between(num min, num max) => this >= min && this <= max;
  num clamp01() => clamp(0, 1);

  // Duration
  Duration get ms      => Duration(milliseconds: round());
  Duration get seconds => Duration(seconds: round());
  Duration get minutes => Duration(minutes: round());
}
```

---

## 15.7 Helpers

```dart
// lib/src/utils/helpers/app_helpers.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHelpers {
  AppHelpers._();

  // ─── Haptics ────────────────────────────────────────────────
  static void lightImpact()  => HapticFeedback.lightImpact();
  static void mediumImpact() => HapticFeedback.mediumImpact();
  static void heavyImpact()  => HapticFeedback.heavyImpact();
  static void selectionClick() => HapticFeedback.selectionClick();

  // ─── Clipboard ──────────────────────────────────────────────
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String?> pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }

  // ─── Keyboard ───────────────────────────────────────────────
  static void hideKeyboard(BuildContext context) =>
      FocusManager.instance.primaryFocus?.unfocus();

  // ─── Color ──────────────────────────────────────────────────
  /// Returns black or white based on background luminance.
  static Color contrastColor(Color bg) {
    return bg.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  static Color hexColor(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse(h.length == 6 ? 'FF$h' : h, radix: 16));
  }

  // ─── Async Debounce ─────────────────────────────────────────
  static const _timers = <String, DateTime>{};
  static void debounce(
    String key,
    VoidCallback action, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    _timers[key] = DateTime.now();
    Future.delayed(delay, () {
      final last = _timers[key];
      if (last != null &&
          DateTime.now().difference(last) >= delay) {
        action();
      }
    });
  }

  // ─── Platform ───────────────────────────────────────────────
  static bool get isAndroid =>
      defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS =>
      defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isWeb =>
      identical(0, 0.0); // kIsWeb equivalent

  // ─── Responsive ─────────────────────────────────────────────
  static bool isMobile(BuildContext context)  => MediaQuery.sizeOf(context).width < 600;
  static bool isTablet(BuildContext context)  =>
      MediaQuery.sizeOf(context).width >= 600 && MediaQuery.sizeOf(context).width < 1200;
  static bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= 1200;

  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= 1200 && desktop != null) return desktop;
    if (w >= 600  && tablet  != null) return tablet;
    return mobile;
  }
}
```
