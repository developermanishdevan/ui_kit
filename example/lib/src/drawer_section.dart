import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class DrawerSection extends StatefulWidget {
  const DrawerSection({super.key});

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
  int _selectedIndex = 0;

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
              'Drawer',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Navigation  >  Drawer',
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
                'Basic Drawer',
                'A side drawer navigation for mobile or responsive applications.',
              ),
              Container(
                height: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.borderColor),
                  borderRadius: BorderRadius.circular(AppRadius.base),
                ),
                child: Scaffold(
                  appBar: AppTopBar(
                    titleText: 'Drawer Demo',
                    leading: Builder(
                      builder: (context) {
                        return IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    ),
                  ),
                  drawer: AppDrawer(
                    header: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s3,
                        vertical: AppSpacing.s4,
                      ),
                      child: Row(
                        children: [
                          const AppAvatar(
                            imageUrl: 'https://i.pravatar.cc/150?img=11',
                            size: AppAvatarSize.md,
                          ),
                          const SizedBox(width: AppSpacing.s3),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Manish',
                                style: AppTypography.bodyBase.copyWith(
                                  fontWeight: AppTypography.bold,
                                  color: theme.textEmphasis,
                                ),
                              ),
                              Text(
                                'manish@example.com',
                                style: AppTypography.bodyXs.copyWith(
                                  color: theme.bodySecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    footer: AppDrawerItem(
                      label: 'Logout',
                      icon: Icons.logout,
                      onTap: () {},
                    ),
                    children: [
                      AppDrawerItem(
                        label: 'Dashboard',
                        icon: Icons.dashboard_outlined,
                        isSelected: _selectedIndex == 0,
                        onTap: () => setState(() => _selectedIndex = 0),
                      ),
                      AppDrawerItem(
                        label: 'Analytics',
                        icon: Icons.analytics_outlined,
                        isSelected: _selectedIndex == 1,
                        onTap: () => setState(() => _selectedIndex = 1),
                      ),
                      AppDrawerItem(
                        label: 'Customers',
                        icon: Icons.people_outline,
                        isSelected: _selectedIndex == 2,
                        onTap: () => setState(() => _selectedIndex = 2),
                      ),
                      AppDrawerItem(
                        label: 'Messages',
                        icon: Icons.message_outlined,
                        badgeCount: 5,
                        isSelected: _selectedIndex == 3,
                        onTap: () => setState(() => _selectedIndex = 3),
                      ),
                      const SizedBox(height: AppSpacing.s3),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s4,
                          vertical: AppSpacing.s2,
                        ),
                        child: Text(
                          'SETTINGS',
                          style: AppTypography.bodyXs.copyWith(
                            fontWeight: AppTypography.bold,
                            color: theme.bodySecondaryColor,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      AppDrawerItem(
                        label: 'Configuration',
                        icon: Icons.settings_outlined,
                        isSelected: _selectedIndex == 4,
                        onTap: () => setState(() => _selectedIndex = 4),
                      ),
                    ],
                  ),
                  body: Center(
                    child: Text(
                      'Open the drawer to see the items.\nSelected view: $_selectedIndex',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyBase.copyWith(
                        color: theme.textEmphasis,
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
