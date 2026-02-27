import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Success Button component.
class AppSuccessButton extends AppStatelessWrapper {
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

  const AppSuccessButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.suffixIcon,
    this.size = AppButtonSize.md,
    this.isLoading = false,
    this.isFullWidth = false,
    this.isRoundedPill = false,
    this.isSoft = false,
    this.borderRadius,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      suffixIcon: suffixIcon,
      color: AppButtonColor.success,
      variant: isSoft ? AppButtonVariant.soft : AppButtonVariant.solid,
      size: size,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      isRoundedPill: isRoundedPill,
      borderRadius: borderRadius,
    );
  }
}
