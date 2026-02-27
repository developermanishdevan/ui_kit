import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TabsSection extends StatelessWidget {
  const TabsSection({super.key});

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
              'Tabs',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Tabs',
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
                      Expanded(child: _buildNavTabsCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildTabsJustifiedCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildNavPillsCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildPillsJustifiedCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildNavTabsCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildTabsJustifiedCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildNavPillsCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildPillsJustifiedCard(context),
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

  List<AppTab> _getDemoTabs() {
    return [
      const AppTab(
        label: 'Home',
        icon: Icons.home_outlined,
        content: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Food truck fixie locavore, accusamus mcsweeney\'s marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog selvage.',
          ),
        ),
      ),
      const AppTab(
        label: 'Profile',
        icon: Icons.person_outline,
        content: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Trust fund seitan letterpress, keytar raw denim keffiyeh etsy art party before they sold out master cleanse gluten-free squid scenester.',
          ),
        ),
      ),
      const AppTab(
        label: 'Settings',
        icon: Icons.settings_outlined,
        content: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Settings content goes here. You can customize various app behaviors from this tab.',
          ),
        ),
      ),
    ];
  }

  Widget _buildNavTabsCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Nav Tabs',
            'Use the .nav-tabs class to generate a tabbed interface.',
          ),
          AppTabs(tabs: _getDemoTabs(), variant: AppTabVariant.underline),
        ],
      ),
    );
  }

  Widget _buildTabsJustifiedCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Tabs Justified',
            'You can force your tabs menu items to use the full available width.',
          ),
          AppTabs(
            tabs: _getDemoTabs(),
            variant: AppTabVariant.underline,
            isJustified: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNavPillsCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Nav Pills',
            'Use the .nav-pills class to generate a pilled interface.',
          ),
          AppTabs(tabs: _getDemoTabs(), variant: AppTabVariant.pills),
        ],
      ),
    );
  }

  Widget _buildPillsJustifiedCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Pills Justified',
            'Force your pills menu items to use the full available width.',
          ),
          AppTabs(
            tabs: _getDemoTabs(),
            variant: AppTabVariant.pills,
            isJustified: true,
          ),
        ],
      ),
    );
  }
}
