import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/view/login/login_viewmodel.dart';

import 'question_viewmodel.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late final QuestionProvider dataProvider =
      Provider.of<QuestionProvider>(context, listen: false);
  late final LoginViewModel loginProvider =
      Provider.of<LoginViewModel>(context, listen: false);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<QuestionProvider>(context, listen: false).fetchAllQuestions();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LoginViewModel>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loginProvider.nickName ?? "Null"),
      ),
    );
  }
}
