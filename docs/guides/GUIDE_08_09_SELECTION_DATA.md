# Guide 08-09 — Selection & Data Display Components

---

# PART A: Selection Components

## 8.1 AppCheckbox

```dart
// lib/src/components/selection/checkbox/app_checkbox.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.tristate = false,
    this.enabled = true,
    this.activeColor,
  });

  final bool? value;
  final ValueChanged<bool?> onChanged;
  final String? label;
  final String? description;
  final bool tristate;
  final bool enabled;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final checkbox = Checkbox(
      value:       value,
      onChanged:   enabled ? onChanged : null,
      tristate:    tristate,
      activeColor: activeColor ?? cs.primary,
    );

    if (label == null && description == null) return checkbox;

    return GestureDetector(
      onTap: enabled ? () => onChanged(!(value ?? false)) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          checkbox,
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (label != null)
                  Text(label!, style: AppTypography.bodyMedium.copyWith(
                    color: enabled ? null : Theme.of(context).disabledColor,
                  )),
                if (description != null)
                  Text(description!, style: AppTypography.caption.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 8.2 AppSwitch

```dart
// lib/src/components/selection/switch/app_switch.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.enabled = true,
    this.activeColor,
    this.thumbIcon,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final String? description;
  final bool enabled;
  final Color? activeColor;
  final Icon? thumbIcon;

  @override
  Widget build(BuildContext context) {
    final sw = Switch(
      value:       value,
      onChanged:   enabled ? onChanged : null,
      activeColor: activeColor,
      thumbIcon:   thumbIcon != null
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) return thumbIcon!;
              return null;
            })
          : null,
    );

    if (label == null && description == null) return sw;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null)
                Text(label!, style: AppTypography.bodyMedium),
              if (description != null)
                Text(description!, style: AppTypography.caption.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                )),
            ],
          ),
        ),
        GestureDetector(
          onTap: enabled ? () => onChanged(!value) : null,
          child: sw,
        ),
      ],
    );
  }
}
```

---

## 8.3 AppChoiceChip

```dart
// lib/src/components/selection/choice_chip/app_choice_chip.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.avatar,
    this.enabled = true,
    this.selectedColor,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Widget? avatar;
  final bool enabled;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label:         Text(label, style: AppTypography.labelMedium),
      selected:      selected,
      onSelected:    enabled ? onSelected : null,
      avatar:        avatar,
      selectedColor: selectedColor ?? Theme.of(context).colorScheme.primaryContainer,
      labelStyle: AppTypography.labelMedium.copyWith(
        color: selected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
```

---

## 8.4 AppTagSelector

```dart
// lib/src/components/selection/tag_selector/app_tag_selector.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../choice_chip/app_choice_chip.dart';

class AppTagSelector extends StatelessWidget {
  const AppTagSelector({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.multiSelect = true,
    this.label,
    this.maxSelections,
  });

  final List<String> options;
  final Set<String> selected;
  final ValueChanged<Set<String>> onChanged;
  final bool multiSelect;
  final String? label;
  final int? maxSelections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTypography.labelMedium),
          const SizedBox(height: AppSpacing.xs),
        ],
        Wrap(
          spacing:    AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: options.map((opt) {
            final isSelected = selected.contains(opt);
            return AppChoiceChip(
              label:    opt,
              selected: isSelected,
              enabled:  isSelected || maxSelections == null ||
                        selected.length < maxSelections!,
              onSelected: (_) {
                final newSet = Set<String>.from(selected);
                if (isSelected) {
                  newSet.remove(opt);
                } else if (!multiSelect) {
                  newSet.clear();
                  newSet.add(opt);
                } else {
                  newSet.add(opt);
                }
                onChanged(newSet);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
```

---

## 8.5 AppSelectableTile

```dart
// lib/src/components/selection/selectable_tile/app_selectable_tile.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

class AppSelectableTile extends StatelessWidget {
  const AppSelectableTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.activeColor,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = activeColor ?? cs.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? color.withOpacity(0.1) : Colors.transparent,
        borderRadius: AppRadius.mdAll,
        border: Border.all(
          color: selected ? color : AppColors.borderDefault,
          width: selected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.mdAll,
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: AppSpacing.sm)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: AppTypography.bodyMedium.copyWith(
                        color: selected ? color : AppColors.textPrimary,
                        fontWeight: selected
                            ? AppTypography.weightSemiBold
                            : AppTypography.weightRegular,
                      )),
                      if (subtitle != null)
                        Text(subtitle!, style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        )),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
                if (selected)
                  Icon(Icons.check_circle, color: color, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

# PART B: Data Display Components

## 9.1 AppText

```dart
// lib/src/components/data_display/text/app_text.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';

enum AppTextVariant {
  displayLarge, displayMedium, displaySmall,
  headlineLarge, headlineMedium, headlineSmall,
  titleLarge, titleMedium, titleSmall,
  bodyLarge, bodyMedium, bodySmall,
  labelLarge, labelMedium, labelSmall,
  caption, overline, code,
}

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.align,
    this.overflow,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.letterSpacing,
    this.decoration,
    this.softWrap,
  });

  final String data;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? height;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final bool? softWrap;

  static const _styles = {
    AppTextVariant.displayLarge:   AppTypography.displayLarge,
    AppTextVariant.displayMedium:  AppTypography.displayMedium,
    AppTextVariant.displaySmall:   AppTypography.displaySmall,
    AppTextVariant.headlineLarge:  AppTypography.headlineLarge,
    AppTextVariant.headlineMedium: AppTypography.headlineMedium,
    AppTextVariant.headlineSmall:  AppTypography.headlineSmall,
    AppTextVariant.titleLarge:     AppTypography.titleLarge,
    AppTextVariant.titleMedium:    AppTypography.titleMedium,
    AppTextVariant.titleSmall:     AppTypography.titleSmall,
    AppTextVariant.bodyLarge:      AppTypography.bodyLarge,
    AppTextVariant.bodyMedium:     AppTypography.bodyMedium,
    AppTextVariant.bodySmall:      AppTypography.bodySmall,
    AppTextVariant.labelLarge:     AppTypography.labelLarge,
    AppTextVariant.labelMedium:    AppTypography.labelMedium,
    AppTextVariant.labelSmall:     AppTypography.labelSmall,
    AppTextVariant.caption:        AppTypography.caption,
    AppTextVariant.overline:       AppTypography.overline,
    AppTextVariant.code:           AppTypography.code,
  };

  @override
  Widget build(BuildContext context) {
    final base = _styles[variant] ?? AppTypography.bodyMedium;
    return Text(
      data,
      style: base.copyWith(
        color:         color,
        fontWeight:    fontWeight,
        fontSize:      fontSize,
        height:        height,
        letterSpacing: letterSpacing,
        decoration:    decoration,
      ),
      textAlign: align,
      overflow:  overflow,
      maxLines:  maxLines,
      softWrap:  softWrap,
    );
  }
}
```

---

## 9.2 AppBadge

```dart
// lib/src/components/data_display/badge/app_badge.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

enum AppBadgeVariant { filled, outlined, light }
enum AppBadgeColor { primary, success, warning, error, info, neutral }

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.filled,
    this.color = AppBadgeColor.primary,
    this.icon,
    this.dot = false,
  });

  final String label;
  final AppBadgeVariant variant;
  final AppBadgeColor color;
  final IconData? icon;
  final bool dot;

  static const _bgColors = {
    AppBadgeColor.primary: AppColors.primaryLight,
    AppBadgeColor.success: AppColors.successLight,
    AppBadgeColor.warning: AppColors.warningLight,
    AppBadgeColor.error:   AppColors.errorLight,
    AppBadgeColor.info:    AppColors.infoLight,
    AppBadgeColor.neutral: AppColors.grey100,
  };

  static const _fgColors = {
    AppBadgeColor.primary: AppColors.primary,
    AppBadgeColor.success: AppColors.success,
    AppBadgeColor.warning: AppColors.warning,
    AppBadgeColor.error:   AppColors.error,
    AppBadgeColor.info:    AppColors.info,
    AppBadgeColor.neutral: AppColors.textSecondary,
  };

  @override
  Widget build(BuildContext context) {
    final bg = _bgColors[color]!;
    final fg = _fgColors[color]!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm, vertical: AppSpacing.px2,
      ),
      decoration: BoxDecoration(
        color: variant == AppBadgeVariant.outlined ? Colors.transparent : bg,
        borderRadius: AppRadius.fullAll,
        border: variant == AppBadgeVariant.outlined
            ? Border.all(color: fg) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) Container(
            width: 6, height: 6,
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 4),
          ),
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(label, style: AppTypography.labelSmall.copyWith(color: fg)),
        ],
      ),
    );
  }
}
```

---

## 9.3 AppAvatar

```dart
// lib/src/components/data_display/avatar/app_avatar.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

enum AppAvatarSize { xs, sm, md, lg, xl }

extension _AvatarSizeX on AppAvatarSize {
  double get size => switch (this) {
    AppAvatarSize.xs => 24, AppAvatarSize.sm => 32, AppAvatarSize.md => 40,
    AppAvatarSize.lg => 56, AppAvatarSize.xl => 80,
  };
  double get fontSize => switch (this) {
    AppAvatarSize.xs => 10, AppAvatarSize.sm => 12, AppAvatarSize.md => 16,
    AppAvatarSize.lg => 20, AppAvatarSize.xl => 28,
  };
}

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.size = AppAvatarSize.md,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.showBadge = false,
    this.badgeColor,
    this.shape = BoxShape.circle,
  });

  final String? imageUrl;
  final String? initials;
  final IconData? icon;
  final AppAvatarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;
  final bool showBadge;
  final Color? badgeColor;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final s  = size.size;
    final bg = backgroundColor ?? AppColors.primaryLight;
    final fg = foregroundColor ?? AppColors.primary;

    Widget content;
    if (imageUrl != null) {
      content = Image.network(
        imageUrl!, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _initials(fg, bg),
        loadingBuilder: (ctx, child, progress) =>
            progress == null ? child : CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (initials != null) {
      content = _initials(fg, bg);
    } else {
      content = Icon(icon ?? Icons.person, size: s * 0.5, color: fg);
    }

    Widget avatar = Container(
      width: s, height: s,
      decoration: BoxDecoration(
        color:  imageUrl == null ? bg : null,
        shape:  shape,
        borderRadius: shape == BoxShape.rectangle ?
            BorderRadius.circular(s * 0.2) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );

    if (showBadge) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0, bottom: 0,
            child: Container(
              width: s * 0.28, height: s * 0.28,
              decoration: BoxDecoration(
                color:  badgeColor ?? AppColors.success,
                shape:  BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
            ),
          ),
        ],
      );
    }

    return onTap != null
        ? GestureDetector(onTap: onTap, child: avatar)
        : avatar;
  }

  Widget _initials(Color fg, Color bg) => Center(
    child: Text(
      initials!.substring(0, initials!.length.clamp(0, 2)).toUpperCase(),
      style: AppTypography.labelMedium.copyWith(
        fontSize: size.fontSize, color: fg, fontWeight: AppTypography.weightBold,
      ),
    ),
  );
}
```

---

## 9.4 AppCard

```dart
// lib/src/components/data_display/card/app_card.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';
import '../../../../foundation/tokens/shadows/app_shadows.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';

enum AppCardVariant { elevated, outlined, filled }

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.elevated,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.shadows,
    this.borderColor,
    this.clip = Clip.antiAlias,
  });

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;
  final Color? borderColor;
  final Clip clip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? switch (variant) {
      AppCardVariant.elevated => cs.surface,
      AppCardVariant.outlined => cs.surface,
      AppCardVariant.filled   => cs.surfaceContainerHighest,
    };
    final br = borderRadius ?? AppRadius.mdAll;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color:        bg,
        borderRadius: br,
        boxShadow: shadows ?? switch (variant) {
          AppCardVariant.elevated => AppShadows.sm,
          _                       => AppShadows.none,
        },
        border: variant == AppCardVariant.outlined
            ? Border.all(color: borderColor ?? AppColors.borderDefault)
            : null,
      ),
      clipBehavior: clip,
      child: onTap != null
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: br,
                onTap: onTap,
                child: Padding(
                  padding: padding ?? const EdgeInsets.all(AppSpacing.base),
                  child: child,
                ),
              ),
            )
          : Padding(
              padding: padding ?? const EdgeInsets.all(AppSpacing.base),
              child: child,
            ),
    );
  }
}
```

---

## 9.5 AppStatCard

```dart
// lib/src/components/data_display/stat_card/app_stat_card.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';
import '../card/app_card.dart';

class AppStatCard extends StatelessWidget {
  const AppStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.trend,
    this.trendPositive,
    this.onTap,
  });

  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final String? trend;
  final bool? trendPositive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final trendColor = trendPositive == true
        ? AppColors.success
        : trendPositive == false ? AppColors.error : AppColors.textSecondary;

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title, style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                )),
              ),
              if (icon != null)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color:  (iconColor ?? AppColors.primary).withOpacity(0.1),
                    shape:  BoxShape.circle,
                  ),
                  child: Icon(icon, size: 18, color: iconColor ?? AppColors.primary),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTypography.displaySmall.copyWith(
            fontWeight: AppTypography.weightBold,
          )),
          if (subtitle != null || trend != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                if (trend != null) ...[
                  Icon(
                    trendPositive == true ? Icons.trending_up
                        : trendPositive == false ? Icons.trending_down
                        : Icons.trending_flat,
                    size: 16, color: trendColor,
                  ),
                  const SizedBox(width: 4),
                  Text(trend!, style: AppTypography.caption.copyWith(
                    color: trendColor, fontWeight: AppTypography.weightSemiBold,
                  )),
                  if (subtitle != null) const SizedBox(width: 4),
                ],
                if (subtitle != null)
                  Expanded(
                    child: Text(subtitle!, style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    )),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
```

---

## 9.6 AppTag

```dart
// lib/src/components/data_display/tag/app_tag.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/radius/app_radius.dart';

class AppTag extends StatelessWidget {
  const AppTag({
    super.key,
    required this.label,
    this.color,
    this.onDelete,
    this.icon,
    this.outlined = false,
  });

  final String label;
  final Color? color;
  final VoidCallback? onDelete;
  final IconData? icon;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final c  = color ?? AppColors.primaryLight;
    final fg = AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color:        outlined ? Colors.transparent : c,
        borderRadius: AppRadius.smAll,
        border:       outlined ? Border.all(color: fg) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(label, style: AppTypography.labelSmall.copyWith(color: fg)),
          if (onDelete != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onDelete,
              child: Icon(Icons.close, size: 12, color: fg),
            ),
          ],
        ],
      ),
    );
  }
}
```

---

## 9.7 AppTimeline

```dart
// lib/src/components/data_display/timeline/app_timeline.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';

class AppTimelineItem {
  const AppTimelineItem({
    required this.title,
    this.subtitle,
    this.time,
    this.icon,
    this.iconColor,
    this.trailing,
  });
  final String title;
  final String? subtitle;
  final String? time;
  final IconData? icon;
  final Color? iconColor;
  final Widget? trailing;
}

class AppTimeline extends StatelessWidget {
  const AppTimeline({
    super.key,
    required this.items,
    this.dotSize = 12.0,
    this.lineWidth = 2.0,
    this.lineColor,
    this.defaultDotColor,
  });

  final List<AppTimelineItem> items;
  final double dotSize;
  final double lineWidth;
  final Color? lineColor;
  final Color? defaultDotColor;

  @override
  Widget build(BuildContext context) {
    final lc = lineColor ?? AppColors.borderDefault;
    final dc = defaultDotColor ?? AppColors.primary;

    return Column(
      children: List.generate(items.length, (i) {
        final item    = items[i];
        final isLast  = i == items.length - 1;
        final dotColor = item.iconColor ?? dc;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline dot + line
              Column(
                children: [
                  Container(
                    width: dotSize, height: dotSize,
                    decoration: BoxDecoration(
                      color: dotColor, shape: BoxShape.circle,
                    ),
                    child: item.icon != null
                        ? Icon(item.icon, size: dotSize * 0.6, color: AppColors.white)
                        : null,
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: lineWidth, color: lc,
                        margin: EdgeInsets.symmetric(horizontal: (dotSize - lineWidth) / 2),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(item.title, style: AppTypography.bodyMedium.copyWith(
                              fontWeight: AppTypography.weightSemiBold,
                            )),
                            if (item.subtitle != null)
                              Text(item.subtitle!, style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              )),
                          ],
                        ),
                      ),
                      if (item.time != null)
                        Text(item.time!, style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiary,
                        )),
                      if (item.trailing != null) item.trailing!,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
```

---

## 9.8 AppKeyValueRow

```dart
// lib/src/components/data_display/key_value_row/app_key_value_row.dart
import 'package:flutter/material.dart';
import '../../../../foundation/tokens/typography/app_typography.dart';
import '../../../../foundation/tokens/colors/app_colors.dart';
import '../../../../foundation/tokens/spacing/app_spacing.dart';

class AppKeyValueRow extends StatelessWidget {
  const AppKeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.trailing,
    this.copyable = false,
    this.padding,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Widget? trailing;
  final bool copyable;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
              style: labelStyle ?? AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 3,
            child: Text(value,
              style: valueStyle ?? AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (copyable)
            GestureDetector(
              onTap: () {
                // Copy to clipboard
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied!'), duration: Duration(seconds: 1)),
                );
              },
              child: const Icon(Icons.copy, size: 16, color: AppColors.textTertiary),
            ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
```
