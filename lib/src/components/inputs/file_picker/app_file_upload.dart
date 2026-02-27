import 'package:flutter/material.dart';
import '../../../../ui_kit.dart';

/// Model representing a file for the AppFileUpload component.
class AppFile {
  final String name;
  final String size;
  final String extension;
  final String? previewPath;
  final bool isImage;

  AppFile({
    required this.name,
    required this.size,
    required this.extension,
    this.previewPath,
    this.isImage = false,
  });
}

class AppFileUpload extends AppStatelessWrapper {
  final String? label;
  final String text;
  final String? helpText;
  final Widget? icon;
  final List<AppFile> files;
  final bool showPreview;
  final VoidCallback onAdd;
  final Function(AppFile) onRemove;

  const AppFileUpload({
    super.key,
    this.label,
    this.text = 'Drop files here or click to upload.',
    this.helpText,
    this.icon,
    this.files = const [],
    this.showPreview = true,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget buildWidget(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final spacing = Theme.of(context).extension<AppSpacingExtension>()!;

    return AppSemantics(
      label: label ?? 'File Upload',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: typography.bodyBase.copyWith(
                fontWeight: AppTypography.medium,
                color: colors.bodyColor,
              ),
            ),
            SizedBox(height: spacing.s2),
          ],
          AppDropzone(
            onTap: onAdd,
            title: text,
            subtitle: helpText,
            icon: icon ?? const Icon(Icons.cloud_upload_outlined),
          ),
          if (showPreview && files.isNotEmpty) ...[
            SizedBox(height: spacing.s3),
            ...files.map((file) => _buildFilePreview(context, file)),
          ],
        ],
      ),
    );
  }

  Widget _buildFilePreview(BuildContext context, AppFile file) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;
    final spacing = Theme.of(context).extension<AppSpacingExtension>()!;

    return Padding(
      padding: EdgeInsets.only(top: spacing.s2),
      child: AppCard(
        child: Row(
          children: [
            // Preview Thumbnail or Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.bodySecondaryBg,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: colors.borderColor),
              ),
              clipBehavior: Clip.antiAlias,
              child: file.isImage && file.previewPath != null
                  ? Image.network(
                      file.previewPath!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildExtensionBadge(context, file.extension),
                    )
                  : _buildExtensionBadge(context, file.extension),
            ),
            SizedBox(width: spacing.s3),
            // File Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file.name,
                    style: typography.bodyBase.copyWith(
                      fontWeight: AppTypography.bold,
                      color: colors.bodyColor.withValues(alpha: 0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    file.size,
                    style: typography.bodySm.copyWith(
                      color: colors.bodySecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: spacing.s3),
            // Delete Button
            AppButton(
              label: 'Delete',
              onPressed: () => onRemove(file),
              size: AppButtonSize.sm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExtensionBadge(BuildContext context, String extension) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          extension.toUpperCase(),
          style: typography.bodyXs.copyWith(
            color: Colors.white,
            fontWeight: AppTypography.bold,
          ),
        ),
      ),
    );
  }
}
