import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Secondary Button component.
class AppSecondaryButton extends AppStatelessWrapper {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final Widget? suffixIcon;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final bool isRoundedPill;
  final bool isSoft;
  final BorderRadius? borderRadius;

  const AppSecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.suffixIcon,
    this.size = AppButtonSize.md,
    this.isLoading = false,
    this.isFullWidth = false,
    this.isRoundedPill = false,
    this.isSoft = true, // Secondary defaults to soft often
    this.borderRadius,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      suffixIcon: suffixIcon,
      color: AppButtonColor.secondary,
      variant: isSoft ? AppButtonVariant.soft : AppButtonVariant.solid,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      isRoundedPill: isRoundedPill,
      borderRadius: borderRadius,
    );
  }
}
