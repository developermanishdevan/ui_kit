import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import '../base/app_button_size.dart';
import '../primary/app_primary_button.dart';

class AppDestructiveButton extends StatelessWidget {
  const AppDestructiveButton({
    required this.onPressed,
    super.key,
    this.label,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = AppButtonSize.medium,
    this.width,
  });

  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final AppButtonSize size;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      isLoading: isLoading,
      isDisabled: isDisabled,
      size: size,
      width: width,
      backgroundColor: AppColors.error,
      foregroundColor: AppColors.white,
    );
  }
}
