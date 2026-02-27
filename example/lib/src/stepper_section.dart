import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class StepperSection extends StatefulWidget {
  const StepperSection({super.key});

  @override
  State<StepperSection> createState() => _StepperSectionState();
}

class _StepperSectionState extends State<StepperSection> {
  int _currentStep1 = 0;
  int _currentStep2 = 1;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Stepper',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Data Display  >  Stepper',
              style: AppTypography.bodySm.copyWith(
                color: theme.bodySecondaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spacing.s4),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vertical Stepper',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Standard vertical stepper with collapsible content.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppStepper(
                currentStep: _currentStep1,
                onStepTapped: (index) => setState(() => _currentStep1 = index),
                steps: [
                  AppStep(
                    title: 'Account Information',
                    subtitle: 'Setup your login details',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter your email and password to continue.',
                        ),
                        SizedBox(height: spacing.s3),
                        AppButton(
                          label: 'Next Step',
                          onPressed: () => setState(() => _currentStep1 = 1),
                        ),
                      ],
                    ),
                  ),
                  AppStep(
                    title: 'Personal Details',
                    subtitle: 'Tell us more about yourself',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'We need your name and address for verification.',
                        ),
                        SizedBox(height: spacing.s3),
                        Row(
                          children: [
                            AppButton(
                              label: 'Back',
                              variant: AppButtonVariant.outline,
                              onPressed: () =>
                                  setState(() => _currentStep1 = 0),
                            ),
                            SizedBox(width: spacing.s2),
                            AppButton(
                              label: 'Finalize',
                              onPressed: () =>
                                  setState(() => _currentStep1 = 2),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const AppStep(
                    title: 'Review & Submit',
                    subtitle: 'Confirm your application',
                    content: Text('All set! Click finish to submit.'),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: spacing.s4),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Horizontal Stepper',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Compact horizontal stepper for linear processes.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppStepper(
                orientation: AppStepperOrientation.horizontal,
                currentStep: _currentStep2,
                onStepTapped: (index) => setState(() => _currentStep2 = index),
                steps: const [
                  AppStep(title: 'Cart'),
                  AppStep(title: 'Address'),
                  AppStep(title: 'Payment'),
                  AppStep(title: 'Confirm'),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: spacing.s4),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step States',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Visual indicators for completed, active, and error states.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppStepper(
                steps: [
                  const AppStep(
                    title: 'Completed Task',
                    state: AppStepState.completed,
                  ),
                  const AppStep(
                    title: 'Current Mission',
                    subtitle: 'Action required',
                    state: AppStepState.active,
                  ),
                  const AppStep(
                    title: 'Failed Validation',
                    subtitle: 'Fix issues below',
                    state: AppStepState.error,
                  ),
                  const AppStep(
                    title: 'Upcoming Goal',
                    state: AppStepState.inactive,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
