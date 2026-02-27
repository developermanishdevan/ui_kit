import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class KeyValueRowSection extends AppStatelessWrapper {
  const KeyValueRowSection({super.key});

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
              'Key Value Row',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Data Display  >  Key Value Row',
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
                'Displaying simple label and value pairs.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              const AppKeyValueRow(label: 'Name', value: 'Manish Chaudhary'),
              const AppKeyValueRow(label: 'Email', value: 'manish@example.com'),
              const AppKeyValueRow(
                label: 'Location',
                value: 'San Francisco, CA',
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
                'With Dividers & Interactions',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Using dividers and custom widgets for values.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppKeyValueRow(
                label: 'Status',
                value: AppBadge(
                  label: 'Active',
                  variant: AppBadgeVariant.success,
                  isPill: true,
                ),
                showDivider: true,
              ),
              AppKeyValueRow(
                label: 'Priority',
                value: AppBadge(label: 'High', variant: AppBadgeVariant.danger),
                showDivider: true,
              ),
              AppKeyValueRow(
                label: 'Due Date',
                value: 'Dec 25, 2026',
                trailing: Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: theme.primary,
                ),
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
                'With Icons & Complex Values',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Adding leading icons and interactive elements.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppKeyValueRow(
                leading: Icon(
                  Icons.person_outline,
                  size: 20,
                  color: theme.bodySecondaryColor,
                ),
                label: 'Role',
                value: 'Senior Developer',
                showDivider: true,
              ),
              AppKeyValueRow(
                leading: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 20,
                  color: theme.bodySecondaryColor,
                ),
                label: 'Plan',
                value: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Professional'),
                    SizedBox(width: spacing.s1),
                    AppButton(
                      label: 'Upgrade',
                      onPressed: () {},
                      // Assuming sm variant or similar for small button
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
}
