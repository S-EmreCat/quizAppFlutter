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
        title: const Text("test screen"),
      ),
      body: Consumer<QuestionProvider>(
        builder: (context, dataProvider, child) {
          if (dataProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount: dataProvider.datas.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(index.toString()),
                        const Divider(),
                        Text(dataProvider.datas[index].question.toString()),
                        const Divider(),

                        Text(dataProvider
                            .currentModel()
                            .correctAnswer
                            .toString()),
                        const Divider(),
                        Text(dataProvider
                            .currentModel()
                            .incorrectAnswers
                            .toString()),
                        const Divider(),
                        Text(dataProvider.allAnswers?[0] ?? ''),
                        const Divider(),
                        Text(dataProvider.allAnswers?[1] ?? ''),
                        const Divider(),
                        Text(dataProvider.allAnswers?[2] ?? ''),
                        const Divider(),
                        Text(dataProvider.allAnswers?[3] ?? ''),
                        const Divider(),
                        Text(dataProvider.allAnswers!.length.toString()),
                        const Divider(),
                        // Consumer<LoginViewModel>(
                        //   builder: (context, dataProvider, child) {
                        //     return Text(loginProvider.nickName ?? "Null");
                        //   },
                        // ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    // dataProvider.testFun();
                    // Navigator.pushNamed(context, 'score');
                    if (dataProvider.questionIndex <
                        dataProvider.datas.length - 1) {
                      dataProvider.incrementQuestionIndex();
                      debugPrint("test index ${dataProvider.questionIndex}");
                    } else {
                      dataProvider.clearQuestionIndex();
                      debugPrint("test index ${dataProvider.questionIndex}");
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
