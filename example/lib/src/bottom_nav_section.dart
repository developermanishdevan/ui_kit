import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BottomNavSection extends StatefulWidget {
  const BottomNavSection({super.key});

  @override
  State<BottomNavSection> createState() => _BottomNavSectionState();
}

class _BottomNavSectionState extends State<BottomNavSection> {
  int _currentIndex = 0;

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
              'Bottom Navigation',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Navigation  >  Bottom Navigation',
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
                'Basic Bottom Navigation',
                'A standard bottom navigation bar for mobile views.',
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.borderColor),
                  borderRadius: BorderRadius.circular(AppRadius.base),
                ),
                child: Scaffold(
                  body: Center(
                    child: Text(
                      'Selected view: $_currentIndex',
                      style: AppTypography.bodyBase.copyWith(
                        color: theme.textEmphasis,
                      ),
                    ),
                  ),
                  bottomNavigationBar: AppBottomNav(
                    currentIndex: _currentIndex,
                    onChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    items: const [
                      AppBottomNavItem(
                        label: 'Home',
                        icon: Icons.home_outlined,
                        activeIcon: Icons.home,
                      ),
                      AppBottomNavItem(
                        label: 'Search',
                        icon: Icons.search_outlined,
                        activeIcon: Icons.search,
                      ),
                      AppBottomNavItem(
                        label: 'Notifications',
                        icon: Icons.notifications_none,
                        activeIcon: Icons.notifications,
                        badgeCount: 3,
                      ),
                      AppBottomNavItem(
                        label: 'Profile',
                        icon: Icons.person_outline,
                        activeIcon: Icons.person,
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
