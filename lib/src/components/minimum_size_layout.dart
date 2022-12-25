import 'dart:math';

import 'package:flutter/material.dart';

class MinimumSizeLayout extends StatelessWidget {
  final Size minimumSize;
  final Widget? child;

  const MinimumSizeLayout({
    super.key,
    this.minimumSize = Size.zero,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Widget useSingleChildScrollView({
        required Axis scrollDirection,
        required Widget? child,
      }) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: scrollDirection,
          padding: EdgeInsets.zero,
          child: SizedBox.fromSize(
            size: Size(
              max(constraints.maxWidth, minimumSize.width),
              max(constraints.maxHeight, minimumSize.height),
            ),
            child: child,
          ),
        );
      }

      return Align(
        alignment: Alignment.topLeft,
        child: useSingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: useSingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: child,
          ),
        ),
      );
    });
  }
}
