import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Outline Button component.
class AppOutlineButton extends AppStatelessWrapper {
  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final Widget? suffixIcon;
  final AppButtonSize size;
  final AppButtonColor color;
  final bool isLoading;
  final bool isFullWidth;
  final bool isRoundedPill;
  final BorderRadius? borderRadius;

  const AppOutlineButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.suffixIcon,
    this.size = AppButtonSize.md,
    this.color = AppButtonColor.primary,
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
      color: color,
      variant: AppButtonVariant.outline,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      isRoundedPill: isRoundedPill,
      borderRadius: borderRadius,
    );
  }
}
