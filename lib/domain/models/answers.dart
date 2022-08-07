import 'package:freezed_annotation/freezed_annotation.dart';

part 'answers.g.dart';

@JsonSerializable()
class Answer {
  String id;
  String? answer;
  bool isCorrect;

  Answer({
    required this.id,
    this.answer,
    this.isCorrect = false,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
