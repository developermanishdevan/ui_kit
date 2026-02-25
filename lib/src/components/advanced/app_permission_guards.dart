import 'package:flutter/material.dart';

class AppPermissionGate extends StatelessWidget {
  const AppPermissionGate({
    required this.hasPermission, required this.child, super.key,
    this.fallback,
    this.showFallback = false,
  });

  final bool hasPermission;
  final Widget child;
  final Widget? fallback;
  final bool showFallback;

  @override
  Widget build(BuildContext context) {
    if (hasPermission) return child;
    if (showFallback) return fallback ?? const SizedBox.shrink();
    return const SizedBox.shrink();
  }
}

class AppRoleGuard extends StatelessWidget {
  const AppRoleGuard({
    required this.allowedRoles, required this.userRole, required this.child, super.key,
    this.fallback,
  });

  final List<String> allowedRoles;
  final String userRole;
  final Widget child;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    if (allowedRoles.contains(userRole)) return child;
    return fallback ?? const SizedBox.shrink();
  }
}

class AppFeatureFlagWrapper extends StatelessWidget {
  const AppFeatureFlagWrapper({
    required this.enabled, required this.child, super.key,
    this.fallback,
  });

  final bool enabled;
  final Widget child;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) =>
      enabled ? child : (fallback ?? const SizedBox.shrink());
}
