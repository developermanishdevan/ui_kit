import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class OffcanvasSection extends StatelessWidget {
  const OffcanvasSection({super.key});

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
              'Offcanvas',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Offcanvas',
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
                      Expanded(child: _buildDefaultOffcanvasCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildOffcanvasPositionCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildDefaultOffcanvasCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildOffcanvasPositionCard(context),
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

  Widget _buildDefaultOffcanvasCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Default Buttons',
            'You can use a link with the href attribute, or a button with the data-bs-target attribute.',
          ),
          Wrap(
            spacing: 8,
            children: [
              AppButton(
                label: 'Default Offcanvas',
                onPressed: () {
                  AppOffcanvas.show(
                    context,
                    title: 'Default Offcanvas',
                    content: const AppOffcanvasBody(
                      child: Text('This offcanvas has no border radius.'),
                    ),
                  );
                },
              ),
              AppButton(
                label: 'Rounded Offcanvas',
                color: AppButtonColor.success,
                onPressed: () {
                  AppOffcanvas.show(
                    context,
                    title: 'Rounded Offcanvas',
                    isRounded: true,
                    content: const AppOffcanvasBody(
                      child: Text('This offcanvas uses a smart border radius.'),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOffcanvasPositionCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Offcanvas Position',
            'Try the top, right, bottom and left examples out below.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildPositionButton(
                context,
                'Left',
                AppOffcanvasPlacement.start,
                AppButtonColor.primary,
              ),
              _buildPositionButton(
                context,
                'Right',
                AppOffcanvasPlacement.end,
                AppButtonColor.secondary,
              ),
              _buildPositionButton(
                context,
                'Top',
                AppOffcanvasPlacement.top,
                AppButtonColor.success,
              ),
              _buildPositionButton(
                context,
                'Bottom',
                AppOffcanvasPlacement.bottom,
                AppButtonColor.info,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPositionButton(
    BuildContext context,
    String label,
    AppOffcanvasPlacement placement,
    AppButtonColor color,
  ) {
    return AppButton(
      label: '$label Offcanvas',
      color: color,
      onPressed: () {
        AppOffcanvas.show(
          context,
          title: 'Offcanvas $label',
          placement: placement,
          content: const AppOffcanvasBody(
            child: Text('This is a positioned offcanvas example.'),
          ),
        );
      },
    );
  }
}
