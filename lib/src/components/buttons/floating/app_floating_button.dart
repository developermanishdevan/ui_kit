import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Floating Action Button component.
class AppFloatingButton extends AppStatelessWrapper {
  final VoidCallback? onPressed;
  final Widget icon;
  final String? label;
  final AppButtonColor color;
  final AppButtonSize size;
  final bool isLoading;

  const AppFloatingButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.label,
    this.color = AppButtonColor.primary,
    this.size = AppButtonSize.lg,
    this.isLoading = false,
  });

  @override
  Widget buildWidget(BuildContext context) {
    return AppButton(
      label: label ?? '',
      onPressed: onPressed,
      icon: icon,
      color: color,
      variant: AppButtonVariant.solid,
      size: size,
      isLoading: isLoading,
      isRoundedPill: true, // FABs are usually rounded
      // FABs usually have more elevation, AppButton already adds 3D shadow which fits the premium look.
    );
  }
}
