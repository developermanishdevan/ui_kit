// import '../../../../ui_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import '../../theme/theme.dart';
// import '../../tokens/tokens.dart';

// enum AppEditorVariant { snow, bubble }

// class $1 extends AppStatefulWrapper {
//   final QuillController controller;
//   final AppEditorVariant variant;
//   final String? placeholder;
//   final bool readOnly;
//   final double height;

//   const AppEditor({
//     super.key,
//     required this.controller,
//     this.variant = AppEditorVariant.snow,
//     this.placeholder,
//     this.readOnly = false,
//     this.height = 300,
//   });

//   @override
//   State<AppEditor> createState() => _AppEditorState();
// }

// class $1 extends AppStatefulWrapperState<$2> {
//   final FocusNode _focusNode = FocusNode();

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget buildWidget(BuildContext context) {
//     final themeExt = Theme.of(context).extension<AppColorsExtension>()!;

//     return Column(
//       children: [
//         if (widget.variant == AppEditorVariant.snow)
//           _buildSnowToolbar(themeExt),
//         Container(
//           height: widget.height,
//           decoration: BoxDecoration(
//             color: themeExt.bodySecondaryBg,
//             border: Border.all(color: themeExt.borderColor),
//             borderRadius: widget.variant == AppEditorVariant.snow
//                 ? const BorderRadius.only(
//                     bottomLeft: Radius.circular(6),
//                     bottomRight: Radius.circular(6),
//                   )
//                 : Theme.of(context).extension<AppRadiusExtension>()!.base,
//           ),
//           child: Stack(
//             children: [
//               QuillEditor.basic(
//                 configurations: QuillEditorConfigurations(
//                   controller: widget.controller,
//                   readOnly: widget.readOnly,
//                   placeholder: widget.placeholder,
//                   padding: EdgeInsets.all(16),
//                   enableInteractiveSelection: true,
//                   expands: true,
//                   customStyles: DefaultStyles(
//                     paragraph: DefaultTextBlockStyle(
//                       Theme.of(context).extension<AppTypographyExtension>()!.bodyBase.copyWith(
//                         color: themeExt.bodyColor,
//                       ),
//                       const VerticalSpacing(0, 0),
//                       const VerticalSpacing(0, 0),
//                       null,
//                     ),
//                     h1: DefaultTextBlockStyle(
//                       Theme.of(context).extension<AppTypographyExtension>()!.h1.copyWith(
//                         color: themeExt.textEmphasis,
//                       ),
//                       const VerticalSpacing(10, 0),
//                       const VerticalSpacing(0, 0),
//                       null,
//                     ),
//                     h2: DefaultTextBlockStyle(
//                       Theme.of(context).extension<AppTypographyExtension>()!.h2.copyWith(
//                         color: themeExt.textEmphasis,
//                       ),
//                       const VerticalSpacing(10, 0),
//                       const VerticalSpacing(0, 0),
//                       null,
//                     ),
//                     h3: DefaultTextBlockStyle(
//                       Theme.of(context).extension<AppTypographyExtension>()!.h3.copyWith(
//                         color: themeExt.textEmphasis,
//                       ),
//                       const VerticalSpacing(10, 0),
//                       const VerticalSpacing(0, 0),
//                       null,
//                     ),
//                   ),
//                 ),
//                 focusNode: _focusNode,
//               ),
//               if (widget.variant == AppEditorVariant.bubble)
//                 _buildBubbleToolbar(themeExt),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSnowToolbar(AppColorsExtension themeExt) {
//     return Container(
//       decoration: BoxDecoration(
//         color: themeExt.bodyBg,
//         border: Border(
//           top: BorderSide(color: themeExt.borderColor),
//           left: BorderSide(color: themeExt.borderColor),
//           right: BorderSide(color: themeExt.borderColor),
//         ),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(6),
//           topRight: Radius.circular(6),
//         ),
//       ),
//       child: QuillToolbar.simple(
//         configurations: QuillSimpleToolbarConfigurations(
//           controller: widget.controller,
//           showSmallButton: false,
//           showInlineCode: false,
//           showSubscript: true,
//           showSuperscript: true,
//           headerStyleType: HeaderStyleType.dropdown,
//           dialogTheme: QuillDialogTheme(
//             dialogBackgroundColor: themeExt.bodySecondaryBg,
//             labelTextStyle: TextStyle(color: themeExt.bodyColor),
//           ),
//           color: themeExt.bodyBg,
//           buttonOptions: QuillSimpleToolbarButtonOptions(
//             base: QuillToolbarBaseButtonOptions(
//               iconTheme: QuillIconTheme(
//                 iconButtonSelectedData: IconButtonData(
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.all(
//                       themeExt.primary.withValues(alpha: 0.2),
//                     ),
//                     foregroundColor: WidgetStateProperty.all(themeExt.primary),
//                   ),
//                 ),
//                 iconButtonUnselectedData: IconButtonData(
//                   style: ButtonStyle(
//                     foregroundColor: WidgetStateProperty.all(
//                       themeExt.bodySecondaryColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBubbleToolbar(AppColorsExtension themeExt) {
//     // Basic bubble implementation using QuillToolbar positioned top-right
//     // Real bubble editors usually pop up near selection.
//     // For this UI Kit, we'll provide a floating toolbar that appears when focused.
//     return Positioned(
//       top: 8,
//       right: 8,
//       child: AnimatedOpacity(
//         opacity: _focusNode.hasFocus ? 1.0 : 0.0,
//         duration: const Duration(milliseconds: 200),
//         child: Container(
//           decoration: BoxDecoration(
//             color: themeExt.bodyBg,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.2),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//             border: Border.all(color: themeExt.borderColor),
//           ),
//           child: QuillToolbar.simple(
//             configurations: QuillSimpleToolbarConfigurations(
//               controller: widget.controller,
//               showFontFamily: false,
//               showFontSize: false,
//               showBoldButton: true,
//               showItalicButton: true,
//               showUnderLineButton: true,
//               showStrikeThrough: false,
//               showColorButton: false,
//               showBackgroundColorButton: false,
//               showListNumbers: false,
//               showListBullets: false,
//               showListCheck: false,
//               showCodeBlock: false,
//               showQuote: false,
//               showIndent: false,
//               showLink: true,
//               showDirection: false,
//               showSearchButton: false,
//               showSubscript: false,
//               showSuperscript: false,
//               showUndo: false,
//               showRedo: false,
//               showHeaderStyle: false,
//               showAlignmentButtons: false,
//               showSmallButton: true,
//               color: Colors.transparent,
//               buttonOptions: QuillSimpleToolbarButtonOptions(
//                 base: QuillToolbarBaseButtonOptions(
//                   iconTheme: QuillIconTheme(
//                     iconButtonUnselectedData: IconButtonData(
//                       style: ButtonStyle(
//                         foregroundColor: WidgetStateProperty.all(
//                           themeExt.bodyColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
