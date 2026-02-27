import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class ContextMenuSection extends StatefulWidget {
  const ContextMenuSection({super.key});

  @override
  State<ContextMenuSection> createState() => _ContextMenuSectionState();
}

class _ContextMenuSectionState extends State<ContextMenuSection> {
  String _selectedValue = 'None';

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
              'Context Menu',
              style: AppTypography.h4.copyWith(
                fontWeight: AppTypography.semiBold,
                color: theme.textEmphasis,
              ),
            ),
            Text(
              'Overlays  >  Context Menu',
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
                'Contextual popup options',
                style: AppTypography.h5.copyWith(
                  fontWeight: AppTypography.semiBold,
                  color: theme.textEmphasis,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Uses a standard popup menu but heavily integrates into our design system with appropriate typography, destructive states, icons, and colors.',
                style: AppTypography.bodySm.copyWith(
                  color: theme.bodySecondaryColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
              Row(
                children: [
                  AppContextMenu<String>(
                    onSelected: (value) =>
                        setState(() => _selectedValue = value),
                    items: const [
                      AppContextMenuEntry(
                        value: 'edit',
                        label: 'Edit Configuration',
                        icon: Icons.edit_outlined,
                      ),
                      AppContextMenuEntry(
                        value: 'copy',
                        label: 'Copy link',
                        icon: Icons.link,
                      ),
                      AppContextMenuEntry(
                        value: 'delete',
                        label: 'Delete Resource',
                        icon: Icons.delete_outline,
                        isDestructive: true,
                      ),
                    ],
                    child: AppButton(
                      label: 'Settings Actions',
                      icon: const Icon(Icons.settings),
                      onPressed:
                          () {}, // The wrapper catches taps, but setting it forces button to look enabled
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s4),
                  Text(
                    'Selected Action: $_selectedValue',
                    style: AppTypography.bodyBase,
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
