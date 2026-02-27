import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A premium Pin Code Input field with dots or obscure characters.
class AppPinCodeField extends AppStatefulWrapper {
  final int length;
  final ValueChanged<String>? onCompleted;
  final bool enabled;
  final String? labelText;
  final bool obscureText;

  const AppPinCodeField({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.enabled = true,
    this.labelText,
    this.obscureText = true,
  });

  @override
  State<AppPinCodeField> createState() => _AppPinCodeFieldState();
}

class _AppPinCodeFieldState extends AppStatefulWrapperState<AppPinCodeField> {
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
    _values[index] = value;
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (_values.join().length == widget.length && widget.onCompleted != null) {
      widget.onCompleted!(_values.join());
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final typography = context.theme.extension<AppTypographyExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    return Column(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (index) {
            return Container(
              width: 45,
              height: 45,
              margin: EdgeInsets.symmetric(horizontal: spacing.s1),
              child: TextFormField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                enabled: widget.enabled,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                obscureText: widget.obscureText,
                obscuringCharacter: '●',
                showCursor: false,
                style: typography.h5.copyWith(color: colors.textEmphasis),
                decoration: InputDecoration(
                  counterText: '',
                  fillColor: colors.bodySecondaryBg,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: radii.pill,
                    borderSide: BorderSide(color: colors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: radii.pill,
                    borderSide: BorderSide(color: colors.primary, width: 2),
                  ),
                ),
                onChanged: (value) => _onChanged(value, index),
              ),
            );
          }),
        ),
      ],
    );
  }
}
