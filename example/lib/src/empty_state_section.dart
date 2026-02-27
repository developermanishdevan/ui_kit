import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class EmptyStateSection extends StatefulWidget {
  const EmptyStateSection({super.key});

  @override
  State<EmptyStateSection> createState() => _EmptyStateSectionState();
}

class _EmptyStateSectionState extends State<EmptyStateSection> {
  AppEmptyStateVariant _emptyStateVariant = AppEmptyStateVariant.empty;

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
                'Feedback States',
                'Tap a variant to preview the state screen.',
              ),
              Wrap(
                spacing: AppSpacing.s2,
                runSpacing: AppSpacing.s2,
                children: AppEmptyStateVariant.values.map((v) {
                  final selected = _emptyStateVariant == v;
                  return AppButton(
                    label: v.name
                        .replaceAllMapped(
                          RegExp(r'([A-Z])'),
                          (m) => ' ${m.group(0)}',
                        )
                        .trim()
                        .capitalizeFirst(),
                    onPressed: () => setState(() => _emptyStateVariant = v),
                    size: AppButtonSize.sm,
                    color: _variantColor(v),
                    variant: selected
                        ? AppButtonVariant.solid
                        : AppButtonVariant.outline,
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.s4),
              AnimatedSwitcher(
                duration: AppDurations.normal,
                child: Container(
                  key: ValueKey(_emptyStateVariant),
                  height: 340,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).extension<AppColorsExtension>()!.bodySecondaryBg,
                    borderRadius: BorderRadius.circular(AppRadius.base),
                  ),
                  child: _buildStateWidget(_emptyStateVariant),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStateWidget(AppEmptyStateVariant variant) {
    switch (variant) {
      case AppEmptyStateVariant.empty:
        return const AppEmptyState(variant: AppEmptyStateVariant.empty);
      case AppEmptyStateVariant.error:
        return const AppErrorState(actionLabel: 'Try Again');
      case AppEmptyStateVariant.noInternet:
        return const AppNoInternetState();
      case AppEmptyStateVariant.maintenance:
        return const AppMaintenanceState();
      case AppEmptyStateVariant.permission:
        return const AppPermissionDeniedState();
      case AppEmptyStateVariant.success:
        return const AppSuccessState();
    }
  }

  AppButtonColor _variantColor(AppEmptyStateVariant v) {
    switch (v) {
      case AppEmptyStateVariant.empty:
        return AppButtonColor.secondary;
      case AppEmptyStateVariant.error:
        return AppButtonColor.danger;
      case AppEmptyStateVariant.noInternet:
        return AppButtonColor.warning;
      case AppEmptyStateVariant.maintenance:
        return AppButtonColor.info;
      case AppEmptyStateVariant.permission:
        return AppButtonColor.dark;
      case AppEmptyStateVariant.success:
        return AppButtonColor.success;
    }
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

extension _CapFirst on String {
  String capitalizeFirst() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
