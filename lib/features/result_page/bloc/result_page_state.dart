part of 'result_page_bloc.dart';

class ResultPageState {
  bool onAwait;
  String errMsg;
  int correctQuestions;
  int totalQuestions;
  String? topic;
  String? complexity;

  ResultPageState({
    this.onAwait = false,
    this.errMsg = '',
    this.topic,
    this.complexity,
    required this.correctQuestions,
    required this.totalQuestions,
  });

  ResultPageState copyWith({
    bool? onAwait,
    String? errMsg,
    String? topic,
    String? complexity,
    int? correctQuestions,
    int? totalQuestions,
  }) {
    return ResultPageState(
      onAwait: onAwait ?? this.onAwait,
      errMsg: errMsg ?? this.errMsg,
      correctQuestions: correctQuestions ?? this.correctQuestions,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      topic: topic ?? this.topic,
      complexity: complexity ?? this.complexity,
    );
  }
}
