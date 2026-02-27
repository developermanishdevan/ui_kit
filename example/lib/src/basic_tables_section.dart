import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bx.dart';

class BasicTablesSection extends StatelessWidget {
  const BasicTablesSection({super.key});

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
                    Text('Basic Tables', style: AppTypography.h4),
                    Row(
                      children: [
                        Text(
                          'Tables',
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
                          'Basic Tables',
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
          _buildBasicExample(context),
          const SizedBox(height: 24),
          _buildVariantsExample(context),
          const SizedBox(height: 24),
          _buildStripedRowsExample(context),
          const SizedBox(height: 24),
          _buildHoverableRowsExample(context),
          const SizedBox(height: 24),
          _buildActiveTablesExample(context),
          const SizedBox(height: 24),
          _buildBorderedTableExample(context),
          const SizedBox(height: 24),
          _buildTableWithoutBordersExample(context),
          const SizedBox(height: 24),
          _buildSmallTablesExample(context),
          const SizedBox(height: 24),
          _buildTableGroupDividersExample(context),
          const SizedBox(height: 24),
          _buildVerticalAlignmentExample(context),
          const SizedBox(height: 24),
          _buildTableWithCaptionExample(context),
          const SizedBox(height: 24),
          _buildStripedRowsDarkExample(context),
          const SizedBox(height: 24),
          _buildStripedRowsSuccessExample(context),
          const SizedBox(height: 24),
          _buildStripedColumnsExample(context),
          const SizedBox(height: 24),
          _buildStripedColumnsDarkExample(context),
          const SizedBox(height: 24),
          _buildStripedColumnsSuccessExample(context),
          const SizedBox(height: 24),
          _buildHoverableRowsDarkExample(context),
          const SizedBox(height: 24),
          _buildActiveTablesDarkExample(context),
          const SizedBox(height: 24),
          _buildBorderedColorTableExample(context),
          const SizedBox(height: 24),
          _buildTableWithoutBordersDarkExample(context),
          const SizedBox(height: 24),
          _buildSmallTablesDarkExample(context),
          const SizedBox(height: 24),
          _buildTableHeadExample(context),
          const SizedBox(height: 24),
          _buildTableHeadDarkExample(context),
          const SizedBox(height: 24),
          _buildTableWithFooterExample(context),
          const SizedBox(height: 24),
          _buildTableWithCaptionTopExample(context),
          const SizedBox(height: 24),
          _buildAlwaysResponsiveExample(context),
          const SizedBox(height: 24),
          _buildNestingTableExample(context),
          const SizedBox(height: 24),
          _buildTableWithAvatarsExample(context),
          const SizedBox(height: 24),
          _buildTableWithCheckboxesExample(context),
        ],
      ),
    );
  }

  Widget _buildBasicExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Example', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'For basic styling—light padding and only horizontal dividers.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVariantsExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Variants', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Use contextual classes to color tables, table rows or individual cells.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          // Need to manually build table rows here since AppTable doesn't support varying row colors easily yet,
          // or we can simulate it by wrapping the Variant Table over multiple calls if needed.
          // For simplicity in UI kit, demonstrating standard table variant first.
          AppTable(
            columns: const ['Class', 'Heading', 'Heading'],
            variant: AppTableVariant.primary,
            rows: [
              [const Text('Primary'), const Text('Cell'), const Text('Cell')],
            ],
          ),
          const SizedBox(height: 16),
          AppTable(
            columns: const ['Class', 'Heading', 'Heading'],
            variant: AppTableVariant.success,
            rows: [
              [const Text('Success'), const Text('Cell'), const Text('Cell')],
            ],
          ),
          const SizedBox(height: 16),
          AppTable(
            columns: const ['Class', 'Heading', 'Heading'],
            variant: AppTableVariant.danger,
            rows: [
              [const Text('Danger'), const Text('Cell'), const Text('Cell')],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStripedRowsExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Striped Rows Table', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Add zebra-striping to any table row.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            isStriped: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoverableRowsExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hoverable rows', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Hover state not natively supported by flutter Table widget easily, using default table.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTablesExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Tables', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Highlight a table row.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            activeRowIndex: 0,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBorderedTableExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bordered Table', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Borders on all sides of the table and cells.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            isBordered: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableWithoutBordersExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tables without borders', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Table without borders.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            isBorderless: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallTablesExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Small tables', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'More compact table by cutting all cell padding in half.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            isSmall: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableGroupDividersExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Table group dividers', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Thicker border for header.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            useGroupDividers: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalAlignmentExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vertical alignment', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Aligning cells to the top/middle/bottom.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            verticalAlign: AppTableVerticalAlign.top,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('This is\na very\ntall cell\nto show\nalignment.'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableWithCaptionExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Caption', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'A table with a caption.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            caption: const Text('List of users'),
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStripedRowsDarkExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Striped Rows Table Dark', style: AppTypography.h5),
          const SizedBox(height: 4),
          Text(
            'Use isDark and isStriped to add zebra-striping to a dark table.',
            style: AppTypography.bodySm.copyWith(
              color: Theme.of(
                context,
              ).extension<AppColorsExtension>()!.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          AppTable(
            isStriped: true,
            isDark: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStripedRowsSuccessExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Striped Rows Table Success', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isStriped: true,
            variant: AppTableVariant.success,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStripedColumnsExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Striped columns', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isStripedColumns: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStripedColumnsDarkExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Striped columns Dark', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isStripedColumns: true,
            isDark: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStripedColumnsSuccessExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Striped columns Success', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isStripedColumns: true,
            variant: AppTableVariant.success,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoverableRowsDarkExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hoverable rows Dark', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isDark: true,
            isHoverable: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTablesDarkExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Tables Dark', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isDark: true,
            activeRowIndex: 0,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBorderedColorTableExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bordered color Table', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isBordered: true,
            borderPrimary: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableWithoutBordersDarkExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tables without borders Dark', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isBorderless: true,
            isDark: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallTablesDarkExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Small Tables Dark', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isSmall: true,
            isDark: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry the Bird'),
                const Text('Simsons'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeadExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Table head', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            headerVariant: AppTableVariant.light,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry'),
                const Text('the Bird'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeadDarkExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Table head Dark', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            headerVariant: AppTableVariant.dark,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry'),
                const Text('the Bird'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableWithFooterExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Table with Footer', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry'),
                const Text('the Bird'),
                const Text('@twitter'),
              ],
            ],
            footers: [
              [
                const Text('Footer'),
                const Text('Footer'),
                const Text('Footer'),
                const Text('Footer'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableWithCaptionTopExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Caption Top', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            caption: const Text('List of users'),
            captionTop: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                const Text('Jacob'),
                const Text('Thornton'),
                const Text('@fat'),
              ],
              [
                const Text('3'),
                const Text('Larry'),
                const Text('the Bird'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlwaysResponsiveExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Always responsive', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            columns: const [
              '#',
              'Heading',
              'Heading',
              'Heading',
              'Heading',
              'Heading',
              'Heading',
              'Heading',
              'Heading',
              'Heading',
            ],
            rows: [
              [
                const Text('1'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
              ],
              [
                const Text('2'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
              ],
              [
                const Text('3'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
                const Text('Cell'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNestingTableExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nesting Table', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isBordered: true,
            isStriped: true,
            columns: const ['#', 'First', 'Last', 'Handle'],
            rows: [
              [
                const Text('1'),
                const Text('Mark'),
                const Text('Otto'),
                const Text('@mdo'),
              ],
              [
                const Text('2'),
                AppTable(
                  columns: const ['Header', 'Header', 'Header'],
                  rows: [
                    [const Text('A'), const Text('First'), const Text('Last')],
                    [const Text('B'), const Text('First'), const Text('Last')],
                    [const Text('C'), const Text('First'), const Text('Last')],
                  ],
                ),
                const Text(
                  '',
                ), // Fill remaining column cells or use colSpan if available
                const Text(''),
              ],
              [
                const Text('3'),
                const Text('Larry'),
                const Text('the Bird'),
                const Text('@twitter'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableWithAvatarsExample(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('With avatars', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isHoverable: true,
            headerVariant: AppTableVariant.light,
            columns: const ['Name', 'Title', 'Email', 'Role', 'Action'],
            rows: [
              [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(radius: 16, child: Text('TC')),
                    const SizedBox(width: 8),
                    Text(
                      'Tony M. Carter',
                      style: AppTypography.h6.copyWith(fontSize: 14),
                    ),
                  ],
                ),
                const Text('Designer'),
                const Text('tonymcarter@jourrapide.com'),
                const Text('Member'),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                ),
              ],
              [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(radius: 16, child: Text('JC')),
                    const SizedBox(width: 8),
                    Text(
                      'James E. Chambliss',
                      style: AppTypography.h6.copyWith(fontSize: 14),
                    ),
                  ],
                ),
                const Text('UI/UX Designer'),
                const Text('jamesechambliss@teleworm.us'),
                const Text('Admin'),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableWithCheckboxesExample(BuildContext context) {
    bool isChecked = false;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('With checkboxes', style: AppTypography.h5),
          const Divider(height: 32),
          AppTable(
            isStriped: true,
            isBorderless: true,
            headerVariant: AppTableVariant.light,
            columns: [
              StatefulBuilder(
                builder: (context, setState) {
                  return Checkbox(
                    value: isChecked,
                    onChanged: (v) => setState(() => isChecked = v!),
                  );
                },
              ),
              'Name',
              'Title',
              'Email',
              'Role',
              'Action',
            ],
            rows: [
              [
                StatefulBuilder(
                  builder: (context, setState) {
                    return Checkbox(
                      value: isChecked,
                      onChanged: (v) => setState(() => isChecked = v!),
                    );
                  },
                ),
                const Text('Tony M. Carter'),
                const Text('Designer'),
                const Text('tonymcarter@jourrapide.com'),
                const Text('Member'),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                ),
              ],
              [
                StatefulBuilder(
                  builder: (context, setState) {
                    return Checkbox(
                      value: isChecked,
                      onChanged: (v) => setState(() => isChecked = v!),
                    );
                  },
                ),
                const Text('James E. Chambliss'),
                const Text('UI/UX Designer'),
                const Text('jamesechambliss@teleworm.us'),
                const Text('Admin'),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
