import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// Represents the state of a single step in the [AppStepper].
enum AppStepState { inactive, active, completed, error }

/// A class representing a single step in a stepper.
class AppStep {
  /// The main title of the step.
  final String title;

  /// Optional subtitle or helper text.
  final String? subtitle;

  /// The content to display when this step is active (mostly used in vertical orientation).
  final Widget? content;

  /// Optional custom icon for the step indicator.
  final Widget? icon;

  /// The state of this specific step. If not provided, [AppStepper] calculates it based on index.
  final AppStepState? state;

  const AppStep({
    required this.title,
    this.subtitle,
    this.content,
    this.icon,
    this.state,
  });
}

/// Defines the layout orientation of the stepper.
enum AppStepperOrientation { horizontal, vertical }

/// A highly customizable Stepper component following the UI Kit design system.
/// Supports horizontal and vertical orientations, semantic tokens, and accessibility.
class AppStepper extends AppStatelessWrapper {
  /// The list of steps to display.
  final List<AppStep> steps;

  /// The index of the currently active step (0-indexed).
  final int currentStep;

  /// Whether the stepper is horizontal or vertical.
  final AppStepperOrientation orientation;

  /// Callback when a step is tapped (optional, enables interaction).
  final ValueChanged<int>? onStepTapped;

  const AppStepper({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.orientation = AppStepperOrientation.vertical,
    this.onStepTapped,
  });

  @override
  Widget buildWidget(BuildContext context) {
    if (orientation == AppStepperOrientation.vertical) {
      return _buildVerticalStepper(context);
    }
    return _buildHorizontalStepper(context);
  }

  Widget _buildVerticalStepper(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        final isLast = index == steps.length - 1;
        return _buildVerticalStep(context, index, isLast);
      }),
    );
  }

  Widget _buildVerticalStep(BuildContext context, int index, bool isLast) {
    final step = steps[index];
    final stepState = _getStepState(index);
    final theme = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIndicatorColumn(context, index, isLast, stepState),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: spacing.s3,
                bottom: isLast ? 0 : spacing.s4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInteractiveWidget(
                    onTap: onStepTapped != null
                        ? () => onStepTapped!(index)
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: AppTypography.bodyBase.copyWith(
                            fontWeight: stepState == AppStepState.active
                                ? AppTypography.semiBold
                                : AppTypography.medium,
                            color: stepState == AppStepState.inactive
                                ? theme.bodySecondaryColor
                                : theme.textEmphasis,
                          ),
                        ),
                        if (step.subtitle != null)
                          Text(
                            step.subtitle!,
                            style: AppTypography.bodySm.copyWith(
                              color: theme.bodySecondaryColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (step.content != null)
                    AppCollapse(
                      show: index == currentStep,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: spacing.s3,
                          bottom: spacing.s2,
                        ),
                        child: step.content!,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorColumn(
    BuildContext context,
    int index,
    bool isLast,
    AppStepState state,
  ) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Column(
      children: [
        _buildStepIndicator(context, index, state),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2,
              margin: EdgeInsets.symmetric(vertical: spacing.s1),
              color: state == AppStepState.completed
                  ? theme.primary
                  : theme.borderColor,
            ),
          ),
      ],
    );
  }

  Widget _buildHorizontalStepper(BuildContext context) {
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Row(
      children: List.generate(steps.length, (index) {
        final isLast = index == steps.length - 1;
        return Expanded(
          flex: isLast ? 0 : 1,
          child: Row(
            children: [
              _buildHorizontalStepContent(context, index),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    margin: EdgeInsets.symmetric(horizontal: spacing.s3),
                    color: _getStepState(index) == AppStepState.completed
                        ? context.theme.extension<AppColorsExtension>()!.primary
                        : context.theme
                              .extension<AppColorsExtension>()!
                              .borderColor,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHorizontalStepContent(BuildContext context, int index) {
    final step = steps[index];
    final state = _getStepState(index);
    final theme = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return AppInteractiveWidget(
      onTap: onStepTapped != null ? () => onStepTapped!(index) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepIndicator(context, index, state),
          SizedBox(height: spacing.s2),
          Text(
            step.title,
            style: AppTypography.bodySm.copyWith(
              fontWeight: state == AppStepState.active
                  ? AppTypography.semiBold
                  : AppTypography.medium,
              color: state == AppStepState.inactive
                  ? theme.bodySecondaryColor
                  : theme.textEmphasis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(
    BuildContext context,
    int index,
    AppStepState state,
  ) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final step = steps[index];

    Color bgColor;
    Color iconColor;
    Widget? icon;

    switch (state) {
      case AppStepState.active:
        bgColor = theme.primary;
        iconColor = Colors.white;
        icon =
            step.icon ??
            Text(
              (index + 1).toString(),
              style: AppTypography.bodyXs.copyWith(
                color: iconColor,
                fontWeight: AppTypography.bold,
              ),
            );
        break;
      case AppStepState.completed:
        bgColor = theme.primary;
        iconColor = Colors.white;
        icon =
            step.icon ?? const Icon(Icons.check, size: 16, color: Colors.white);
        break;
      case AppStepState.error:
        bgColor = theme.danger;
        iconColor = Colors.white;
        icon = const Icon(Icons.error_outline, size: 16, color: Colors.white);
        break;
      case AppStepState.inactive:
        bgColor = theme.bodySecondaryBg;
        iconColor = theme.bodySecondaryColor;
        icon =
            step.icon ??
            Text(
              (index + 1).toString(),
              style: AppTypography.bodyXs.copyWith(
                color: iconColor,
                fontWeight: AppTypography.bold,
              ),
            );
        break;
    }

    return AppSemantics(
      label: 'Step ${index + 1}: ${step.title}',
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: state == AppStepState.active
              ? Border.all(color: theme.primary.withAlpha(50), width: 4)
              : null,
        ),
        child: Center(child: icon),
      ),
    );
  }

  AppStepState _getStepState(int index) {
    final step = steps[index];
    if (step.state != null) return step.state!;

    if (index < currentStep) return AppStepState.completed;
    if (index == currentStep) return AppStepState.active;
    return AppStepState.inactive;
  }
}
