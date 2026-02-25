import 'package:flutter/material.dart';

class AppMasonryGrid extends StatelessWidget {
  const AppMasonryGrid({
    required this.children, super.key,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
  });

  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  Widget build(BuildContext context) {
    // Basic masonry using columns for now since no package is available.
    // Real implementation would use flutter_staggered_grid_view.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(crossAxisCount, (colIndex) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: colIndex == 0 ? 0 : crossAxisSpacing / 2,
              right: colIndex == crossAxisCount - 1 ? 0 : crossAxisSpacing / 2,
            ),
            child: Column(
              children: [
                for (int i = colIndex; i < children.length; i += crossAxisCount)
                  Padding(
                    padding: EdgeInsets.only(bottom: mainAxisSpacing),
                    child: children[i],
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
