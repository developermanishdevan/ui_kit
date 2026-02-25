import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppSecondaryButton extends AppBaseButton {
  const AppSecondaryButton({
    required super.onPressed,
    super.key,
    super.label,
    super.icon,
    super.trailingIcon,
    super.isLoading,
    super.isDisabled,
    super.size = AppButtonSize.medium,
    super.width,
  });

  @override
  State<AppSecondaryButton> createState() => _State();
}

class _State extends AppBaseButtonState<AppSecondaryButton> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = cs.secondaryContainer;
    final fg = cs.onSecondaryContainer;
    const br = AppRadius.mdAll;

    final button = Material(
      color: widget.isInteractive ? bg : bg.withValues(alpha: 0.48),
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
          child: buildButtonContent(
            foregroundColor: fg,
            labelStyle: AppTypography.labelLarge
                .copyWith(fontSize: widget.size.fontSize),
          ),
        ),
      ),
    );
    return buildWrapper(child: button);
  }
}
