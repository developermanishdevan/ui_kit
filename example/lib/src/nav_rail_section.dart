import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class NavRailSection extends StatefulWidget {
  const NavRailSection({super.key});

  @override
  State<NavRailSection> createState() => _NavRailSectionState();
}

class _NavRailSectionState extends State<NavRailSection> {
  int _selectedIndex = 0;
  bool _extended = false;

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
              'Navigation Rail',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Navigation  >  Navigation Rail',
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
                'Basic Navigation Rail',
                'A rail navigation element, generally placed on the left side of larger screens.',
              ),
              Row(
                children: [
                  AppButton(
                    label: _extended ? 'Collapse Rail' : 'Extend Rail',
                    onPressed: () => setState(() => _extended = !_extended),
                    variant: AppButtonVariant.outline,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s4),
              Container(
                height: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.borderColor),
                  borderRadius: BorderRadius.circular(AppRadius.base),
                ),
                child: Scaffold(
                  body: Row(
                    children: [
                      AppNavRail(
                        selectedIndex: _selectedIndex,
                        extended: _extended,
                        onDestinationSelected: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        leading: Column(
                          children: [
                            const SizedBox(height: AppSpacing.s2),
                            IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                setState(() {
                                  _extended = !_extended;
                                });
                              },
                            ),
                            const SizedBox(height: AppSpacing.s2),
                            FloatingActionButton(
                              elevation: 0,
                              onPressed: () {},
                              backgroundColor: theme.primary,
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                        ),
                        items: const [
                          AppNavRailItem(
                            label: 'Dashboard',
                            icon: Icons.dashboard_outlined,
                            activeIcon: Icons.dashboard,
                          ),
                          AppNavRailItem(
                            label: 'Messages',
                            icon: Icons.message_outlined,
                            activeIcon: Icons.message,
                            badgeCount: 4,
                          ),
                          AppNavRailItem(
                            label: 'Profile',
                            icon: Icons.person_outline,
                            activeIcon: Icons.person,
                          ),
                        ],
                      ),
                      const VerticalDivider(thickness: 1, width: 1),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Selected view: $_selectedIndex',
                            style: AppTypography.bodyBase.copyWith(
                              color: theme.textEmphasis,
                            ),
                          ),
                        ),
                      ),
                    ],
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
