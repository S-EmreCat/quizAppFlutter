import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/login/login_viewmodel.dart';
import 'view/quiz/question_viewmodel.dart';

class TestWidgetScreen extends StatefulWidget {
  const TestWidgetScreen({super.key});

  @override
  State<TestWidgetScreen> createState() => _TestWidgetScreenState();
}

class _TestWidgetScreenState extends State<TestWidgetScreen> {
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
        title: const Text("quiz screen"),
      ),
      body: Consumer<QuestionProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount: value.datas.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(index.toString()),
                        const Divider(),
                        Text(value.datas[index].question.toString()),
                        const Divider(),
                        Text(value.datas[index].correctAnswer.toString()),
                        const Divider(),
                        Text(value.currentModel().correctAnswer.toString()),
                        const Divider(),
                        Text(dataProvider.datas[index].correctAnswer!),
                        Consumer<LoginViewModel>(
                          builder: (context, value, child) {
                            return Text(loginProvider.nickName ?? "Null");
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    if (value.questionIndex < value.datas.length - 1) {
                      value.incrementQuestionIndex();
                      debugPrint("test index ${value.questionIndex}");
                    } else {
                      value.clearQuestionIndex();
                      debugPrint("test index ${value.questionIndex}");
                      Navigator.pushNamed(context, 'score');
                    }
                  },
                  child: const Text("click"),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
