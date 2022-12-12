import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.page.dart';

class App extends StatelessWidget {
  const App({super.key});

  TextTheme useTextTheme(TextTheme textTheme) {
    return GoogleFonts.rubikTextTheme(textTheme);
  }

  ThemeData useTheme() {
    var data = ThemeData.light(useMaterial3: true);

    data = data.copyWith(
      textTheme: useTextTheme(data.textTheme),
      primaryTextTheme: useTextTheme(data.primaryTextTheme),
    );

    return data;
  }

  @override
  Widget build(BuildContext context) {
    const title = 'HackerNews';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: useTheme(),
      home: const HomePage(title: title),
    );
  }
}
