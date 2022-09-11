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
        ChangeNotifierProvider<LoginViewModel>(create: (_) => LoginViewModel()),
        ChangeNotifierProvider<QuestionProvider>(
            create: (_) => QuestionProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (context) => const Undefined()),
        initialRoute: 'splash',
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
