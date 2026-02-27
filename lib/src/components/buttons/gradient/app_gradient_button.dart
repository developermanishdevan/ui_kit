import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Gradient Button component.
class AppGradientButton extends AppStatelessWrapper {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final Widget? suffixIcon;
  final AppButtonSize size;
  final Gradient? gradient;
  final bool isLoading;
  final bool isFullWidth;
  final bool isRoundedPill;
  final BorderRadius? borderRadius;

  const AppGradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.suffixIcon,
    this.size = AppButtonSize.md,
    this.gradient,
    this.isLoading = false,
    this.isFullWidth = false,
    this.isRoundedPill = false,
    this.borderRadius,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      suffixIcon: suffixIcon,
      variant: AppButtonVariant.solid,
      size: size,
      gradient: gradient ?? AppGradients.brand,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      isRoundedPill: isRoundedPill,
      borderRadius: borderRadius,
    );
  }
}
