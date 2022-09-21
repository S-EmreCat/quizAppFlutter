import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../../core/service/question_service.dart';
import 'question_model.dart';

enum SingingCharacter { lafayette, jefferson }

class QuestionProvider extends ChangeNotifier {
  final _service = QuestionServiceManager();
  bool isLoading = false;
  List<QuestionModel> _datas = [];
  List<QuestionModel> get datas => _datas;
  String? currentQuestion;
  String? currentCorrectAnswer;
  List<dynamic>? inCorrectAnswers;
  List<dynamic>? allAnswers = [];
  int questionIndex = 0;

  final int timerDuration = 3;
  final CountDownController controller = CountDownController();

// fetch all questions
  Future<void> fetchAllQuestions() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.fetchAll();
    _datas = response;
    isLoading = false;
    notifyListeners();
  }

  void testFun() {
    debugPrint("test fun");
    if ((questionIndex < 2 &&
        controller.getTime() == timerDuration.toString())) {
      incrementQuestionIndex();
      controller.restart();
    }
    if (questionIndex == 2) {
      controller.reset();
      // TODO : question option kısmı yapıldıktan sonra yorumdan çıkarılacak > score page

      // SchedulerBinding.instance.addPostFrameCallback((_) {
      //   Navigator.pushReplacementNamed(context, 'score');
      // });
    }
  }

  void getQuestion(questionIndex) {
    currentQuestion = _datas[questionIndex].question;
    // notifyListeners();
  }

  void getCorrectAnswer(questionIndex) {
    currentCorrectAnswer = _datas[questionIndex].correctAnswer;
  }

  void getInCorrectAnswers(questionIndex) {
    inCorrectAnswers = _datas[questionIndex].incorrectAnswers;
  }

  void incrementQuestionIndex() {
    questionIndex++;
    debugPrint('index:$questionIndex');
  }

  void clearQuestionIndex() {
    questionIndex = 0;
  }

  QuestionModel currentModel() {
    getQuestion(questionIndex);
    getCorrectAnswer(questionIndex);
    getInCorrectAnswers(questionIndex);
    allAnswers?.addAll(inCorrectAnswers!);
    allAnswers?.add(currentCorrectAnswer!);
    allAnswers!.shuffle();

    return QuestionModel(
        correctAnswer: currentCorrectAnswer,
        incorrectAnswers: inCorrectAnswers,
        question: currentQuestion);
  }
}
