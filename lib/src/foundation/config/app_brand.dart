import 'package:flutter/material.dart';

/// Branding configuration injected at app level.
/// Override this at startup before MaterialApp initialises.
class AppBrandConfig {
  const AppBrandConfig({
    this.appName = 'App',
    this.primaryColor = const Color(0xFF2563EB),
    this.accentColor = const Color(0xFF7C3AED),
    this.fontFamily,
    this.logoAssetPath,
    this.faviconAssetPath,
  });

  final String appName;
  final Color primaryColor;
  final Color accentColor;
  final String? fontFamily;
  final String? logoAssetPath;
  final String? faviconAssetPath;
}

/// Global singleton that holds current brand config.
class AppBrand {
  static AppBrandConfig _config = const AppBrandConfig();

  static AppBrandConfig get config => _config;

  static void configure(AppBrandConfig config) {
    _config = config;
  }
}
