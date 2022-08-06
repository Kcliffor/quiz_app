// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['id'] as int,
      question: json['question'] as String,
      description: json['description'] as String?,
      answers: Map<String, String?>.from(json['answers'] as Map),
      multipleCorrectAnswers: json['multiple_correct_answers'] as String,
      correctAnswers: Map<String, String?>.from(json['correct_answers'] as Map),
      correctAnswer: json['correct_answer'] as String?,
      explanation: json['explanation'] as String?,
      tip: json['tip'],
      tags: (json['tags'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'description': instance.description,
      'answers': instance.answers,
      'multiple_correct_answers': instance.multipleCorrectAnswers,
      'correct_answer': instance.correctAnswer,
      'correct_answers': instance.correctAnswers,
      'explanation': instance.explanation,
      'tip': instance.tip,
      'tags': instance.tags,
      'category': instance.category,
      'difficulty': instance.difficulty,
    };
