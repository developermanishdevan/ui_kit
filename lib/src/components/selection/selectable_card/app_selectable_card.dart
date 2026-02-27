import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// A card component that can be selected.
class AppSelectableCard extends AppStatelessWrapper {
  final Widget child;
  final bool selected;
  final VoidCallback? onTap;
  final Color? activeColor;
  final bool enabled;

  const AppSelectableCard({
    super.key,
    required this.child,
    required this.selected,
    this.onTap,
    this.activeColor,
    this.enabled = true,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = context.theme.extension<AppColorsExtension>()!;
    final radii = context.theme.extension<AppRadiusExtension>()!;

    final themeColor = activeColor ?? colors.primary;

    return AppAnimatedContainer(
      duration: AppDurations.quick,
      decoration: BoxDecoration(
        color: selected ? themeColor.withValues(alpha: 0.05) : colors.bodyBg,
        borderRadius: radii.lg,
        border: Border.all(
          color: selected ? themeColor : colors.borderColor,
          width: selected ? 2 : 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: themeColor.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: radii.lg,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s4),
                child: child,
              ),
              if (selected)
                Positioned(
                  top: AppSpacing.s2,
                  right: AppSpacing.s2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: themeColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
