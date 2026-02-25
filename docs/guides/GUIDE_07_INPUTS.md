# Guide 07 — Input System (25+ Variants)

## 7.1 Base Input Infrastructure

### AppInputState / AppInputVariant

```dart
// lib/src/components/inputs/base/app_input_state.dart
enum AppInputVariant { outlined, filled, underlined }

extension AppInputDecoration on AppInputVariant {
  InputBorder border(Color color, {double width = 1}) {
    return switch (this) {
      AppInputVariant.outlined   => OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:   BorderSide(color: color, width: width),
        ),
      AppInputVariant.filled     => OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:   BorderSide.none,
        ),
      AppInputVariant.underlined => UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
        ),
    };
  }
}
```

---

## 7.2 AppTextField

```dart
// lib/src/components/inputs/text_field/app_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.focusNode,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.showCounter = false,
    this.filled = true,
    this.fillColor,
    this.validator,
    this.initialValue,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autofocus;
  final bool showCounter;
  final bool filled;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextCapitalization textCapitalization;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:      controller,
      initialValue:    controller == null ? initialValue : null,
      decoration: InputDecoration(
        labelText:    label,
        hintText:     hint,
        helperText:   helperText,
        errorText:    errorText,
        prefixIcon:   prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon:   suffixIcon != null ? Icon(suffixIcon) : suffix,
        prefix:       prefix,
        filled:       filled,
        fillColor:    enabled
            ? (fillColor ?? AppColors.surfaceVariant)
            : AppColors.grey100,
        counterText:  showCounter ? null : '',
      ),
      style:      AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
      keyboardType:      keyboardType,
      textInputAction:   textInputAction,
      inputFormatters:   inputFormatters,
      maxLength:         maxLength,
      maxLines:          maxLines,
      minLines:          minLines,
      enabled:           enabled,
      readOnly:          readOnly,
      obscureText:       obscureText,
      autofocus:         autofocus,
      focusNode:         focusNode,
      onChanged:         onChanged,
      onFieldSubmitted:  onSubmitted,
      onTap:             onTap,
      validator:         validator,
      textCapitalization: textCapitalization,
      autocorrect:       autocorrect,
    );
  }
}
```

---

## 7.3 AppPasswordField

```dart
// lib/src/components/inputs/password_field/app_password_field.dart
import 'package:flutter/material.dart';
import '../text_field/app_text_field.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    this.controller,
    this.label = 'Password',
    this.hint,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.validator,
    this.enabled = true,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputAction? textInputAction;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller:   widget.controller,
      label:        widget.label,
      hint:         widget.hint,
      helperText:   widget.helperText,
      errorText:    widget.errorText,
      onChanged:    widget.onChanged,
      onSubmitted:  widget.onSubmitted,
      focusNode:    widget.focusNode,
      validator:    widget.validator,
      enabled:      widget.enabled,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      obscureText:  _obscure,
      keyboardType: TextInputType.visiblePassword,
      suffixIcon:   _obscure ? Icons.visibility_off : Icons.visibility,
      suffix: IconButton(
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}
```

---

## 7.4 AppSearchField

```dart
// lib/src/components/inputs/search_field/app_search_field.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.hint = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
    this.fillColor,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool autofocus;
  final Color? fillColor;
  final FocusNode? focusNode;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _ctrl;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ctrl = widget.controller ?? TextEditingController();
    _ctrl.addListener(() {
      final has = _ctrl.text.isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:   _ctrl,
      autofocus:    widget.autofocus,
      focusNode:    widget.focusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      style:        AppTypography.bodyMedium,
      onChanged:    widget.onChanged,
      onSubmitted:  widget.onSubmitted,
      decoration: InputDecoration(
        hintText:   widget.hint,
        filled:     true,
        fillColor:  widget.fillColor ?? AppColors.surfaceVariant,
        prefixIcon: const Icon(Icons.search, size: 20),
        suffixIcon: _hasText
            ? IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () {
                  _ctrl.clear();
                  widget.onClear?.call();
                  widget.onChanged?.call('');
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: AppRadius.fullAll,
          borderSide:   BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base, vertical: AppSpacing.sm,
        ),
      ),
    );
  }
}
```

---

## 7.5 AppDropdown

```dart
// lib/src/components/inputs/dropdown/app_dropdown.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppDropdownItem<T> {
  const AppDropdownItem({required this.value, required this.label, this.icon});
  final T value;
  final String label;
  final IconData? icon;
}

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.enabled = true,
    this.validator,
  });

  final List<AppDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final IconData? prefixIcon;
  final bool enabled;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value:     value,
      hint:      hint != null ? Text(hint!, style: AppTypography.bodyMedium) : null,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      style:     AppTypography.bodyMedium.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText:  label,
        errorText:  errorText,
        helperText: helperText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled:     true,
      ),
      items: items.map((item) => DropdownMenuItem<T>(
        value: item.value,
        child: Row(
          children: [
            if (item.icon != null) ...[
              Icon(item.icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(item.label, style: AppTypography.bodyMedium),
          ],
        ),
      )).toList(),
    );
  }
}
```

---

## 7.6 AppOtpField

```dart
// lib/src/components/inputs/otp_field/app_otp_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

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
    _focusNodes  = List.generate(widget.length, (_) => FocusNode());
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNodes[0]);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
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
    final otp = this.value;
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.length, (i) {
            return Padding(
              padding: EdgeInsets.only(
                right: i < widget.length - 1 ? widget.spacing : 0,
              ),
              child: _OtpBox(
                controller:  _controllers[i],
                focusNode:   _focusNodes[i],
                index:       i,
                onChanged:   _onChanged,
                enabled:     widget.enabled,
                boxSize:     widget.boxSize,
                obscure:     widget.obscure,
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
        width: boxSize, height: boxSize,
        child: TextField(
          controller:   controller,
          focusNode:    focusNode,
          keyboardType: TextInputType.number,
          textAlign:    TextAlign.center,
          maxLength:    1,
          enabled:      enabled,
          obscureText:  obscure,
          style:        AppTypography.headlineMedium,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (val) => onChanged(val, index),
          decoration: InputDecoration(
            counterText: '',
            filled:      true,
            fillColor:   AppColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: AppRadius.mdAll,
              borderSide:   BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.mdAll,
              borderSide:   BorderSide(color: borderColor(true), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.mdAll,
              borderSide:   BorderSide(color: borderColor(false)),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## 7.7 AppSlider

```dart
// lib/src/components/inputs/slider/app_slider.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

class AppSlider extends StatelessWidget {
  const AppSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.label,
    this.showLabel = true,
    this.showMinMax = true,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.formatLabel,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool showLabel;
  final bool showMinMax;
  final bool enabled;
  final Color? activeColor;
  final Color? inactiveColor;
  final String Function(double)? formatLabel;

  String _format(double v) => formatLabel?.call(v) ?? v.toStringAsFixed(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label!, style: AppTypography.labelMedium),
              if (showLabel)
                Text(_format(value), style: AppTypography.labelMedium.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                )),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        Slider(
          value:     value,
          min:       min,
          max:       max,
          divisions: divisions,
          label:     showLabel ? _format(value) : null,
          onChanged: enabled ? onChanged : null,
          activeColor:   activeColor,
          inactiveColor: inactiveColor,
        ),
        if (showMinMax)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_format(min), style: AppTypography.caption.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )),
                Text(_format(max), style: AppTypography.caption.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )),
              ],
            ),
          ),
      ],
    );
  }
}
```

---

## 7.8 AppRatingInput

```dart
// lib/src/components/inputs/rating_input/app_rating_input.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../../foundation/tokens/icon_sizes/app_icon_sizes.dart';

class AppRatingInput extends StatelessWidget {
  const AppRatingInput({
    super.key,
    required this.rating,
    required this.onChanged,
    this.maxRating = 5,
    this.iconSize = AppIconSizes.lg,
    this.activeColor = AppColors.amber500,
    this.inactiveColor = AppColors.grey200,
    this.spacing = AppSpacing.xs,
    this.allowHalfRating = false,
    this.readOnly = false,
  });

  final double rating;
  final ValueChanged<double>? onChanged;
  final int maxRating;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final double spacing;
  final bool allowHalfRating;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (i) {
        final starValue = i + 1.0;
        final isActive  = rating >= starValue;
        final isHalf    = allowHalfRating && rating >= starValue - 0.5 && rating < starValue;

        return Padding(
          padding: EdgeInsets.only(right: i < maxRating - 1 ? spacing : 0),
          child: GestureDetector(
            onTap: readOnly ? null : () => onChanged?.call(starValue),
            child: Icon(
              isActive ? Icons.star
                : isHalf ? Icons.star_half
                : Icons.star_border,
              size:  iconSize,
              color: (isActive || isHalf) ? activeColor : inactiveColor,
            ),
          ),
        );
      }),
    );
  }
}
```

---

## 7.9 AppDatePickerField

```dart
// lib/src/components/inputs/date_picker/app_date_picker_field.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../text_field/app_text_field.dart';

class AppDatePickerField extends StatefulWidget {
  const AppDatePickerField({
    super.key,
    this.label,
    this.hint,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.dateFormat,
    this.errorText,
    this.enabled = true,
  });

  final String? label;
  final String? hint;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime?>? onChanged;
  final String Function(DateTime)? dateFormat;
  final String? errorText;
  final bool enabled;

  @override
  State<AppDatePickerField> createState() => _AppDatePickerFieldState();
}

class _AppDatePickerFieldState extends State<AppDatePickerField> {
  DateTime? _selected;
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
    if (_selected != null) _ctrl.text = _format(_selected!);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _format(DateTime dt) {
    return widget.dateFormat?.call(dt)
        ?? '${dt.day.toString().padLeft(2,'0')}/${dt.month.toString().padLeft(2,'0')}/${dt.year}';
  }

  Future<void> _pick() async {
    final picked = await showDatePicker(
      context:   context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate:  widget.lastDate ?? DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selected = picked;
        _ctrl.text = _format(picked);
      });
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller:  _ctrl,
      label:       widget.label,
      hint:        widget.hint ?? 'DD/MM/YYYY',
      errorText:   widget.errorText,
      enabled:     widget.enabled,
      readOnly:    true,
      suffixIcon:  Icons.calendar_today,
      onTap:       widget.enabled ? _pick : null,
    );
  }
}
```

---

## 7.10 AppFormWrapper

```dart
// lib/src/components/inputs/base/app_form_wrapper.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

class AppFormWrapper extends StatefulWidget {
  const AppFormWrapper({
    super.key,
    required this.child,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  final Widget child;
  final VoidCallback? onSaved;
  final AutovalidateMode autovalidateMode;

  @override
  State<AppFormWrapper> createState() => AppFormWrapperState();
}

class AppFormWrapperState extends State<AppFormWrapper> {
  final _formKey = GlobalKey<FormState>();

  bool validate() => _formKey.currentState?.validate() ?? false;
  void save() {
    _formKey.currentState?.save();
    widget.onSaved?.call();
  }
  void reset() => _formKey.currentState?.reset();

  @override
  Widget build(BuildContext context) {
    return Form(
      key:              _formKey,
      autovalidateMode: widget.autovalidateMode,
      child: widget.child,
    );
  }
}
```

---

## 7.11 Remaining Input Components (Pattern Reference)

The following inputs follow the same pattern as `AppTextField`. Each wraps it or builds upon Flutter primitives:

| Component | Key Difference from AppTextField |
|-----------|----------------------------------|
| `AppEmailField` | `keyboardType: TextInputType.emailAddress` + email validator |
| `AppPhoneField` | `keyboardType: TextInputType.phone` + digit formatter + prefix dial code |
| `AppUrlField` | `keyboardType: TextInputType.url` + URL validator |
| `AppMultilineField` | `maxLines: null`, `minLines: 3`, expands: true |
| `AppNumberField` | `keyboardType: TextInputType.number` + `FilteringTextInputFormatter.digitsOnly` |
| `AppPinCodeField` | Same as OTP but with `*` obscure style |
| `AppAsyncDropdown` | Dropdown with `FutureBuilder` for async items loading |
| `AppAutocompleteField` | Flutter `Autocomplete<T>` wrapper |
| `AppTimePickerField` | `showTimePicker()` trigger like `AppDatePickerField` |
| `AppDateRangePicker` | `showDateRangePicker()` with start/end display |
| `AppColorPicker` | Grid of color swatches or HSV wheel |
| `AppFilePicker` | `file_picker` package + display filename |
| `AppImagePicker` | `image_picker` package + thumbnail preview |
| `AppRangeSlider` | `RangeSlider` widget with start/end values |
