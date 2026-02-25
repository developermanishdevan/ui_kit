import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import '../../data_display/card/app_card.dart';

class AppSelectableCard extends StatelessWidget {
  const AppSelectableCard({
    required this.child,
    required this.selected,
    required this.onTap,
    super.key,
    this.enabled = true,
  });

  final Widget child;
  final bool selected;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: enabled ? onTap : null,
      variant: selected ? AppCardVariant.outlined : AppCardVariant.elevated,
      borderColor: selected ? AppColors.primary : AppColors.borderDefault,
      backgroundColor:
          selected ? AppColors.primary.withValues(alpha: 0.05) : null,
      child: Stack(
        children: [
          child,
          if (selected)
            const Positioned(
              top: 0,
              right: 0,
              child:
                  Icon(Icons.check_circle, color: AppColors.primary, size: 20),
            ),
        ],
      ),
    );
  }
}
