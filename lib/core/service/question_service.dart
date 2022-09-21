import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../view/quiz/question_model.dart';
import '../constants/service_constants.dart';

class QuestionServiceManager {
  Future<List<QuestionModel>> fetchAll() async {
    final url = ServiceConstants.urlCustom;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final questions = json.map((e) {
        return QuestionModel(
          id: e['id'],
          category: e['category'],
          correctAnswer: e['correctAnswer'],
          incorrectAnswers: e['incorrectAnswers'],
          question: e['question'],
          difficulty: e['difficulty'],
        );
      }).toList();
      return questions;
    }
    return [];
  }
}
