import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AlertSection extends StatelessWidget {
  const AlertSection({super.key});

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
              'Alerts',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Alerts',
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
                  Expanded(child: _buildBasicAlerts(context)),
                  const SizedBox(width: AppSpacing.s4),
                  Expanded(child: _buildDismissibleAlerts(context)),
                ],
              );
            }
            return Column(
              children: [
                _buildBasicAlerts(context),
                const SizedBox(height: AppSpacing.s4),
                _buildDismissibleAlerts(context),
              ],
            );
          },
        ),

        const SizedBox(height: AppSpacing.s4),
        _buildIconAlerts(context),

        const SizedBox(height: AppSpacing.s4),
        _buildAdditionalContentAlerts(context),
      ],
    );
  }

  Widget _buildBasicAlerts(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(context, 'Basic Example'),
          const AppAlert(
            variant: AppAlertVariant.primary,
            message: 'A simple primary alert—check it out!',
          ),
          const AppAlert(
            variant: AppAlertVariant.secondary,
            message: 'A simple secondary alert—check it out!',
          ),
          const AppAlert(
            variant: AppAlertVariant.success,
            message: 'A simple success alert—check it out!',
          ),
          const AppAlert(
            variant: AppAlertVariant.danger,
            message: 'A simple danger alert—check it out!',
          ),
        ],
      ),
    );
  }

  Widget _buildDismissibleAlerts(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(context, 'Dismissible Alerts'),
          const AppAlert(
            variant: AppAlertVariant.warning,
            message: 'A simple warning alert—check it out!',
            dismissible: true,
          ),
          const AppAlert(
            variant: AppAlertVariant.info,
            message: 'A simple info alert—check it out!',
            dismissible: true,
          ),
          const AppAlert(
            variant: AppAlertVariant.dark,
            message: 'A simple dark alert—check it out!',
            dismissible: true,
          ),
          const AppAlert(
            variant: AppAlertVariant.primary,
            message: 'A simple primary alert—check it out!',
            dismissible: true,
          ),
        ],
      ),
    );
  }

  Widget _buildIconAlerts(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(context, 'Icons Alert Example'),
          AppAlert(
            variant: AppAlertVariant.primary,
            message: 'A simple primary alert—check it out!',
            icon: _buildSmallAvatarIcon(theme.primary, Icons.info_outline),
          ),
          AppAlert(
            variant: AppAlertVariant.success,
            message: 'A simple success alert—check it out!',
            icon: _buildSmallAvatarIcon(
              theme.success,
              Icons.check_circle_outline,
            ),
          ),
          AppAlert(
            variant: AppAlertVariant.danger,
            message: 'A simple danger alert—check it out!',
            icon: _buildSmallAvatarIcon(theme.danger, Icons.error_outline),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalContentAlerts(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardTitle(context, 'Additional Content Alert Example'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppAlert(
                  variant: AppAlertVariant.primary,
                  heading: 'Well done!',
                  message:
                      'Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.',
                ),
              ),
              const SizedBox(width: AppSpacing.s3),
              Expanded(
                child: AppAlert(
                  variant: AppAlertVariant.secondary,
                  heading: 'Attention!',
                  message:
                      'Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallAvatarIcon(Color color, IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }

  Widget _buildCardTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s4),
      child: Text(
        title,
        style: AppTypography.h6.copyWith(
          fontWeight: AppTypography.semiBold,
          color: Theme.of(
            context,
          ).extension<AppColorsExtension>()!.textEmphasis,
        ),
      ),
    );
  }
}
