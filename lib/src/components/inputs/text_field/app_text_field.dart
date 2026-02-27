import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium text input field following the UI Kit design system.
/// Supports labels, hints, icons, validation states, and standard TextFormField features.
class AppTextField extends AppStatelessWrapper {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? errorText;
  final String? successText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final bool isValid;
  final bool isInvalid;

  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.successText,
    this.onChanged,
    this.onTap,
    this.validator,
    this.autovalidateMode,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.isValid = false,
    this.isInvalid = false,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final baseBorder = OutlineInputBorder(
      borderRadius: radii.base,
      borderSide: BorderSide(color: colors.borderColor, width: 1),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: radii.base,
      borderSide: BorderSide(color: colors.primary, width: 1.5),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: radii.base,
      borderSide: BorderSide(color: colors.danger, width: 1.5),
    );

    final successBorder = OutlineInputBorder(
      borderRadius: radii.base,
      borderSide: BorderSide(color: colors.success, width: 1.5),
    );

    // Determine current border based on state
    var currentBorder = baseBorder;
    if (isInvalid || errorText != null) {
      currentBorder = errorBorder;
    } else if (isValid || successText != null) {
      currentBorder = successBorder;
    }

    Widget inputField = TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      enabled: enabled,
      validator: validator,
      autovalidateMode: autovalidateMode,
      style: typography.bodyBase.copyWith(
        color: enabled
            ? colors.textEmphasis
            : colors.textEmphasis.withValues(alpha: 0.5),
      ),
      cursorColor: colors.primary,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: typography.bodyBase.copyWith(
          color: colors.bodySecondaryColor,
        ),
        fillColor: colors.bodySecondaryBg,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: spacing.s3,
          vertical: spacing.s2,
        ),
        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: IconThemeData(color: colors.bodySecondaryColor, size: 20),
                child: prefixIcon!,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(color: colors.bodySecondaryColor, size: 20),
                child: suffixIcon!,
              )
            : null,
        border: currentBorder,
        enabledBorder: currentBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        errorText: (isInvalid || errorText != null) ? errorText : null,
        errorStyle: typography.bodySm.copyWith(color: colors.danger),
      ),
    );

    return AppSemantics(
      label: labelText ?? hintText ?? 'Text Input',
      textField: true,
      enabled: enabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (labelText != null) ...[
            Text(
              labelText!,
              style: typography.bodyBase.copyWith(
                fontWeight: AppTypography.medium,
                color: colors.textEmphasis,
              ),
            ),
            SizedBox(height: spacing.s1),
          ],
          inputField,
          if (successText != null &&
              (isValid || successText != null) &&
              errorText == null) ...[
            SizedBox(height: spacing.s1),
            Text(
              successText!,
              style: typography.bodySm.copyWith(color: colors.success),
            ),
          ],
        ],
      ),
    );
  }
}
