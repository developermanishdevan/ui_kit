import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BreadcrumbSection extends StatelessWidget {
  const BreadcrumbSection({super.key});

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
              'Breadcrumb',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Breadcrumb',
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
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildDefaultCard(context)),
                  const SizedBox(width: AppSpacing.s4),
                  Expanded(child: _buildDividersCard(context)),
                ],
              );
            }

            return Column(
              children: [
                _buildDefaultCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildDividersCard(context),
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

  Widget _buildDefaultCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Default Example',
            'Use an ordered or unordered list with linked list items to create a minimally styled breadcrumb. Use our utilities to add additional styles as desired.',
          ),
          const AppBreadcrumb(
            items: [AppBreadcrumbItem(label: 'Home', isActive: true)],
          ),
          const SizedBox(height: 16),
          AppBreadcrumb(
            items: [
              AppBreadcrumbItem(label: 'Home', onTap: () {}),
              const AppBreadcrumbItem(label: 'Library', isActive: true),
            ],
          ),
          const SizedBox(height: 16),
          AppBreadcrumb(
            items: [
              AppBreadcrumbItem(label: 'Home', onTap: () {}),
              AppBreadcrumbItem(label: 'Library', onTap: () {}),
              const AppBreadcrumbItem(label: 'Data', isActive: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDividersCard(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Dividers Breadcrumb',
            'Optionally, you can also specify the icon with your breadcrumb item.',
          ),
          AppBreadcrumb(
            separator: Text(
              '>',
              style: TextStyle(color: theme.bodySecondaryColor),
            ),
            items: [
              AppBreadcrumbItem(label: 'Home', onTap: () {}),
              const AppBreadcrumbItem(label: 'Library', isActive: true),
            ],
          ),
          const SizedBox(height: 16),
          AppBreadcrumb(
            separator: Text(
              '/',
              style: TextStyle(color: theme.bodySecondaryColor),
            ),
            items: [
              AppBreadcrumbItem(label: 'Home', onTap: () {}),
              AppBreadcrumbItem(label: 'Library', onTap: () {}),
              const AppBreadcrumbItem(label: 'Data', isActive: true),
            ],
          ),
          const SizedBox(height: 16),
          AppBreadcrumb(
            items: [
              AppBreadcrumbItem(
                label: 'Home',
                onTap: () {},
                icon: Icon(
                  Icons.home,
                  size: 14,
                  color: theme.bodySecondaryColor,
                ),
              ),
              AppBreadcrumbItem(
                label: 'Library',
                onTap: () {},
                icon: Icon(
                  Icons.book,
                  size: 14,
                  color: theme.bodySecondaryColor,
                ),
              ),
              const AppBreadcrumbItem(label: 'Data', isActive: true),
            ],
          ),
        ],
      ),
    );
  }
}
