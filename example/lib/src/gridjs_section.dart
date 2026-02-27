import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bx.dart';

class GridJsSection extends StatelessWidget {
  const GridJsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Grid JS', style: AppTypography.h4),
                    Row(
                      children: [
                        Text(
                          'Table',
                          style: AppTypography.bodySm.copyWith(
                            color: Theme.of(
                              context,
                            ).extension<AppColorsExtension>()!.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Iconify(
                          Bx.chevron_right,
                          size: 16,
                          color: Theme.of(
                            context,
                          ).extension<AppColorsExtension>()!.bodySecondaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Grid JS',
                          style: AppTypography.bodySm.copyWith(
                            color: Theme.of(
                              context,
                            ).extension<AppColorsExtension>()!.bodyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildBasic(context),
          const SizedBox(height: 24),
          _buildPagination(context),
          const SizedBox(height: 24),
          _buildSearch(context),
          const SizedBox(height: 24),
          _buildSorting(context),
          const SizedBox(height: 24),
          _buildLoading(context),
          const SizedBox(height: 24),
          _buildFixedHeader(context),
          const SizedBox(height: 24),
          _buildHiddenColumns(context),
        ],
      ),
    );
  }

  // --- Data Definitions ---
  List<String> get _columns => [
    'Id',
    'Name',
    'Email',
    'Position',
    'Company',
    'Country',
  ];

  List<List<dynamic>> get _dataTableRecords => [
    [
      '11',
      'Alice',
      'alice@example.com',
      'Software Engineer',
      'ABC Company',
      'USA',
    ],
    ['12', 'Bob', 'bob@example.com', 'Product Manager', 'XYZ Inc', 'Canada'],
    [
      '13',
      'Charlie',
      'charlie@example.com',
      'Data Analyst',
      '123 Corp',
      'Australia',
    ],
    ['14', 'David', 'david@example.com', 'UI/UX Designer', '456 Ltd', 'UK'],
    [
      '15',
      'Eve',
      'eve@example.com',
      'Marketing Specialist',
      '789 Enterprises',
      'France',
    ],
    [
      '16',
      'Frank',
      'frank@example.com',
      'HR Manager',
      'ABC Company',
      'Germany',
    ],
    [
      '17',
      'Grace',
      'grace@example.com',
      'Financial Analyst',
      'XYZ Inc',
      'Japan',
    ],
    ['18', 'Hannah', 'hannah@example.com', 'Sales Rep', '123 Corp', 'Brazil'],
    ['19', 'Ian', 'ian@example.com', 'Software Dev', '456 Ltd', 'India'],
    [
      '20',
      'Jane',
      'jane@example.com',
      'Operations Manager',
      '789 Enterprises',
      'China',
    ],
  ];

  // -------------------------

  Widget _buildBasic(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'The most basic list group is an unordered list with list items and the proper classes. Build upon it with the options that follow.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppGridTable(
            columns: _columns,
            rows: _dataTableRecords,
            pagination: 5,
            search: true,
            sort: true,
            isBordered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pagination', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Pagination can be enabled by setting pagination: true:',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppGridTable(
            columns: ['Id', 'Name', 'Date', 'Total'],
            rows: const [
              ['#RB2320', 'Alice', '07 Oct, 2024', '\$24.05'],
              ['#RB8652', 'Bob', '07 Oct, 2024', '\$26.15'],
              ['#RB8520', 'Charlie', '06 Oct, 2024', '\$21.25'],
              ['#RB9512', 'David', '05 Oct, 2024', '\$25.03'],
              ['#RB7532', 'Eve', '04 Oct, 2024', '\$22.61'],
            ],
            pagination: 2, // Low limit to force show pagination
            isBordered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Search', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Grid.js supports global search on all rows and columns. Set search: true to enable the search plugin:',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppGridTable(
            columns: _columns,
            rows: _dataTableRecords,
            pagination: 5,
            search: true,
            isBordered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSorting(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sorting', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'To enable sorting, simply add sort: true to your config:',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppGridTable(
            columns: _columns,
            rows: _dataTableRecords,
            pagination: 5,
            sort: true,
            isBordered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Loading State', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Grid.js renders a loading bar automatically while it waits for the data to be fetched.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppGridTable(
            columns: _columns,
            rows: _dataTableRecords,
            pagination: 5,
            sort: true,
            loading: true,
            isBordered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFixedHeader(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fixed Header', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Limit height and enable scroll.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          // Using isDark just to show some variation on fixed header example
          AppGridTable(
            columns: _columns,
            rows: _dataTableRecords,
            pagination: 10,
            height: 320,
            fixedHeader: true,
            headerVariant: AppTableVariant.light,
            isBordered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHiddenColumns(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hidden Columns', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Pass hiddenColumns index list to hide them.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppGridTable(
            columns: _columns,
            rows: _dataTableRecords,
            pagination: 5,
            sort: true,
            hiddenColumns: const [0, 5], // Hide Id and Country
            isBordered: true,
          ),
        ],
      ),
    );
  }
}
