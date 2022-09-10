import 'package:flutter/cupertino.dart';
import '../../core/service/question_service.dart';
import 'question_model.dart';

class QuestionProvider extends ChangeNotifier {
  final _service = QuestionServiceManager();
  bool isLoading = false;
  List<QuestionModel> _questions = [];
  List<QuestionModel> get questions => _questions;

  Future<void> fetchAllQuestions() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.fetchAll();
    _questions = response;
    isLoading = false;
    notifyListeners();
    debugPrint(response.length.toString());
    debugPrint(response[0].question);
    debugPrint('2 ${_questions[0].question}');
  }
}
