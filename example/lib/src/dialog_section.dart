import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class DialogSection extends StatelessWidget {
  const DialogSection({super.key});

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
              'Dialog Models',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Overlays  >  Dialogs',
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
                'Basic Alert Dialog',
                style: AppTypography.h5.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A styled alert dialog helper for sending simple messages.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              AppButton(
                label: 'Show Alert',
                onPressed: () {
                  AppDialog.showAlert(
                    context: context,
                    title: 'Update Downloaded',
                    message:
                        'Your system will restart automatically to apply changes.',
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
                'Confirmation Dialog',
                style: AppTypography.h5.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Actionable confirmation boxes. They return a boolean future depending on the selected action.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppButton(
                    label: 'Standard Confirm',
                    onPressed: () {
                      AppConfirmationDialog.show(
                        context: context,
                        title: 'Save Changes?',
                        message: 'Are you sure you want to save these changes?',
                      );
                    },
                  ),
                  AppButton(
                    label: 'Destructive Confirm',
                    color: AppButtonColor.danger,
                    onPressed: () {
                      AppConfirmationDialog.show(
                        context: context,
                        title: 'Delete Account',
                        message:
                            'This action is irreversible. Are you completely sure?',
                        confirmLabel: 'Delete',
                        isDestructive: true,
                      );
                    },
                  ),
                ],
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
                'Input Dialog',
                style: AppTypography.h5.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A dialog designed explicitly to retrieve quick text input.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              AppButton(
                label: 'Ask for Name',
                onPressed: () {
                  AppInputDialog.show(
                    context: context,
                    title: 'New Project',
                    message: 'Enter a name for your new workspace:',
                    hintText: 'Project Name',
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
                'Full Screen Dialog',
                style: AppTypography.h5.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'A dialog that overtakes the entire screen, often used for complex data entry.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              AppButton(
                label: 'Launch Full Screen',
                color: AppButtonColor.info,
                onPressed: () {
                  AppFullScreenDialog.show(
                    context: context,
                    title: 'Create complex report',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Fill out the entire report below.',
                          style: AppTypography.bodyBase,
                        ),
                        const SizedBox(height: AppSpacing.s4),
                        const AppTextField(hintText: 'Field 1'),
                        const SizedBox(height: AppSpacing.s4),
                        const AppTextField(hintText: 'Field 2'),
                      ],
                    ),
                    footer: AppModalFooter(
                      children: [
                        AppButton(
                          label: 'Cancel',
                          variant: AppButtonVariant.outline,
                          onPressed: () => Navigator.pop(context),
                        ),
                        AppButton(
                          label: 'Submit Full Form',
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
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
