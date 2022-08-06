// DO NOT MODIFY

part of 'questions_response.dart';

QuestionsResponse _$QuestionsResponseFromJson(json) => QuestionsResponse(
      list: (json as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
