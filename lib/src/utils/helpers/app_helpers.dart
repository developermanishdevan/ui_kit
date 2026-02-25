import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHelpers {
  AppHelpers._();

  // ─── Haptics ────────────────────────────────────────────────
  static void lightImpact() => HapticFeedback.lightImpact();
  static void mediumImpact() => HapticFeedback.mediumImpact();
  static void heavyImpact() => HapticFeedback.heavyImpact();
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
  static final _timers = <String, DateTime>{};
  static void debounce(
    String key,
    VoidCallback action, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    _timers[key] = DateTime.now();
    Future.delayed(delay, () {
      final last = _timers[key];
      if (last != null && DateTime.now().difference(last) >= delay) {
        action();
      }
    });
  }

  // ─── Platform ───────────────────────────────────────────────
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isWeb => kIsWeb;

  // ─── Responsive ─────────────────────────────────────────────
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 1200;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1200;

  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= 1200 && desktop != null) return desktop;
    if (w >= 600 && tablet != null) return tablet;
    return mobile;
  }
}
