import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppOutlineButton extends AppBaseButton {
  const AppOutlineButton({
    required super.onPressed,
    super.key,
    super.label,
    super.icon,
    super.trailingIcon,
    super.isLoading,
    super.isDisabled,
    super.size = AppButtonSize.medium,
    super.width,
    this.borderColor,
    this.foregroundColor,
    this.borderWidth = 1.5,
  });

  final Color? borderColor;
  final Color? foregroundColor;
  final double borderWidth;

  @override
  State<AppOutlineButton> createState() => _State();
}

class _State extends AppBaseButtonState<AppOutlineButton> {
  @override
  Widget build(BuildContext context) {
    final fg = widget.foregroundColor ?? AppColors.primary;
    final bc = widget.borderColor ?? AppColors.primary;
    const br = AppRadius.mdAll;

    final button = Material(
      color: Colors.transparent,
      borderRadius: br,
      child: InkWell(
        borderRadius: br,
        onTap: widget.isInteractive ? widget.onPressed : null,
        child: Container(
          height: widget.size.height,
          width: widget.size == AppButtonSize.block
              ? double.infinity
              : widget.width,
          padding:
              EdgeInsets.symmetric(horizontal: widget.size.horizontalPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: br,
            border: Border.all(
              color: widget.isInteractive ? bc : bc.withValues(alpha: 0.48),
              width: widget.borderWidth,
            ),
          ),
          child: buildButtonContent(
            foregroundColor:
                widget.isInteractive ? fg : fg.withValues(alpha: 0.48),
            labelStyle: AppTypography.labelLarge
                .copyWith(fontSize: widget.size.fontSize),
          ),
        ),
      ),
    );
    return buildWrapper(child: button);
  }
}
