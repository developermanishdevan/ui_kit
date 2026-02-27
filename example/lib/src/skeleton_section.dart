import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class SkeletonSection extends StatelessWidget {
  const SkeletonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                context,
                'Skeleton Loader',
                'Placeholder UI shapes while data is fetching.',
              ),
              const AppSkeleton(width: double.infinity, height: 20),
              const SizedBox(height: 10),
              const AppSkeleton.text(width: 200),
              const SizedBox(height: 10),
              const AppSkeleton.text(width: 160),
              const SizedBox(height: AppSpacing.s4),
              Row(
                children: const [
                  AppSkeleton.circle(size: 48),
                  SizedBox(width: AppSpacing.s3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSkeleton(width: double.infinity, height: 14),
                        SizedBox(height: 8),
                        AppSkeleton.text(width: 120),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s3),
              Row(
                children: const [
                  Expanded(
                    child: AppSkeleton(width: double.infinity, height: 80),
                  ),
                  SizedBox(width: AppSpacing.s3),
                  Expanded(
                    child: AppSkeleton(width: double.infinity, height: 80),
                  ),
                  SizedBox(width: AppSpacing.s3),
                  Expanded(
                    child: AppSkeleton(width: double.infinity, height: 80),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardHeader(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.h6.copyWith(
              fontWeight: AppTypography.semiBold,
              color: theme.textEmphasis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySm.copyWith(
              color: theme.bodySecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s3),
        ],
      ),
    );
  }
}
