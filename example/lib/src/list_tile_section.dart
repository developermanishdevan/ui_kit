import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ListTileSection extends AppStatelessWrapper {
  const ListTileSection({super.key});

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'List Tile',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Data Display  >  List Tile',
              style: AppTypography.bodySm.copyWith(
                color: theme.bodySecondaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spacing.s4),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Basic Usage',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Standard list tiles with various configurations.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppListTile(
                title: 'John Doe',
                subtitle: 'Software Engineer',
                leading: AppAvatar(
                  size: AppAvatarSize.md,
                  child: const Text('JD'),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
                showDivider: true,
              ),
              AppListTile(
                title: 'Design System Update',
                subtitle: '2 hours ago',
                leading: Container(
                  padding: EdgeInsets.all(spacing.s2),
                  decoration: BoxDecoration(
                    color: theme.primary.withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: theme.primary,
                  ),
                ),
                trailing: AppBadge(
                  label: 'New',
                  variant: AppBadgeVariant.primary,
                  isPill: true,
                ),
                onTap: () {},
                showDivider: true,
              ),
              AppListTile(
                title: 'Settings',
                leading: Icon(
                  Icons.settings_outlined,
                  color: theme.bodySecondaryColor,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),

        SizedBox(height: spacing.s4),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selection & States',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Tiles showing selected and disabled states.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppListTile(
                title: 'Selected Item',
                subtitle: 'This item is currently active',
                leading: Icon(Icons.check_circle, color: theme.primary),
                selected: true,
                onTap: () {},
              ),
              SizedBox(height: spacing.s2),
              AppListTile(
                title: 'Disabled Item',
                subtitle: 'This interaction is disabled',
                leading: Icon(
                  Icons.block,
                  color: theme.bodySecondaryColor.withAlpha(100),
                ),
                enabled: false,
                onTap: () {},
              ),
            ],
          ),
        ),

        SizedBox(height: spacing.s4),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complex Content',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Using widgets for titles and trailing sections.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppListTile(
                title: Row(
                  children: [
                    const Text('Task Completion'),
                    SizedBox(width: spacing.s2),
                    AppBadge(label: 'Urgent', variant: AppBadgeVariant.danger),
                  ],
                ),
                subtitle: 'Complete the migration by EOD.',
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '85%',
                      style: AppTypography.bodyBase.copyWith(
                        fontWeight: AppTypography.semiBold,
                        color: theme.success,
                      ),
                    ),
                    Text(
                      'Progress',
                      style: AppTypography.bodyXs.copyWith(
                        color: theme.bodySecondaryColor,
                      ),
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
