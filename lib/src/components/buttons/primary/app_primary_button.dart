import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppPrimaryButton extends AppBaseButton {
  const AppPrimaryButton({
    required super.onPressed,
    super.key,
    super.label,
    super.icon,
    super.trailingIcon,
    super.isLoading = false,
    super.isDisabled = false,
    super.size = AppButtonSize.medium,
    super.width,
    super.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends AppBaseButtonState<AppPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final bg = widget.backgroundColor ?? AppColors.primary;
    final fg = widget.foregroundColor ?? AppColors.white;
    final br = widget.borderRadius ?? AppRadius.mdAll;
    final isBlock = widget.size == AppButtonSize.block;

    final button = Material(
      color: widget.isInteractive ? bg : bg.withValues(alpha: 0.48),
      borderRadius: br,
      child: InkWell(
        borderRadius: br,
        onTap: widget.isInteractive ? widget.onPressed : null,
        child: Container(
          height: widget.size.height,
          width: isBlock ? double.infinity : widget.width,
          padding:
              EdgeInsets.symmetric(horizontal: widget.size.horizontalPadding),
          alignment: Alignment.center,
          child: buildButtonContent(
            foregroundColor: fg,
            labelStyle: AppTypography.labelLarge.copyWith(
              fontSize: widget.size.fontSize,
              fontWeight: AppTypography.weightSemiBold,
            ),
          ),
        ),
      ),
    );

    return buildWrapper(child: button);
  }
}
