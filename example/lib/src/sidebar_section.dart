import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class SidebarSection extends StatefulWidget {
  const SidebarSection({super.key});

  @override
  State<SidebarSection> createState() => _SidebarSectionState();
}

class _SidebarSectionState extends State<SidebarSection> {
  int _selectedIndex = 0;
  bool _isCollapsed = false;
  bool _isEcommerceExpanded = false;

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
              'Sidebar',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Navigation  >  Sidebar',
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
                'Basic Sidebar',
                'A persistent sidebar component for tablet or desktop layouts.',
              ),
              Row(
                children: [
                  AppButton(
                    label: _isCollapsed ? 'Expand Sidebar' : 'Collapse Sidebar',
                    onPressed: () =>
                        setState(() => _isCollapsed = !_isCollapsed),
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
                      AppSidebar(
                        isCollapsed: _isCollapsed,
                        header: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: _isCollapsed
                                ? AppSpacing.s1
                                : AppSpacing.s3,
                            vertical: AppSpacing.s4,
                          ),
                          child: Row(
                            mainAxisAlignment: _isCollapsed
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: theme.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.widgets,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              if (!_isCollapsed) ...[
                                const SizedBox(width: AppSpacing.s3),
                                Text(
                                  'UI Kit',
                                  style: AppTypography.h6.copyWith(
                                    fontWeight: AppTypography.bold,
                                    color: theme.textEmphasis,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        footer: AppSidebarItem(
                          label: 'Logout',
                          icon: Icons.logout,
                          isCollapsed: _isCollapsed,
                          onTap: () {},
                        ),
                        children: [
                          AppSidebarItem(
                            label: 'Dashboard',
                            icon: Icons.dashboard_outlined,
                            isSelected: _selectedIndex == 0,
                            isCollapsed: _isCollapsed,
                            onTap: () => setState(() => _selectedIndex = 0),
                          ),
                          AppSidebarItem(
                            label: 'Analytics',
                            icon: Icons.analytics_outlined,
                            isSelected: _selectedIndex == 1,
                            isCollapsed: _isCollapsed,
                            onTap: () => setState(() => _selectedIndex = 1),
                          ),
                          AppSidebarItem(
                            label: 'Customers',
                            icon: Icons.people_outline,
                            isSelected: _selectedIndex == 2,
                            isCollapsed: _isCollapsed,
                            onTap: () => setState(() => _selectedIndex = 2),
                          ),
                          AppSidebarItem(
                            label: 'Messages',
                            icon: Icons.message_outlined,
                            badgeCount: 5,
                            isSelected: _selectedIndex == 3,
                            isCollapsed: _isCollapsed,
                            onTap: () => setState(() => _selectedIndex = 3),
                          ),
                          const SizedBox(height: AppSpacing.s3),
                          if (!_isCollapsed)
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
                            )
                          else
                            const Divider(),
                          AppSidebarItem(
                            label: 'Configuration',
                            icon: Icons.settings_outlined,
                            isSelected: _selectedIndex == 4,
                            isCollapsed: _isCollapsed,
                            onTap: () => setState(() => _selectedIndex = 4),
                          ),
                          AppSidebarMenu(
                            title: 'E-commerce',
                            icon: Icons.shopping_cart_outlined,
                            isExpanded: _isEcommerceExpanded,
                            isSidebarCollapsed: _isCollapsed,
                            hasSelectedChild:
                                _selectedIndex == 5 || _selectedIndex == 6,
                            onExpansionChanged: (v) =>
                                setState(() => _isEcommerceExpanded = v),
                            children: [
                              AppSidebarItem(
                                label: 'Products',
                                isSelected: _selectedIndex == 5,
                                isCollapsed: _isCollapsed,
                                onTap: () => setState(() => _selectedIndex = 5),
                              ),
                              AppSidebarItem(
                                label: 'Orders',
                                badgeCount: 2,
                                isSelected: _selectedIndex == 6,
                                isCollapsed: _isCollapsed,
                                onTap: () => setState(() => _selectedIndex = 6),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Selected view: $_selectedIndex',
                            textAlign: TextAlign.center,
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
