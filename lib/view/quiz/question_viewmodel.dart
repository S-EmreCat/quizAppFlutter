import 'package:flutter/cupertino.dart';
import '../../core/service/question_service.dart';
import 'question_model.dart';

class QuestionProvider extends ChangeNotifier {
  final _service = QuestionService();
  bool isLoading = false;
  List<QuestionModel> _questions = [];
  List<QuestionModel> get questions => _questions;

  Future<void> getAllQuestions() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll();
    _questions = response;
    isLoading = false;
    notifyListeners();
  }
}
