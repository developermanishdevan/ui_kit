import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class FileUploadSection extends StatefulWidget {
  const FileUploadSection({super.key});

  @override
  State<FileUploadSection> createState() => _FileUploadSectionState();
}

class _FileUploadSectionState extends State<FileUploadSection> {
  final List<AppFile> _files = [
    AppFile(
      name: 'file-1.jpg',
      size: '2.3 MB',
      extension: 'jpg',
      isImage: true,
      previewPath:
          'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=100&h=100&fit=crop',
    ),
    AppFile(name: 'document.pdf', size: '1.2 MB', extension: 'pdf'),
  ];

  void _addFile() {
    setState(() {
      _files.add(
        AppFile(
          name: 'new-file-${_files.length + 1}.png',
          size: '450 KB',
          extension: 'png',
          isImage: true,
          previewPath:
              'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=100&h=100&fit=crop',
        ),
      );
    });
  }

  void _removeFile(AppFile file) {
    setState(() {
      _files.remove(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('File Uploads', style: AppTypography.h4),
          const SizedBox(height: 24),

          _buildCard(
            title: 'Dropzone File Upload',
            subtitle:
                'DropzoneJS is an open source library that provides drag’n’drop file uploads with image previews.',
            child: AppFileUpload(
              label: 'Upload Files',
              text: 'Drop files here or click to upload.',
              helpText:
                  '(This is just a demo. Selected files are not actually uploaded.)',
              files: _files,
              onAdd: _addFile,
              onRemove: _removeFile,
            ),
          ),

          const SizedBox(height: 32),

          _buildCard(
            title: 'Basic Dropzone',
            subtitle: 'A standalone dropzone without automatic file listing.',
            child: AppDropzone(
              onTap: _addFile,
              title: 'Click to select files',
              icon: const Icon(Icons.upload_file),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    final theme = Theme.of(context).extension<AppColorsExtension>()!;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.h5.copyWith(color: theme.bodyColor)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySm.copyWith(
              color: theme.bodySecondaryColor,
            ),
          ),
          const Divider(height: 32),
          child,
        ],
      ),
    );
  }
}
