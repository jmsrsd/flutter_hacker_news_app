import 'package:flutter/material.dart';

import 'pages/home_page.dart';

import 'styles.dart' as styles;

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HackerNews',
      theme: styles.theme,
      home: const HomePage(),
    );
  }
}
