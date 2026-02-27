import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class DividersSection extends StatelessWidget {
  const DividersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Dividers',
          style: AppTypography.h2.copyWith(
            color: Theme.of(
              context,
            ).extension<AppColorsExtension>()!.textEmphasis,
          ),
        ),
        const SizedBox(height: AppSpacing.s2),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Solid Divider',
                style: AppTypography.bodySm.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodyColor,
                ),
              ),
              const AppDivider(variant: AppDividerVariant.solid),
              const SizedBox(height: AppSpacing.s2),

              Text(
                'Dashed Divider',
                style: AppTypography.bodySm.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodyColor,
                ),
              ),
              const AppDivider(variant: AppDividerVariant.dashed),
              const SizedBox(height: AppSpacing.s2),

              Text(
                'Dotted Divider',
                style: AppTypography.bodySm.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodyColor,
                ),
              ),
              const AppDivider(
                variant: AppDividerVariant.dotted,
                thickness: 2.0,
              ),
              const SizedBox(height: AppSpacing.s2),

              Text(
                'Double Divider',
                style: AppTypography.bodySm.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodyColor,
                ),
              ),
              const AppDivider(variant: AppDividerVariant.double),
              const SizedBox(height: AppSpacing.s2),

              Text(
                'Color Divider (Primary)',
                style: AppTypography.bodySm.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodyColor,
                ),
              ),
              const AppDivider(
                variant: AppDividerVariant.dashed,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
