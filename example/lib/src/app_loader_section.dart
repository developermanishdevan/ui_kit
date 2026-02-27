import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AppLoaderSection extends StatefulWidget {
  const AppLoaderSection({super.key});

  @override
  State<AppLoaderSection> createState() => _AppLoaderSectionState();
}

class _AppLoaderSectionState extends State<AppLoaderSection> {
  bool _isLoading = false;

  void _toggleLoader() {
    setState(() => _isLoading = !_isLoading);
    if (_isLoading) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardHeader(
                context,
                'App Loader Overlay',
                'Full-area loading overlay with spinner and optional text.',
              ),
              AppLoader(
                isLoading: _isLoading,
                loadingText: 'Please wait...',
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: theme.bodySecondaryBg,
                    borderRadius: BorderRadius.circular(AppRadius.base),
                  ),
                  child: Center(
                    child: Text(
                      _isLoading
                          ? 'Overlay is active!'
                          : 'Content behind the loader',
                      style: AppTypography.bodyBase.copyWith(
                        color: theme.bodySecondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              AppButton(
                label: _isLoading ? 'Stop Loading' : 'Show Loader (3 s)',
                onPressed: _toggleLoader,
                icon: AppSpinner(
                  size: AppSpinnerSize.sm,
                  color: Colors.white,
                  type: _isLoading
                      ? AppSpinnerType.grow
                      : AppSpinnerType.border,
                ),
                color: _isLoading
                    ? AppButtonColor.danger
                    : AppButtonColor.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardHeader(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s4),
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
          const SizedBox(height: AppSpacing.s3),
        ],
      ),
    );
  }
}
