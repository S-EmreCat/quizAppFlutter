import 'package:flutter/material.dart';

import 'core/initial/splash/splash_screen.dart';
import 'test_widget.dart';
import 'view/undefined/undefined.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   appBarTheme:
      //       const AppBarTheme().copyWith(backgroundColor: Colors.transparent),
      // ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const Undefined()),
      initialRoute: 'splash',
      routes: {
        'test': (context) => const TestWidgetScreen(),
        'splash': (context) => const Splash(),
      },
    );
  }
}
