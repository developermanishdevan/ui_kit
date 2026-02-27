import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TypographySection extends StatelessWidget {
  const TypographySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Typography',
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
                'Level 1 Heading',
                style: AppTypography.h1.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.textEmphasis,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Level 2 Heading',
                style: AppTypography.h2.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.textEmphasis,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Level 3 Heading',
                style: AppTypography.h3.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.textEmphasis,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Level 4 Heading',
                style: AppTypography.h4.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.textEmphasis,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Level 5 Heading',
                style: AppTypography.h5.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.textEmphasis,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Level 6 Heading',
                style: AppTypography.h6.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.textEmphasis,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Body Text - Large',
                style: AppTypography.bodyLg.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodyColor,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Body Text - Base (Default)',
                style: AppTypography.bodyBase.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodyColor,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Body Text - Small',
                style: AppTypography.bodySm.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodySecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
