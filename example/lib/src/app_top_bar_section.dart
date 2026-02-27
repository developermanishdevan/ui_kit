import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AppTopBarSection extends StatelessWidget {
  const AppTopBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'App Top Bar',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Navigation  >  App Top Bar',
              style: AppTypography.bodySm.copyWith(
                color: theme.bodySecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardHeader(
                context,
                'Basic App Top Bar',
                'A basic top app bar with title and actions.',
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.borderColor),
                  borderRadius: BorderRadius.circular(AppRadius.base),
                ),
                child: Scaffold(
                  appBar: AppTopBar(
                    titleText: 'Dashboard',
                    leading: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {},
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () {},
                      ),
                      const SizedBox(width: AppSpacing.s2),
                      const Padding(
                        padding: EdgeInsets.only(right: AppSpacing.s3),
                        child: Center(
                          child: AppAvatar(
                            imageUrl: 'https://i.pravatar.cc/150?img=11',
                            size: AppAvatarSize.sm,
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: Center(
                    child: Text(
                      'Page Content',
                      style: AppTypography.bodyBase.copyWith(
                        color: theme.bodySecondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              _buildCardHeader(
                context,
                'Centered Title',
                'App top bar with a centered title.',
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.borderColor),
                  borderRadius: BorderRadius.circular(AppRadius.base),
                ),
                child: Scaffold(
                  appBar: AppTopBar(
                    titleText: 'Settings',
                    centerTitle: true,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {},
                    ),
                  ),
                  body: Center(
                    child: Text(
                      'Settings Content',
                      style: AppTypography.bodyBase.copyWith(
                        color: theme.bodySecondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardHeader(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.h5.copyWith(
            fontWeight: AppTypography.semiBold,
            color: theme.textEmphasis,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTypography.bodySm.copyWith(
            color: theme.bodySecondaryColor,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
      ],
    );
  }
}
