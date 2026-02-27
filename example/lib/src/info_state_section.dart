import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class InfoStateSection extends StatelessWidget {
  const InfoStateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                context,
                'Basic Info State',
                'A standard informational state with no actions.',
              ),
              const SizedBox(height: AppSpacing.s4),
              _previewContainer(
                context,
                child: AppInfoState(
                  title: 'No Data Available',
                  message:
                      'We could not find any records matching your search criteria. Try adjusting your filters.',
                  icon: Icons.search_off_rounded,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                context,
                'Info State with Action',
                'Include primary actions to help users recover or proceed.',
              ),
              const SizedBox(height: AppSpacing.s4),
              _previewContainer(
                context,
                child: AppInfoState(
                  title: 'Connection Lost',
                  message:
                      'We are unable to connect to the server. Please check your internet connection.',
                  icon: Icons.wifi_off_rounded,
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.danger,
                  actionLabel: 'Try Again',
                  actionButtonColor: AppButtonColor.danger,
                  onAction: () {
                    AppToastManager.show(
                      context,
                      title: 'Retrying connection...',
                      description: '',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                context,
                'Success State',
                'Demonstrating a success context using custom colors and icons.',
              ),
              const SizedBox(height: AppSpacing.s4),
              _previewContainer(
                context,
                child: AppInfoState(
                  title: 'Payment Successful',
                  message:
                      'Your transaction was completed successfully. A receipt has been sent to your email.',
                  icon: Icons.check_circle_rounded,
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.success,
                  actionLabel: 'View Receipt',
                  actionIcon: const Icon(Icons.receipt_long_rounded),
                  actionButtonColor: AppButtonColor.success,
                  onAction: () {
                    AppToastManager.show(
                      context,
                      description: 'Opening receipt...',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                context,
                'Custom Illustration State',
                'Bypass the default icon container to inject your own custom widget.',
              ),
              const SizedBox(height: AppSpacing.s4),
              _previewContainer(
                context,
                child: AppInfoState(
                  title: 'You\'re All Caught Up',
                  message:
                      'You have no pending notifications or alerts at this moment.',
                  customIcon: Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s4),
                    child: Icon(
                      Icons.notifications_paused_rounded,
                      size: 80,
                      color: Theme.of(context)
                          .extension<AppColorsExtension>()!
                          .primary
                          .withValues(alpha: 0.5),
                    ),
                  ),
                  actionLabel: 'Refresh',
                  actionIcon: const Icon(Icons.refresh_rounded),
                  actionButtonColor: AppButtonColor.primary,
                  onAction: () {
                    AppToastManager.show(
                      context,
                      description: 'Refreshing notifications...',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _previewContainer(BuildContext context, {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).extension<AppColorsExtension>()!.bodySecondaryBg,
        borderRadius: BorderRadius.circular(AppRadius.base),
      ),
      child: child,
    );
  }

  Widget _cardHeader(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.h6.copyWith(
              fontWeight: AppTypography.semiBold,
              color: theme.textEmphasis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySm.copyWith(
              color: theme.bodySecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
