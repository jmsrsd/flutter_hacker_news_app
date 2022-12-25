import 'package:flutter/material.dart';
import 'package:flutter_hacker_news_app/src/pages/counter_page.dart';

import 'components/minimum_size_layout.dart';
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
        return MinimumSizeLayout(
          minimumSize: const Size(360, 480),
          child: child,
        );
      },
      home: const CounterPage(),
    );
  }
}
