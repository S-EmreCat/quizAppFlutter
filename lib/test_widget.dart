import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/view/quiz/question_viewmodel.dart';

class TestWidgetScreen extends StatefulWidget {
  const TestWidgetScreen({super.key});

  @override
  State<TestWidgetScreen> createState() => _TestWidgetScreenState();
}

class _TestWidgetScreenState extends State<TestWidgetScreen> {
  late final QuestionProvider dataProvider =
      Provider.of<QuestionProvider>(context, listen: false);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<QuestionProvider>(context, listen: false).fetchAllQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("quiz screen"),
      ),
      body: Consumer<QuestionProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: value.questions.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(index.toString()),
                  Text(value.questions[index].question.toString()),
                  Text(value.questions[index].incorrectAnswers.toString()),
                  Text(value.questions[index].correctAnswer.toString()),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
