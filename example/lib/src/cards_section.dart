import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CardsSection extends StatelessWidget {
  const CardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Cards',
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
                'Default Card',
                style: AppTypography.h6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.textEmphasis,
                ),
              ),
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Cards provide a flexible and extensible content container with multiple variants and options.',
                style: AppTypography.bodyBase.copyWith(
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.bodySecondaryColor,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              const AppDivider(),
              const SizedBox(height: AppSpacing.s4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: 'Cancel',
                    color: AppButtonColor.secondary,
                    variant: AppButtonVariant.soft,
                    onPressed: () {},
                  ),
                  const SizedBox(width: AppSpacing.s2),
                  AppButton(
                    label: 'Submit',
                    color: AppButtonColor.primary,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
