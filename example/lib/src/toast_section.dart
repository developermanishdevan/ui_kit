import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ToastSection extends StatefulWidget {
  const ToastSection({super.key});

  @override
  State<ToastSection> createState() => _ToastSectionState();
}

class _ToastSectionState extends State<ToastSection> {
  AppToastPosition _selectedPosition = AppToastPosition.topEnd;

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
              'Toasts',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Base UI  >  Toasts',
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
                      Expanded(child: _buildBasicCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildLiveCard(context)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildCustomCard(context)),
                      const SizedBox(width: AppSpacing.s4),
                      Expanded(child: _buildPlacementCard(context)),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildBasicCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildLiveCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildCustomCard(context),
                const SizedBox(height: AppSpacing.s4),
                _buildPlacementCard(context),
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

  Widget _buildBasicCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Basic Examples',
            'Toasts are as flexible as you need and have very little required markup.',
          ),
          AppToast(
            title: 'App',
            timestamp: '11 mins ago',
            description: 'Hello, world! This is a toast message.',
            icon: Icon(
              Icons.notifications,
              size: 18,
              color: Theme.of(context).extension<AppColorsExtension>()!.primary,
            ),
            onClose: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLiveCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Live example',
            'Click the button below to show a toast that has been hidden by default.',
          ),
          AppButton(
            label: 'Show live toast',
            onPressed: () {
              AppToastManager.show(
                context,
                title: 'App',
                timestamp: 'just now',
                description: 'Hello, world! This is a toast message.',
                icon: Icon(
                  Icons.flash_on,
                  size: 18,
                  color: Theme.of(
                    context,
                  ).extension<AppColorsExtension>()!.primary,
                ),
                position: AppToastPosition.bottomEnd,
              );
            },
          ),
          const SizedBox(height: 10),
          AppButton(
            label: 'Stack toasts',
            color: AppButtonColor.secondary,
            onPressed: () {
              AppToastManager.show(
                context,
                title: 'Stacking',
                timestamp: 'just now',
                description: 'Heads up, toasts will stack automatically.',
                variant: AppToastVariant.primary,
                position: AppToastPosition.topEnd,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Custom Content',
            'Alternatively, you can also add additional controls and components to toasts.',
          ),
          const AppToast(
            description: 'Hello, world! This is a simple toast message.',
          ),
          const SizedBox(height: 10),
          AppToast(
            description: 'Hello, world! This is a themed toast message.',
            variant: AppToastVariant.primary,
            onClose: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPlacementCard(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            context,
            'Placement',
            'Place toasts with defined positions as you need them.',
          ),
          AppDropdown<AppToastPosition>(
            value: _selectedPosition,
            options: AppToastPosition.values.map((pos) {
              return AppDropdownOption(
                value: pos,
                label: pos.toString().split('.').last,
              );
            }).toList(),
            onChanged: (pos) {
              if (pos != null) {
                setState(() => _selectedPosition = pos);
              }
            },
          ),
          const SizedBox(height: 15),
          AppButton(
            label: 'Show at selected position',
            isFullWidth: true,
            onPressed: () {
              AppToastManager.show(
                context,
                title: 'Placement',
                description:
                    'This toast is at ${_selectedPosition.toString().split('.').last}',
                position: _selectedPosition,
                variant: AppToastVariant.info,
              );
            },
          ),
        ],
      ),
    );
  }
}
