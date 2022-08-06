import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  int id;
  String question;
  String? description;
  Map<String, String?> answers;
  @JsonKey(name: 'multiple_correct_answers')
  String multipleCorrectAnswers;
  @JsonKey(name: 'correct_answer')
  String? correctAnswer;
  @JsonKey(name: 'correct_answers')
  Map<String, String?> correctAnswers;
  String? explanation;
  dynamic tip;
  List<Map<String, dynamic>> tags;
  String category;
  String difficulty;

  QuestionModel({
    required this.id,
    required this.question,
    this.description,
    required this.answers,
    required this.multipleCorrectAnswers,
    required this.correctAnswers,
    this.correctAnswer,
    this.explanation,
    required this.tip,
    required this.tags,
    required this.category,
    required this.difficulty,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
