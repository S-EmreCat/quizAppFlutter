import 'package:flutter/material.dart';

import '../../core/service/question_service.dart';
import 'question_model.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class QuestionProvider extends ChangeNotifier {
  final _service = QuestionServiceManager();
  bool isLoading = false;
  List<QuestionModel> _datas = [];
  List<QuestionModel> get datas => _datas;
  String? currentQuestion;
  String? currentCorrectAnswer;
  List<dynamic>? inCorrectAnswers;
  int questionIndex = 0;

  final int timerDuration = 10;
  final CountDownController controller = CountDownController();

// fetch all questions
  Future<void> fetchAllQuestions() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.fetchAll();
    _datas = response;
    isLoading = false;
    notifyListeners();
    debugPrint(response.length.toString());
    debugPrint(response[0].question);
    debugPrint('2 ${_datas[0].question}');
    // _currentIncorrectAnswers = response[0].incorrectAnswers;
    // debugPrint(_currentIncorrectAnswers.toString());
  }

  void getQuestion(questionIndex) {
    currentQuestion = _datas[questionIndex].question;
  }

  void getCorrectAnswer(questionIndex) {
    currentCorrectAnswer = _datas[questionIndex].correctAnswer;
  }

  void getInCorrectAnswers(questionIndex) {
    inCorrectAnswers = _datas[questionIndex].incorrectAnswers;
  }

  void incrementQuestionIndex() {
    questionIndex++;
    notifyListeners();
  }

  void clearQuestionIndex() {
    questionIndex = 0;
    notifyListeners();
  }

//TODO: içerideki fonksiyonların notify larını kaldır. Burada sadece kullanmayı dene
  QuestionModel currentModel() {
    getQuestion(questionIndex);
    getCorrectAnswer(questionIndex);
    getInCorrectAnswers(questionIndex);
    return QuestionModel(
        correctAnswer: currentCorrectAnswer,
        incorrectAnswers: inCorrectAnswers,
        question: currentQuestion);
  }
}
