import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'question_viewmodel.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<QuestionProvider>(context, listen: false).getAllQuestions();
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
            itemCount: 100,
            itemBuilder: (context, index) {
              inspect(value.questions);
              return Column(
                children: [
                  const Text('test'),
                  Text(value.questions.toString()),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
