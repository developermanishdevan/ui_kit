import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ExpandableTileSection extends AppStatefulWrapper {
  const ExpandableTileSection({super.key});

  @override
  AppStatefulWrapperState<ExpandableTileSection> createState() =>
      _ExpandableTileSectionState();
}

class _ExpandableTileSectionState
    extends AppStatefulWrapperState<ExpandableTileSection> {
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
              'Expandable Tile',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Data Display  >  Expandable Tile',
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
                'Basic Expandable Tile',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'A basic expandable tile with a title and content.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppExpandableTile(
                title: const Text('Click to expand me'),
                child: const Text(
                  'This is the hidden content inside the expandable tile. You can put any widget here, including complex layouts or other components.',
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
                'Expandable Tile with Subtitle and Leading Icon',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Add extra context with a subtitle and a leading widget.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppExpandableTile(
                leading: Icon(Icons.settings, color: theme.primary),
                title: const Text('Advanced Settings'),
                subtitle: const Text(
                  'Configure advanced options for your account.',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppDivider(),
                    SizedBox(height: spacing.s3),
                    const Text('Option 1: Enabled'),
                    SizedBox(height: spacing.s2),
                    const Text('Option 2: Disabled'),
                    SizedBox(height: spacing.s4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppButton(label: 'Save Changes', onPressed: () {}),
                    ),
                  ],
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
                'Initially Expanded Tile',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Tiles can be set to be expanded by default.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppExpandableTile(
                title: const Text('Always Open Info'),
                initiallyExpanded: true,
                child: const Text(
                  'This content is visible immediately when the page loads because initiallyExpanded is set to true.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
