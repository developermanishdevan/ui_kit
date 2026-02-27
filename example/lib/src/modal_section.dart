import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ModalSection extends StatelessWidget {
  const ModalSection({super.key});

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
              'Modals',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Modals',
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
                      Expanded(child: _buildDefaultModalCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildModalPositionCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildModalSizesCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildModalAlertsCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildDefaultModalCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildModalPositionCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildModalSizesCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildModalAlertsCard(context),
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

  Widget _buildDefaultModalCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Default Modals',
            'Toggle a working modal demo by clicking the button below. It will slide down and fade in from the top of the page.',
          ),
          AppButton(
            label: 'Launch demo modal',
            onPressed: () {
              AppModal.show(
                context,
                title: 'Modal title',
                content: const AppModalBody(
                  child: Text("Woo-hoo, you're reading this text in a modal!"),
                ),
                footer: AppModalFooter(
                  children: [
                    AppButton(
                      label: 'Close',
                      variant: AppButtonVariant.soft,
                      color: AppButtonColor.secondary,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    AppButton(
                      label: 'Save changes',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModalPositionCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Modal Position',
            'Vertically center the modal or position it at the top of the viewport.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppButton(
                label: 'Vertically centered',
                onPressed: () {
                  AppModal.show(
                    context,
                    title: 'Centered Modal',
                    centered: true,
                    content: const AppModalBody(
                      child: Text('This is a vertically centered modal.'),
                    ),
                  );
                },
              ),
              AppButton(
                label: 'Top positioned',
                color: AppButtonColor.success,
                onPressed: () {
                  AppModal.show(
                    context,
                    title: 'Top Modal',
                    centered: false,
                    content: const AppModalBody(
                      child: Text('This modal appears at the top of the page.'),
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

  Widget _buildModalSizesCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Optional Sizes',
            'Modals have five optional sizes, available via modifier classes. These sizes kick in at certain breakpoints.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSizeButton(context, 'Small', AppModalSize.sm),
              _buildSizeButton(context, 'Medium', AppModalSize.md),
              _buildSizeButton(context, 'Large', AppModalSize.lg),
              _buildSizeButton(context, 'Extra Large', AppModalSize.xl),
              _buildSizeButton(context, 'Full screen', AppModalSize.fullScreen),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeButton(
    BuildContext context,
    String label,
    AppModalSize size,
  ) {
    return AppButton(
      label: label,
      onPressed: () {
        AppModal.show(
          context,
          title: '$label Modal',
          size: size,
          content: AppModalBody(child: Text('This is a $label modal example.')),
        );
      },
    );
  }

  Widget _buildModalAlertsCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Modal Based Alerts',
            'Use modals as alerts for critical feedback with themed background colors.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildAlertButton(context, 'Primary', AppButtonColor.primary),
              _buildAlertButton(context, 'Success', AppButtonColor.success),
              _buildAlertButton(context, 'Info', AppButtonColor.info),
              _buildAlertButton(context, 'Danger', AppButtonColor.danger),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertButton(
    BuildContext context,
    String label,
    AppButtonColor color,
  ) {
    return AppButton(
      label: label,
      color: color,
      onPressed: () {
        final theme = Theme.of(context).extension<AppColorsExtension>()!;
        Color bg;
        switch (color) {
          case AppButtonColor.primary:
            bg = theme.primary;
            break;
          case AppButtonColor.success:
            bg = theme.success;
            break;
          case AppButtonColor.info:
            bg = theme.info;
            break;
          case AppButtonColor.danger:
            bg = theme.danger;
            break;
          default:
            bg = theme.primary;
        }

        AppModal.show(
          context,
          backgroundColor: bg,
          textColor: Colors.white,
          size: AppModalSize.sm,
          content: AppModalBody(
            child: Column(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Well Done!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cras mattis consectetur purus sit amet fermentum.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                AppButton(
                  label: 'Continue',
                  color: AppButtonColor.light,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
