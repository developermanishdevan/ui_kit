import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import 'package:ui_kit/src/foundation/tokens/gradients/app_gradients.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppGradientButton extends AppBaseButton {
  const AppGradientButton({
    required super.onPressed,
    super.key,
    super.label,
    super.icon,
    super.isLoading,
    super.isDisabled,
    super.size = AppButtonSize.medium,
    super.width,
    this.gradient = AppGradients.primary,
  });

  final Gradient gradient;

  @override
  State<AppGradientButton> createState() => _State();
}

class _State extends AppBaseButtonState<AppGradientButton> {
  @override
  Widget build(BuildContext context) {
    const br = AppRadius.mdAll;
    return buildWrapper(
      child: Material(
        color: Colors.transparent,
        borderRadius: br,
        child: InkWell(
          borderRadius: br,
          onTap: widget.isInteractive ? widget.onPressed : null,
          child: Ink(
            decoration: BoxDecoration(
              gradient: widget.isInteractive
                  ? widget.gradient
                  : LinearGradient(
                      colors: (widget.gradient as LinearGradient)
                          .colors
                          .map((c) => c.withValues(alpha: 0.48))
                          .toList(),
                    ),
              borderRadius: br,
            ),
            child: Container(
              height: widget.size.height,
              width: widget.size == AppButtonSize.block
                  ? double.infinity
                  : widget.width,
              padding: EdgeInsets.symmetric(
                  horizontal: widget.size.horizontalPadding),
              alignment: Alignment.center,
              child: buildButtonContent(
                foregroundColor: AppColors.white,
                labelStyle: AppTypography.labelLarge.copyWith(
                  fontSize: widget.size.fontSize,
                  fontWeight: AppTypography.weightSemiBold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
