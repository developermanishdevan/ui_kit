import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class PaginationSection extends AppStatefulWrapper {
  const PaginationSection({super.key});

  @override
  AppStatefulWrapperState<PaginationSection> createState() =>
      _PaginationSectionState();
}

class _PaginationSectionState
    extends AppStatefulWrapperState<PaginationSection> {
  int _currentPage1 = 1;
  int _currentPage2 = 2;
  int _currentPage3 = 1;
  int _currentPage4 = 1;
  int _currentPage5 = 1;
  int _currentPage6 = 1;

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pagination',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Pagination',
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
                      Expanded(child: _buildDefaultPaginationCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildRoundedPaginationCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildAlignmentPaginationCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildSizingPaginationCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildDefaultPaginationCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildRoundedPaginationCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildAlignmentPaginationCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildSizingPaginationCard(context),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCardHeader(BuildContext context, String title, String subtitle) {
    final theme = context.theme.extension<AppColorsExtension>()!;
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

  Widget _buildDefaultPaginationCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Default Buttons',
            'Use the button classes on an a, button or input element.',
          ),
          AppPagination(
            totalPages: 3,
            currentPage: _currentPage1,
            onPageChanged: (page) => setState(() => _currentPage1 = page),
          ),
          const SizedBox(height: AppSpacing.s5),
          AppPagination(
            totalPages: 3,
            currentPage: _currentPage1,
            onPageChanged: (page) => setState(() => _currentPage1 = page),
            showLabels: false,
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedPaginationCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Rounded Pagination',
            'Simple pagination inspired by Rdio, great for apps and search results.',
          ),
          AppPagination(
            totalPages: 3,
            currentPage: _currentPage2,
            onPageChanged: (page) => setState(() => _currentPage2 = page),
            shape: AppPaginationShape.rounded,
          ),
          const SizedBox(height: AppSpacing.s5),
          AppPagination(
            totalPages: 3,
            currentPage: _currentPage2,
            onPageChanged: (page) => setState(() => _currentPage2 = page),
            shape: AppPaginationShape.rounded,
            showLabels: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAlignmentPaginationCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Alignment',
            'Change the alignment of pagination components with flexbox utilities.',
          ),
          AppPagination(
            totalPages: 3,
            currentPage: _currentPage3,
            onPageChanged: (page) => setState(() => _currentPage3 = page),
            alignment: MainAxisAlignment.center,
          ),
          const SizedBox(height: AppSpacing.s5),
          AppPagination(
            totalPages: 3,
            currentPage: _currentPage4,
            onPageChanged: (page) => setState(() => _currentPage4 = page),
            alignment: MainAxisAlignment.end,
          ),
        ],
      ),
    );
  }

  Widget _buildSizingPaginationCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Sizing',
            'Add pagination-lg or pagination-sm for additional sizes.',
          ),
          AppPagination(
            totalPages: 3,
            currentPage: _currentPage5,
            onPageChanged: (page) => setState(() => _currentPage5 = page),
            size: AppPaginationSize.lg,
          ),
          const SizedBox(height: AppSpacing.s5),
          AppPagination(
            totalPages: 3,
            currentPage: _currentPage6,
            onPageChanged: (page) => setState(() => _currentPage6 = page),
            size: AppPaginationSize.md,
          ),
          const SizedBox(height: AppSpacing.s5),
          AppPagination(
            totalPages: 3,
            currentPage: _currentPage6,
            onPageChanged: (page) => setState(() => _currentPage6 = page),
            size: AppPaginationSize.sm,
          ),
        ],
      ),
    );
  }
}
