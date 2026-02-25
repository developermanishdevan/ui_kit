import 'package:flutter/material.dart';
import 'package:ui_kit/src/foundation/tokens/colors/app_colors.dart';
import 'package:ui_kit/src/foundation/tokens/typography/app_typography.dart';
import 'package:ui_kit/src/foundation/tokens/radius/app_radius.dart';

class AppTag extends StatelessWidget {
  const AppTag({
    required this.label, super.key,
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
    final c = color ?? AppColors.primaryLight;
    const fg = AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : c,
        borderRadius: AppRadius.smAll,
        border: outlined ? Border.all(color: fg) : null,
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
              child: const Icon(Icons.close, size: 12, color: fg),
            ),
          ],
        ],
      ),
    );
  }
}
