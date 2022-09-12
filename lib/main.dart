import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/login/login_screen.dart';
import 'view/login/login_viewmodel.dart';
import 'view/score/score_screen.dart';

import 'core/initial/splash/splash_screen.dart';
import 'test_widget.dart';
import 'view/quiz/question.screen.dart';
import 'view/quiz/question_viewmodel.dart';
import 'view/undefined/undefined.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider<QuestionProvider>(
          create: (_) => QuestionProvider(),
        ),
      ],
      child: MaterialApp(
        // Theme
        theme: ThemeData.dark().copyWith(
          // Card Theme
          cardTheme: const CardTheme(color: Colors.white),

          //Text Theme
          textTheme: const TextTheme(
            headline6:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            subtitle1: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
            subtitle2: TextStyle(
              color: Colors.purple,
            ),
          ),
          primaryTextTheme: const TextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Material App',

        // Routing
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (context) => const Undefined()),
        initialRoute: 'question',
        routes: {
          'undefined': (context) => const Undefined(),
          'test': (context) => const TestWidgetScreen(),
          'splash': (context) => const Splash(),
          'question': (context) => const QuestionsScreen(),
          'score': (context) => const ScoreScreen(),
          'login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
