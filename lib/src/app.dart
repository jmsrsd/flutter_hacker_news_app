import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/src/pages/home_page.dart';

import 'styles.dart' as styles;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HackerNews',
      theme: styles.theme,
      builder: (context, child) {
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
                  max(constraints.maxWidth, kToolbarHeight * 7),
                  max(constraints.maxHeight, kToolbarHeight * (7 * 4.0) / 3.0),
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
      },
      home: const HomePage(),
    );
  }
}
