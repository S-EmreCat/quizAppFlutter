import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  String? category;
  String? id;
  String? correctAnswer;
  List<dynamic>? incorrectAnswers;
  String? question;
  String? difficulty;

  QuestionModel({
    this.category,
    this.id,
    this.correctAnswer,
    this.incorrectAnswers,
    this.question,
    this.difficulty,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return _$QuestionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuestionModelToJson(this);
  }
}
