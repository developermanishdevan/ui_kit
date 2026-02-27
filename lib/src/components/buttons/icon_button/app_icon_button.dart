import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Icon Button component.
/// Displays an icon in a square or circular container.
class AppIconButton extends AppStatelessWrapper {
  final VoidCallback? onPressed;
  final Widget icon;
  final AppButtonSize size;
  final AppButtonColor color;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isRounded;
  final BorderRadius? borderRadius;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = AppButtonSize.md,
    this.color = AppButtonColor.primary,
    this.variant = AppButtonVariant.solid,
    this.isLoading = false,
    this.isRounded = false,
    this.borderRadius,
  });

  @override
  Widget buildWidget(BuildContext context) {
    // For Icon only buttons, we override the label with an empty string
    // and let the AppButton handle the icon rendering.
    return AppButton(
      label: '', // Empty label for icon-only
      onPressed: onPressed,
      icon: icon,
      color: color,
      variant: variant,
      size: size,
      isLoading: isLoading,
      isRoundedPill: isRounded, // Icon buttons usually use pill for circle
      borderRadius: borderRadius,
    );
  }
}
