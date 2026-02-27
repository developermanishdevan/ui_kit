import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Split Button component.
class AppSplitButton extends AppStatelessWrapper {
  final String label;
  final VoidCallback? onPressed;
  final VoidCallback? onDropdownPressed;
  final Widget? icon;
  final AppButtonColor color;
  final AppButtonSize size;
  final bool isLoading;

  const AppSplitButton({
    super.key,
    required this.label,
    this.onPressed,
    this.onDropdownPressed,
    this.icon,
    this.color = AppButtonColor.primary,
    this.size = AppButtonSize.md,
    this.isLoading = false,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final borderRadius = radii.base;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main action
        Expanded(
          flex: 0,
          child: AppButton(
            label: label,
            onPressed: onPressed,
            icon: icon,
            color: color,
            variant: AppButtonVariant.solid,
            size: size,
            isLoading: isLoading,
            borderRadius: BorderRadius.only(
              topLeft: borderRadius.topLeft,
              bottomLeft: borderRadius.bottomLeft,
            ),
          ),
        ),
        // Separator
        Container(
          width: 1,
          height: 24, // Fixed height for separator
          color: Colors.white.withValues(alpha: 0.2),
        ),
        // Dropdown trigger
        AppButton(
          label: '',
          onPressed: onDropdownPressed,
          icon: const Icon(Icons.expand_more, size: 20),
          color: color,
          variant: AppButtonVariant.solid,
          size: size,
          borderRadius: BorderRadius.only(
            topRight: borderRadius.topRight,
            bottomRight: borderRadius.bottomRight,
          ),
        ),
      ],
    );
  }
}
