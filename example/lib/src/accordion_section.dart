import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AccordionSection extends StatelessWidget {
  const AccordionSection({super.key});

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
              'Accordion',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Accordion',
              style: AppTypography.bodySm.copyWith(
                color: theme.bodySecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildBasicAccordion(context)),
                  const SizedBox(width: AppSpacing.s4),
                  Expanded(child: _buildFlushAccordion(context)),
                ],
              );
            }
            return Column(
              children: [
                _buildBasicAccordion(context),
                const SizedBox(height: AppSpacing.s4),
                _buildFlushAccordion(context),
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.s4),
        _buildAlwaysOpenAccordion(context),
      ],
    );
  }

  Widget _buildBasicAccordion(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Example',
            style: AppTypography.h6.copyWith(
              fontWeight: AppTypography.semiBold,
              color: theme.textEmphasis,
            ),
          ),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'Using the card component, you can extend the default collapse behavior to create an accordion.',
            style: AppTypography.bodySm.copyWith(
              color: theme.bodySecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          AppAccordion(items: [_createItem(1), _createItem(2), _createItem(3)]),
        ],
      ),
    );
  }

  Widget _buildFlushAccordion(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flush Accordion',
            style: AppTypography.h6.copyWith(
              fontWeight: AppTypography.semiBold,
              color: theme.textEmphasis,
            ),
          ),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'Add flush property to remove the default background-color, some borders, and some rounded corners.',
            style: AppTypography.bodySm.copyWith(
              color: theme.bodySecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          AppAccordion(
            flush: true,
            items: [_createItem(1), _createItem(2), _createItem(3)],
          ),
        ],
      ),
    );
  }

  Widget _buildAlwaysOpenAccordion(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Always Open Accordion',
            style: AppTypography.h6.copyWith(
              fontWeight: AppTypography.semiBold,
              color: theme.textEmphasis,
            ),
          ),
          const SizedBox(height: AppSpacing.s2),
          Text(
            'Keep accordion items stay open when another item is opened.',
            style: AppTypography.bodySm.copyWith(
              color: theme.bodySecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          AppAccordion(
            alwaysOpen: true,
            items: [
              _createItem(1, isInitiallyExpanded: true),
              _createItem(2),
              _createItem(3),
            ],
          ),
        ],
      ),
    );
  }

  AppAccordionItem _createItem(int index, {bool isInitiallyExpanded = false}) {
    return AppAccordionItem(
      title: 'Accordion Item #$index',
      isInitiallyExpanded: isInitiallyExpanded,
      content: const Text(
        'This is the accordion body. It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions.',
      ),
    );
  }
}
