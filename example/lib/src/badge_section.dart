import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BadgeSection extends StatelessWidget {
  const BadgeSection({super.key});

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
              'Badge',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Badge',
              style: AppTypography.bodySm.copyWith(
                color: theme.bodySecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),

        LayoutBuilder(
          builder: (context, constraints) {
            final isLarge = constraints.maxWidth > 992;

            if (isLarge) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildHeadingCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(
                        child: Column(
                          children: [
                            _buildOutlineCard(context),
                            const SizedBox(height: AppSpacing.s4),
                            _buildSoftCard(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildDefaultCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildSizesCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  _buildButtonsCard(context),
                ],
              );
            }

            return Column(
              children: [
                _buildHeadingCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildOutlineCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildSoftCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildDefaultCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildSizesCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildButtonsCard(context),
              ],
            );
          },
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

  Widget _buildHeadingCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Heading',
            'Provide contextual feedback messages for typical user actions with the handful of available and flexible alert messages. Alerts are available for any length of text, as well as an optional dismiss button.',
          ),
          _buildHeadingRow(
            context,
            'h1.Example heading',
            AppTypography.h1,
            AppBadgeVariant.primary,
            AppBadgeSize.lg,
          ),
          _buildHeadingRow(
            context,
            'h2.Example heading',
            AppTypography.h2,
            AppBadgeVariant.secondary,
            AppBadgeSize.lg,
          ),
          _buildHeadingRow(
            context,
            'h3.Example heading',
            AppTypography.h3,
            AppBadgeVariant.success,
            AppBadgeSize.md,
          ),
          _buildHeadingRow(
            context,
            'h4.Example heading',
            AppTypography.h4,
            AppBadgeVariant.info,
            AppBadgeSize.md,
          ),
          _buildHeadingRow(
            context,
            'h5.Example heading',
            AppTypography.h5,
            AppBadgeVariant.warning,
            AppBadgeSize.sm,
          ),
          _buildHeadingRow(
            context,
            'h6.Example heading',
            AppTypography.h6,
            AppBadgeVariant.danger,
            AppBadgeSize.xs,
          ),
        ],
      ),
    );
  }

  Widget _buildHeadingRow(
    BuildContext context,
    String text,
    TextStyle style,
    AppBadgeVariant variant,
    AppBadgeSize size,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            text,
            style: style.copyWith(
              fontWeight: AppTypography.semiBold,
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.textEmphasis,
            ),
          ),
          const SizedBox(width: 8),
          AppBadge(label: 'New', variant: variant, size: size),
        ],
      ),
    );
  }

  Widget _buildDefaultCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Default & Pill Badges',
            'Use our background utility classes to quickly change the appearance of a badge. And use the .rounded-pill class to make badges more rounded.',
          ),
          _buildBadgeRow(context, AppBadgeType.fill, false),
          const SizedBox(height: 12),
          _buildBadgeRow(context, AppBadgeType.fill, true),
        ],
      ),
    );
  }

  Widget _buildOutlineCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Outline & Outline Pill Badges',
            'Using the .badge-outline-** to quickly create a bordered badges.',
          ),
          _buildBadgeRow(context, AppBadgeType.outline, false),
          const SizedBox(height: 12),
          _buildBadgeRow(context, AppBadgeType.outline, true),
        ],
      ),
    );
  }

  Widget _buildSoftCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Soft & Soft Pill Badges',
            'Using the .badge-soft-** modifier class, you can have more soften variation.',
          ),
          _buildBadgeRow(context, AppBadgeType.soft, false),
          const SizedBox(height: 12),
          _buildBadgeRow(context, AppBadgeType.soft, true),
        ],
      ),
    );
  }

  Widget _buildSizesCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Badge Sizes',
            'Badges of different sizes from extra small to large.',
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              AppBadge(
                label: 'Extra Small',
                size: AppBadgeSize.xs,
                variant: AppBadgeVariant.primary,
              ),
              AppBadge(
                label: 'Small',
                size: AppBadgeSize.sm,
                variant: AppBadgeVariant.success,
              ),
              AppBadge(
                label: 'Medium',
                size: AppBadgeSize.md,
                variant: AppBadgeVariant.info,
              ),
              AppBadge(
                label: 'Large',
                size: AppBadgeSize.lg,
                variant: AppBadgeVariant.danger,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              AppBadge(
                label: 'Pill XS',
                size: AppBadgeSize.xs,
                isPill: true,
                variant: AppBadgeVariant.primary,
              ),
              AppBadge(
                label: 'Pill SM',
                size: AppBadgeSize.sm,
                isPill: true,
                variant: AppBadgeVariant.success,
              ),
              AppBadge(
                label: 'Pill MD',
                size: AppBadgeSize.md,
                isPill: true,
                variant: AppBadgeVariant.info,
              ),
              AppBadge(
                label: 'Pill LG',
                size: AppBadgeSize.lg,
                isPill: true,
                variant: AppBadgeVariant.danger,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeRow(BuildContext context, AppBadgeType type, bool isPill) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        AppBadge(
          label: 'Primary',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.primary,
        ),
        AppBadge(
          label: 'Secondary',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.secondary,
        ),
        AppBadge(
          label: 'Success',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.success,
        ),
        AppBadge(
          label: 'Info',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.info,
        ),
        AppBadge(
          label: 'Warning',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.warning,
        ),
        AppBadge(
          label: 'Danger',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.danger,
        ),
        AppBadge(
          label: 'Dark',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.dark,
        ),
        AppBadge(
          label: 'Purple',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.primary,
        ),
        AppBadge(
          label: 'Pink',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.secondary,
        ),
        AppBadge(
          label: 'Orange',
          type: type,
          isPill: isPill,
          variant: AppBadgeVariant.warning,
        ),
      ],
    );
  }

  Widget _buildButtonsCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Buttons & Position',
            'Alerts can also contain additional HTML elements like headings, paragraphs and dividers.',
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildDemoButton(
                context,
                backgroundColor: theme.primary,
                textColor: Colors.white,
                label: 'Notifications',
                badge: const AppBadge(
                  label: '4',
                  variant: AppBadgeVariant.danger,
                ),
              ),
              _buildDemoButton(
                context,
                isOutline: true,
                borderColor: theme.primary,
                textColor: theme.primary,
                label: 'SM Badge',
                badge: const AppBadge(
                  label: 'new',
                  variant: AppBadgeVariant.primary,
                  type: AppBadgeType.fill,
                  size: AppBadgeSize.xs,
                ),
              ),
              _buildDemoButton(
                context,
                backgroundColor: theme.primary.withAlpha(38),
                textColor: theme.primary,
                label: 'LG Badge',
                badge: const AppBadge(
                  label: 'HOT',
                  variant: AppBadgeVariant.danger,
                  type: AppBadgeType.fill,
                  size: AppBadgeSize.lg,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Inline',
                    style: AppTypography.bodyBase.copyWith(
                      color: theme.bodyColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const AppBadge(
                    label: 'XS',
                    variant: AppBadgeVariant.primary,
                    size: AppBadgeSize.xs,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildPositionedBadge(
                context,
                label: 'Inbox',
                badgeLabel: '99+',
                badgeVariant: AppBadgeVariant.danger,
                size: AppBadgeSize.md,
              ),
              const SizedBox(width: 24),
              _buildPositionedBadge(
                context,
                label: 'Profile',
                isDot: true,
                badgeVariant: AppBadgeVariant.danger,
                size: AppBadgeSize.sm,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDemoButton(
    BuildContext context, {
    Color? backgroundColor,
    Color? textColor,
    bool isOutline = false,
    Color? borderColor,
    required String label,
    required Widget badge,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: isOutline ? Border.all(color: borderColor!, width: 1) : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.bodyBase.copyWith(
              color: textColor,
              fontWeight: AppTypography.medium,
            ),
          ),
          const SizedBox(width: 8),
          badge,
        ],
      ),
    );
  }

  Widget _buildPositionedBadge(
    BuildContext context, {
    required String label,
    String? badgeLabel,
    bool isDot = false,
    required AppBadgeVariant badgeVariant,
    AppBadgeSize size = AppBadgeSize.sm,
  }) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: AppTypography.bodyBase.copyWith(
              color: Colors.white,
              fontWeight: AppTypography.medium,
            ),
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: isDot
              ? AppBadge(
                  label: '',
                  isDot: true,
                  variant: badgeVariant,
                  hasBorder: true,
                  size: size,
                )
              : AppBadge(
                  label: badgeLabel!,
                  variant: badgeVariant,
                  isPill: true,
                  hasBorder: true,
                  size: size,
                ),
        ),
      ],
    );
  }
}
