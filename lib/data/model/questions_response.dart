import 'question_model.dart';

part 'questions_response_g.dart';

class QuestionsResponse {
  final List<QuestionModel> list;

  QuestionsResponse({required this.list});

  factory QuestionsResponse.fromJson(List<dynamic> json) => _$QuestionsResponseFromJson(json);
}
