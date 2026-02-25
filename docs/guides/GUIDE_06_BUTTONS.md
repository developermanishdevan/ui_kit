# Guide 06 — Button System (20+ Variants)

## 6.1 Base Button Infrastructure

### AppButtonSize enum

```dart
// lib/src/components/buttons/base/app_button_size.dart
enum AppButtonSize { compact, small, medium, large, block }

extension AppButtonSizeX on AppButtonSize {
  double get height => switch (this) {
    AppButtonSize.compact => 28,
    AppButtonSize.small   => 36,
    AppButtonSize.medium  => 44,
    AppButtonSize.large   => 52,
    AppButtonSize.block   => 52,
  };

  double get horizontalPadding => switch (this) {
    AppButtonSize.compact => 10,
    AppButtonSize.small   => 16,
    AppButtonSize.medium  => 20,
    AppButtonSize.large   => 28,
    AppButtonSize.block   => 24,
  };

  double get fontSize => switch (this) {
    AppButtonSize.compact => 12,
    AppButtonSize.small   => 13,
    AppButtonSize.medium  => 14,
    AppButtonSize.large   => 16,
    AppButtonSize.block   => 15,
  };

  double get iconSize => switch (this) {
    AppButtonSize.compact => 14,
    AppButtonSize.small   => 16,
    AppButtonSize.medium  => 18,
    AppButtonSize.large   => 20,
    AppButtonSize.block   => 18,
  };
}
```

### AppBaseButton — `buttons/base/app_base_button.dart`

```dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/durations/app_durations.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import 'app_button_size.dart';

/// Common interface that all buttons share.
abstract class AppBaseButton extends StatefulWidget {
  const AppBaseButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = AppButtonSize.medium,
    this.width,
    this.borderRadius,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final String? label;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isDisabled;
  final AppButtonSize size;
  final double? width;
  final BorderRadius? borderRadius;
  final String? tooltip;

  bool get _isInteractive => !isDisabled && !isLoading && onPressed != null;
}

/// Base state that handles press animation and loading indicator.
abstract class AppBaseButtonState<T extends AppBaseButton> extends State<T>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: AppDurations.fast,
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _animCtrl;
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget._isInteractive) _animCtrl.reverse();
  }

  void _onTapUp(TapUpDetails _) => _animCtrl.forward();
  void _onTapCancel() => _animCtrl.forward();

  Widget buildLoadingIndicator(Color color) => SizedBox(
    width: 18, height: 18,
    child: CircularProgressIndicator(
      strokeWidth: 2, color: color,
    ),
  );

  Widget buildButtonContent({
    required Color foregroundColor,
    required TextStyle labelStyle,
  }) {
    if (widget.isLoading) return buildLoadingIndicator(foregroundColor);

    final iconWidget = widget.icon != null
        ? Icon(widget.icon, size: widget.size.iconSize, color: foregroundColor)
        : null;
    final trailingWidget = widget.trailingIcon != null
        ? Icon(widget.trailingIcon, size: widget.size.iconSize, color: foregroundColor)
        : null;
    final labelWidget = widget.label != null
        ? Text(widget.label!, style: labelStyle.copyWith(color: foregroundColor))
        : null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconWidget != null) iconWidget,
        if (iconWidget != null && labelWidget != null) const SizedBox(width: 8),
        if (labelWidget != null) labelWidget,
        if (trailingWidget != null && labelWidget != null) const SizedBox(width: 8),
        if (trailingWidget != null) trailingWidget,
      ],
    );
  }

  Widget buildWrapper({required Widget child}) {
    Widget btn = ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown:   _onTapDown,
        onTapUp:     _onTapUp,
        onTapCancel: _onTapCancel,
        child: Opacity(
          opacity: widget._isInteractive ? 1.0 : 0.48,
          child: child,
        ),
      ),
    );

    if (widget.tooltip != null) {
      btn = Tooltip(message: widget.tooltip!, child: btn);
    }
    return btn;
  }
}
```

---

## 6.2 Primary Button

```dart
// lib/src/components/buttons/primary/app_primary_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppPrimaryButton extends AppBaseButton {
  const AppPrimaryButton({
    super.key,
    super.label,
    super.icon,
    super.trailingIcon,
    required super.onPressed,
    super.isLoading = false,
    super.isDisabled = false,
    super.size = AppButtonSize.medium,
    super.width,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState
    extends AppBaseButtonState<AppPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final bg = widget.backgroundColor ?? AppColors.primary;
    final fg = widget.foregroundColor ?? AppColors.white;
    final br = widget.borderRadius ?? AppRadius.mdAll;
    final isBlock = widget.size == AppButtonSize.block;

    final button = Material(
      color:        widget._isInteractive ? bg : bg.withOpacity(0.48),
      borderRadius: br,
      child: InkWell(
        borderRadius: br,
        onTap: widget._isInteractive ? widget.onPressed : null,
        child: Container(
          height:  widget.size.height,
          width:   isBlock ? double.infinity : widget.width,
          padding: EdgeInsets.symmetric(horizontal: widget.size.horizontalPadding),
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
```

---

## 6.3 Secondary Button

```dart
// lib/src/components/buttons/secondary/app_secondary_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppSecondaryButton extends AppBaseButton {
  const AppSecondaryButton({
    super.key, super.label, super.icon, super.trailingIcon,
    required super.onPressed,
    super.isLoading, super.isDisabled,
    super.size = AppButtonSize.medium, super.width,
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
    final br = AppRadius.mdAll;

    final button = Material(
      color: widget._isInteractive ? bg : bg.withOpacity(0.48),
      borderRadius: br,
      child: InkWell(
        borderRadius: br,
        onTap: widget._isInteractive ? widget.onPressed : null,
        child: Container(
          height: widget.size.height,
          width: widget.size == AppButtonSize.block ? double.infinity : widget.width,
          padding: EdgeInsets.symmetric(horizontal: widget.size.horizontalPadding),
          alignment: Alignment.center,
          child: buildButtonContent(
            foregroundColor: fg,
            labelStyle: AppTypography.labelLarge.copyWith(fontSize: widget.size.fontSize),
          ),
        ),
      ),
    );
    return buildWrapper(child: button);
  }
}
```

---

## 6.4 Outline Button

```dart
// lib/src/components/buttons/outline/app_outline_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppOutlineButton extends AppBaseButton {
  const AppOutlineButton({
    super.key, super.label, super.icon, super.trailingIcon,
    required super.onPressed,
    super.isLoading, super.isDisabled,
    super.size = AppButtonSize.medium, super.width,
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
    final br = AppRadius.mdAll;

    final button = Material(
      color: Colors.transparent,
      borderRadius: br,
      child: InkWell(
        borderRadius: br,
        onTap: widget._isInteractive ? widget.onPressed : null,
        child: Container(
          height: widget.size.height,
          width: widget.size == AppButtonSize.block ? double.infinity : widget.width,
          padding: EdgeInsets.symmetric(horizontal: widget.size.horizontalPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: br,
            border: Border.all(
              color: widget._isInteractive ? bc : bc.withOpacity(0.48),
              width: widget.borderWidth,
            ),
          ),
          child: buildButtonContent(
            foregroundColor: widget._isInteractive ? fg : fg.withOpacity(0.48),
            labelStyle: AppTypography.labelLarge.copyWith(fontSize: widget.size.fontSize),
          ),
        ),
      ),
    );
    return buildWrapper(child: button);
  }
}
```

---

## 6.5 Ghost Button (Text-only, no bg)

```dart
// lib/src/components/buttons/ghost/app_ghost_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppGhostButton extends AppBaseButton {
  const AppGhostButton({
    super.key, super.label, super.icon, super.trailingIcon,
    required super.onPressed,
    super.isLoading, super.isDisabled,
    super.size = AppButtonSize.medium, super.width,
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
    final br = AppRadius.mdAll;
    return buildWrapper(
      child: TextButton(
        onPressed: widget._isInteractive ? widget.onPressed : null,
        style: TextButton.styleFrom(
          foregroundColor: fg,
          minimumSize: Size(0, widget.size.height),
          padding: EdgeInsets.symmetric(horizontal: widget.size.horizontalPadding),
          shape: RoundedRectangleBorder(borderRadius: br),
          textStyle: AppTypography.labelLarge.copyWith(fontSize: widget.size.fontSize),
        ),
        child: buildButtonContent(
          foregroundColor: fg,
          labelStyle: AppTypography.labelLarge.copyWith(fontSize: widget.size.fontSize),
        ),
      ),
    );
  }
}
```

---

## 6.6 Gradient Button

```dart
// lib/src/components/buttons/gradient/app_gradient_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/gradients/app_gradients.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../base/app_base_button.dart';
import '../base/app_button_size.dart';

class AppGradientButton extends AppBaseButton {
  const AppGradientButton({
    super.key, super.label, super.icon,
    required super.onPressed,
    super.isLoading, super.isDisabled,
    super.size = AppButtonSize.medium, super.width,
    this.gradient = AppGradients.primary,
  });

  final Gradient gradient;

  @override
  State<AppGradientButton> createState() => _State();
}

class _State extends AppBaseButtonState<AppGradientButton> {
  @override
  Widget build(BuildContext context) {
    final br = AppRadius.mdAll;
    return buildWrapper(
      child: Material(
        color: Colors.transparent,
        borderRadius: br,
        child: InkWell(
          borderRadius: br,
          onTap: widget._isInteractive ? widget.onPressed : null,
          child: Ink(
            decoration: BoxDecoration(
              gradient: widget._isInteractive
                  ? widget.gradient
                  : LinearGradient(
                      colors: (widget.gradient as LinearGradient)
                          .colors.map((c) => c.withOpacity(0.48)).toList(),
                    ),
              borderRadius: br,
            ),
            child: Container(
              height: widget.size.height,
              width: widget.size == AppButtonSize.block ? double.infinity : widget.width,
              padding: EdgeInsets.symmetric(horizontal: widget.size.horizontalPadding),
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
```

---

## 6.7 Destructive Button

```dart
// lib/src/components/buttons/destructive/app_destructive_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../base/app_button_size.dart';
import '../primary/app_primary_button.dart';

class AppDestructiveButton extends StatelessWidget {
  const AppDestructiveButton({
    super.key,
    this.label,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = AppButtonSize.medium,
    this.width,
  });

  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final AppButtonSize size;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      label:           label,
      icon:            icon,
      onPressed:       onPressed,
      isLoading:       isLoading,
      isDisabled:      isDisabled,
      size:            size,
      width:           width,
      backgroundColor: AppColors.error,
      foregroundColor: AppColors.white,
    );
  }
}
```

---

## 6.8 Icon Button

```dart
// lib/src/components/buttons/icon_button/app_icon_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/icon_sizes/app_icon_sizes.dart';

enum AppIconButtonVariant { standard, filled, tonal, outlined }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = AppIconButtonVariant.standard,
    this.size = AppIconSizes.lg,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.tooltip,
    this.isDisabled = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final String? tooltip;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final effectiveOnPressed = isDisabled ? null : onPressed;

    final iconWidget = Icon(icon, size: size,
      color: color ?? switch (variant) {
        AppIconButtonVariant.filled  => AppColors.white,
        AppIconButtonVariant.tonal   => cs.onSecondaryContainer,
        _                            => cs.onSurface,
      },
    );

    final decoration = switch (variant) {
      AppIconButtonVariant.filled => BoxDecoration(
        color: backgroundColor ?? cs.primary,
        borderRadius: AppRadius.mdAll,
      ),
      AppIconButtonVariant.tonal => BoxDecoration(
        color: backgroundColor ?? cs.secondaryContainer,
        borderRadius: AppRadius.mdAll,
      ),
      AppIconButtonVariant.outlined => BoxDecoration(
        border: Border.all(color: borderColor ?? cs.outline),
        borderRadius: AppRadius.mdAll,
      ),
      AppIconButtonVariant.standard => null,
    };

    final btn = Opacity(
      opacity: isDisabled ? 0.48 : 1.0,
      child: Container(
        decoration: decoration,
        child: IconButton(
          icon: iconWidget,
          onPressed: effectiveOnPressed,
          tooltip: tooltip,
          padding: EdgeInsets.all(size * 0.3),
          constraints: BoxConstraints(
            minWidth: size + (size * 0.6),
            minHeight: size + (size * 0.6),
          ),
        ),
      ),
    );

    return btn;
  }
}
```

---

## 6.9 Floating Action Button

```dart
// lib/src/components/buttons/floating/app_floating_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';

enum AppFabSize { mini, standard, large, extended }

class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.size = AppFabSize.standard,
    this.backgroundColor,
    this.foregroundColor,
    this.tooltip,
    this.heroTag,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;
  final AppFabSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? tooltip;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.primary;
    final fg = foregroundColor ?? AppColors.white;

    if (label != null || size == AppFabSize.extended) {
      return FloatingActionButton.extended(
        onPressed:       onPressed,
        icon:            Icon(icon, color: fg),
        label:           Text(label ?? '', style: TextStyle(color: fg)),
        backgroundColor: bg,
        tooltip:         tooltip,
        heroTag:         heroTag,
      );
    }

    return switch (size) {
      AppFabSize.mini  => FloatingActionButton.small(
        onPressed: onPressed, backgroundColor: bg,
        foregroundColor: fg, tooltip: tooltip, heroTag: heroTag,
        child: Icon(icon),
      ),
      AppFabSize.large => FloatingActionButton.large(
        onPressed: onPressed, backgroundColor: bg,
        foregroundColor: fg, tooltip: tooltip, heroTag: heroTag,
        child: Icon(icon),
      ),
      _ => FloatingActionButton(
        onPressed: onPressed, backgroundColor: bg,
        foregroundColor: fg, tooltip: tooltip, heroTag: heroTag,
        child: Icon(icon),
      ),
    };
  }
}
```

---

## 6.10 Toggle Button

```dart
// lib/src/components/buttons/toggle/app_toggle_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppToggleButton extends StatelessWidget {
  const AppToggleButton({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.height = 40,
    this.activeColor,
    this.inactiveColor,
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final double height;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final active   = activeColor   ?? AppColors.primary;
    final inactive = inactiveColor ?? AppColors.grey100;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: inactive,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (i) {
          final isSelected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onChanged(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? active : Colors.transparent,
                borderRadius: AppRadius.smAll,
              ),
              child: Text(
                options[i],
                style: AppTypography.labelMedium.copyWith(
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
```

---

## 6.11 Link Button

```dart
// lib/src/components/buttons/link_button/app_link_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppLinkButton extends StatelessWidget {
  const AppLinkButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
    this.underline = true,
    this.fontSize,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  final bool underline;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final fg = color ?? AppColors.primary;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: fg,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.bodyMedium.copyWith(
              color: fg,
              fontSize: fontSize,
              decoration: underline ? TextDecoration.underline : null,
              decorationColor: fg,
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 6.12 Split Button

```dart
// lib/src/components/buttons/split_button/app_split_button.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppSplitButton extends StatelessWidget {
  const AppSplitButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.onDropdownPressed,
    this.icon,
    this.height = 44,
    this.backgroundColor,
    this.foregroundColor,
    this.dropdownIcon = Icons.keyboard_arrow_down,
  });

  final String label;
  final VoidCallback onPressed;
  final VoidCallback onDropdownPressed;
  final IconData? icon;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData dropdownIcon;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.primary;
    final fg = foregroundColor ?? AppColors.white;

    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Main action
          Material(
            color: bg,
            borderRadius: const BorderRadius.only(
              topLeft:     Radius.circular(AppRadius.md),
              bottomLeft:  Radius.circular(AppRadius.md),
            ),
            child: InkWell(
              onTap: onPressed,
              borderRadius: const BorderRadius.only(
                topLeft:     Radius.circular(AppRadius.md),
                bottomLeft:  Radius.circular(AppRadius.md),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 18, color: fg),
                      const SizedBox(width: 8),
                    ],
                    Text(label, style: AppTypography.labelLarge.copyWith(color: fg)),
                  ],
                ),
              ),
            ),
          ),
          // Divider
          Container(width: 1, color: fg.withOpacity(0.3), height: height * 0.6),
          // Dropdown trigger
          Material(
            color: bg,
            borderRadius: const BorderRadius.only(
              topRight:    Radius.circular(AppRadius.md),
              bottomRight: Radius.circular(AppRadius.md),
            ),
            child: InkWell(
              onTap: onDropdownPressed,
              borderRadius: const BorderRadius.only(
                topRight:    Radius.circular(AppRadius.md),
                bottomRight: Radius.circular(AppRadius.md),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(dropdownIcon, size: 20, color: fg),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 6.13 Segmented Button

```dart
// lib/src/components/buttons/segmented/app_segmented_button.dart
import 'package:flutter/material.dart';

class AppSegmentedButtonItem<T> {
  const AppSegmentedButtonItem({
    required this.value,
    required this.label,
    this.icon,
  });
  final T value;
  final String label;
  final IconData? icon;
}

class AppSegmentedButton<T> extends StatelessWidget {
  const AppSegmentedButton({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
    this.multiSelect = false,
  });

  final List<AppSegmentedButtonItem<T>> items;
  final Set<T> selected;
  final ValueChanged<Set<T>> onChanged;
  final bool multiSelect;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      segments: items.map((item) => ButtonSegment<T>(
        value: item.value,
        label: Text(item.label),
        icon:  item.icon != null ? Icon(item.icon) : null,
      )).toList(),
      selected:       selected,
      onSelectionChanged: onChanged,
      multiSelectionEnabled: multiSelect,
    );
  }
}
```
