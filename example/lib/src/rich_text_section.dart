import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class RichTextSection extends AppStatelessWrapper {
  const RichTextSection({super.key});

  @override
  Widget buildWidget(BuildContext context) {
    final theme = context.theme.extension<AppColorsExtension>()!;
    final spacing = context.theme.extension<AppSpacingExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rich Text',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Data Display  >  Rich Text',
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
                'Basic Usage',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Combining different styles in a single line of text.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppRichText(
                spans: [
                  const AppRichSpan(text: 'This is a '),
                  const AppRichSpan(text: 'bold ', isBold: true),
                  const AppRichSpan(text: 'and '),
                  const AppRichSpan(
                    text: 'italic ',
                    isBold: false,
                    isItalic: true,
                  ),
                  const AppRichSpan(text: 'text segment.'),
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
                'Interactive Links',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Spans can be interactive and trigger callbacks.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppRichText(
                spans: [
                  const AppRichSpan(text: 'By continuing, you agree to our '),
                  AppRichSpan(
                    text: 'Terms of Service',
                    onTap: () {
                      debugPrint('Tapped Terms');
                    },
                  ),
                  const AppRichSpan(text: ' and '),
                  AppRichSpan(
                    text: 'Privacy Policy',
                    onTap: () {
                      debugPrint('Tapped Privacy');
                    },
                  ),
                  const AppRichSpan(text: '.'),
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
                'Custom Colors & Styling',
                style: AppTypography.h6.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'Apply manual colors or custom text styles to spans.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                ),
              ),
              SizedBox(height: spacing.s4),
              AppRichText(
                spans: [
                  AppRichSpan(
                    text: 'Success! ',
                    color: theme.success,
                    isBold: true,
                  ),
                  const AppRichSpan(text: 'Your account has been created. '),
                  AppRichSpan(
                    text: 'View Details',
                    isUnderlined: true,
                    color: theme.primary,
                    onTap: () {},
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
