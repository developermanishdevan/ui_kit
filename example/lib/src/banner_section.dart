import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

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
                'App Banner',
                'Persistent top-of-page announcements with optional actions.',
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.base),
                child: Column(
                  children: [
                    AppBanner(
                      message: 'Hello, world! This is a primary banner.',
                      leadingLabel: 'New',
                      color: AppButtonColor.primary,
                      actions: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: const Text('Learn more'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    AppBanner(
                      message: 'Success announcement! Your changes were saved.',
                      leadingLabel: '✓',
                      color: AppButtonColor.success,
                    ),
                    const SizedBox(height: 4),
                    AppBanner(
                      message: 'Warning! Please review your account settings.',
                      color: AppButtonColor.warning,
                      actions: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: const Text('Review'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    AppBanner(
                      message:
                          'Danger! Critical system alert requires attention.',
                      color: AppButtonColor.danger,
                    ),
                  ],
                ),
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
