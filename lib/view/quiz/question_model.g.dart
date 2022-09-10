// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      category: json['category'] as String?,
      id: json['id'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
      incorrectAnswers: (json['incorrectAnswers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      question: json['question'] as String?,
      difficulty: json['difficulty'] as String?,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'id': instance.id,
      'correctAnswer': instance.correctAnswer,
      'incorrectAnswers': instance.incorrectAnswers,
      'question': instance.question,
      'difficulty': instance.difficulty,
    };
