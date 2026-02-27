import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BottomSheetSection extends StatelessWidget {
  const BottomSheetSection({super.key});

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
              'Bottom Sheets',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Overlays  >  Bottom Sheets',
              style: AppTypography.bodySm.copyWith(
                color: theme.bodySecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s4),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Standard Bottom Sheet',
                style: AppTypography.h5.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A basic bottom sheet that slides up from the bottom of the screen. Handled nicely within the mobile constraints.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              AppButton(
                label: 'Show Standard Bottom Sheet',
                onPressed: () {
                  AppBottomSheet.show(
                    context: context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('I am a bottom sheet!', style: AppTypography.h5),
                        const SizedBox(height: AppSpacing.s4),
                        Text(
                          'You can put any widget in here. It automatically sizes to wrap content.',
                        ),
                        const SizedBox(height: AppSpacing.s4),
                        AppButton(
                          label: 'Close',
                          variant: AppButtonVariant.outline,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.s4),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Draggable Bottom Sheet',
                style: AppTypography.h5.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A bottom sheet that can be dragged up or down to reveal more or less content.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              AppButton(
                label: 'Show Draggable Sheet',
                color: AppButtonColor.success,
                onPressed: () {
                  AppDraggableBottomSheet.show(
                    context: context,
                    initialChildSize: 0.4,
                    minChildSize: 0.2,
                    maxChildSize: 0.9,
                    builder: (context, scrollController) {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: 25,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(
                              Icons.star,
                              color: theme.bodySecondaryColor,
                            ),
                            title: Text('Draggable Item $index'),
                            onTap: () {},
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
