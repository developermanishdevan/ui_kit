// import 'package:flutter/material.dart';
// import 'package:ui_kit/ui_kit.dart';
// import 'package:flutter_quill/flutter_quill.dart';

// class EditorSection extends StatefulWidget {
//   const EditorSection({super.key});

//   @override
//   State<EditorSection> createState() => _EditorSectionState();
// }

// class _EditorSectionState extends State<EditorSection> {
//   late QuillController _snowController;
//   late QuillController _bubbleController;

//   @override
//   void initState() {
//     super.initState();

//     // Initial content mimicking React reference
//     final initialContent = [
//       {
//         'insert': 'Hello World!\n',
//         'attributes': {'header': 3, 'size': 'large'},
//       },
//       {
//         'insert': '\nThis is a simple editable area.\n\n',
//         'attributes': {'header': 3},
//       },
//       {
//         'insert': 'Select a text to reveal the toolbar.\n',
//         'attributes': {'list': 'bullet'},
//       },
//       {
//         'insert': 'Edit rich document on-the-fly, so elastic!\n',
//         'attributes': {'list': 'bullet'},
//       },
//       {'insert': '\nEnd of simple area\n'},
//     ];

//     _snowController = QuillController(
//       document: Document.fromJson(initialContent),
//       selection: const TextSelection.collapsed(offset: 0),
//     );

//     _bubbleController = QuillController(
//       document: Document.fromJson(initialContent),
//       selection: const TextSelection.collapsed(offset: 0),
//     );
//   }

//   @override
//   void dispose() {
//     _snowController.dispose();
//     _bubbleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Editors', style: AppTypography.h4),
//           const SizedBox(height: 24),

//           _buildCard(
//             title: 'Snow Editor',
//             subtitle: 'Snow is a clean, flat toolbar theme.',
//             child: AppEditor(
//               controller: _snowController,
//               variant: AppEditorVariant.snow,
//               placeholder: 'Compose an epic...',
//             ),
//           ),

//           const SizedBox(height: 32),

//           _buildCard(
//             title: 'Bubble Editor',
//             subtitle: 'Bubble is a polished tooltip based theme.',
//             child: AppEditor(
//               controller: _bubbleController,
//               variant: AppEditorVariant.bubble,
//               placeholder: 'Compose an epic...',
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCard({
//     required String title,
//     required String subtitle,
//     required Widget child,
//   }) {
//     final theme = Theme.of(context).extension<AppColorsExtension>()!;
//     return AppCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: AppTypography.h5.copyWith(color: theme.bodyColor),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             subtitle,
//             style: AppTypography.bodySm.copyWith(
//               color: theme.bodySecondaryColor,
//             ),
//           ),
//           const Divider(height: 32),
//           child,
//         ],
//       ),
//     );
//   }
// }
