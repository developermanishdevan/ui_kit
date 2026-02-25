import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';
import 'package:ui_kit/src/foundation/tokens/spacing/app_spacing.dart';

class AppOtpField extends StatefulWidget {
  const AppOtpField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.obscure = false,
    this.enabled = true,
    this.autoFocus = true,
    this.boxSize = 52.0,
    this.spacing = AppSpacing.sm,
    this.errorText,
    this.label,
  });

  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool obscure;
  final bool enabled;
  final bool autoFocus;
  final double boxSize;
  final double spacing;
  final String? errorText;
  final String? label;

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNodes[0]);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get value => _controllers.map((c) => c.text).join();

  void _onChanged(String val, int index) {
    if (val.length > 1) {
      // Handle paste
      final chars = val.substring(0, widget.length).split('');
      for (int i = 0; i < chars.length && i < widget.length; i++) {
        _controllers[i].text = chars[i];
      }
      _focusNodes[widget.length - 1].requestFocus();
    } else if (val.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    final otp = value;
    widget.onChanged?.call(otp);
    if (otp.length == widget.length) widget.onCompleted?.call(otp);
  }

  Color _borderColor(bool hasFocus) {
    if (widget.errorText != null) return AppColors.error;
    return hasFocus ? AppColors.borderFocused : AppColors.borderDefault;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTypography.labelMedium),
          const SizedBox(height: AppSpacing.xs),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.length, (i) {
            return Padding(
              padding: EdgeInsets.only(
                right: i < widget.length - 1 ? widget.spacing : 0,
              ),
              child: _OtpBox(
                controller: _controllers[i],
                focusNode: _focusNodes[i],
                index: i,
                onChanged: _onChanged,
                enabled: widget.enabled,
                boxSize: widget.boxSize,
                obscure: widget.obscure,
                borderColor: _borderColor,
                onKeyBack: () {
                  if (_controllers[i].text.isEmpty && i > 0) {
                    _controllers[i - 1].clear();
                    _focusNodes[i - 1].requestFocus();
                  }
                },
              ),
            );
          }),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 4),
          Text(widget.errorText!,
              style: AppTypography.caption.copyWith(color: AppColors.error)),
        ],
      ],
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.index,
    required this.onChanged,
    required this.enabled,
    required this.boxSize,
    required this.obscure,
    required this.borderColor,
    required this.onKeyBack,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final int index;
  final void Function(String, int) onChanged;
  final bool enabled;
  final double boxSize;
  final bool obscure;
  final Color Function(bool) borderColor;
  final VoidCallback onKeyBack;

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace) {
          onKeyBack();
        }
      },
      child: SizedBox(
        width: boxSize,
        height: boxSize,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          enabled: enabled,
          obscureText: obscure,
          style: AppTypography.headlineMedium,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (val) => onChanged(val, index),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: AppColors.surfaceVariant,
            border: const OutlineInputBorder(
              borderRadius: AppRadius.mdAll,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.mdAll,
              borderSide: BorderSide(color: borderColor(true), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.mdAll,
              borderSide: BorderSide(color: borderColor(false)),
            ),
          ),
        ),
      ),
    );
  }
}
