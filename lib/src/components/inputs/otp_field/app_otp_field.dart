import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium OTP Input field with individual boxes for each digit.
class AppOtpField extends AppStatefulWrapper {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final String? labelText;
  final String? errorText;

  const AppOtpField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.enabled = true,
    this.labelText,
    this.errorText,
  });

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends AppStatefulWrapperState<AppOtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  final List<String> _values = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    for (int i = 0; i < widget.length; i++) {
      _values.add('');
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length > 1) {
      // Handle paste
      final pasteText = value.substring(0, widget.length - index);
      for (int i = 0; i < pasteText.length; i++) {
        final char = pasteText[i];
        _controllers[index + i].text = char;
        _values[index + i] = char;
      }
      FocusScope.of(context).unfocus();
      _triggerCallbacks();
      return;
    }

    _values[index] = value;
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    _triggerCallbacks();
  }

  void _triggerCallbacks() {
    final otp = _values.join();
    if (widget.onChanged != null) widget.onChanged!(otp);
    if (otp.length == widget.length && widget.onCompleted != null) {
      widget.onCompleted!(otp);
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return AppSemantics(
      label: widget.labelText ?? 'OTP Input',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.labelText != null) ...[
            Text(
              widget.labelText!,
              style: typography.bodyBase.copyWith(
                fontWeight: AppTypography.medium,
                color: colors.textEmphasis,
              ),
            ),
            SizedBox(height: spacing.s1),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.length, (index) {
              return SizedBox(
                width: 40,
                height: 48,
                child: TextFormField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  enabled: widget.enabled,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  showCursor: false,
                  style: typography.h5.copyWith(color: colors.textEmphasis),
                  decoration: InputDecoration(
                    counterText: '',
                    fillColor: colors.bodySecondaryBg,
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: radii.base,
                      borderSide: BorderSide(color: colors.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: radii.base,
                      borderSide: BorderSide(color: colors.primary, width: 2),
                    ),
                  ),
                  onChanged: (value) => _onChanged(value, index),
                ),
              );
            }),
          ),
          if (widget.errorText != null) ...[
            SizedBox(height: spacing.s1),
            Text(
              widget.errorText!,
              style: typography.bodySm.copyWith(color: colors.danger),
            ),
          ],
        ],
      ),
    );
  }
}
