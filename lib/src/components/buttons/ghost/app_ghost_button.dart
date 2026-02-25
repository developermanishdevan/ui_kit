import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppGhostButton extends AppBaseButton {
  const AppGhostButton({
    required super.onPressed,
    super.key,
    super.label,
    super.icon,
    super.trailingIcon,
    super.isLoading,
    super.isDisabled,
    super.size = AppButtonSize.medium,
    super.width,
    this.foregroundColor,
  });

  final Color? foregroundColor;

  @override
  State<AppGhostButton> createState() => _State();
}

class _State extends AppBaseButtonState<AppGhostButton> {
  @override
  Widget build(BuildContext context) {
    final fg = widget.foregroundColor ?? AppColors.primary;
    const br = AppRadius.mdAll;
    return buildWrapper(
      child: TextButton(
        onPressed: widget.isInteractive ? widget.onPressed : null,
        style: TextButton.styleFrom(
          foregroundColor: fg,
          minimumSize: Size(0, widget.size.height),
          padding:
              EdgeInsets.symmetric(horizontal: widget.size.horizontalPadding),
          shape: const RoundedRectangleBorder(borderRadius: br),
          textStyle:
              AppTypography.labelLarge.copyWith(fontSize: widget.size.fontSize),
        ),
        child: buildButtonContent(
          foregroundColor: fg,
          labelStyle:
              AppTypography.labelLarge.copyWith(fontSize: widget.size.fontSize),
        ),
      ),
    );
  }
}
