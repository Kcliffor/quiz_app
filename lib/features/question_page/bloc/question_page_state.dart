part of 'question_page_bloc.dart';

class QuestionPageState {
  bool onAwait;
  String errMsg;
  String selectedTopic;
  String selectedComplexity;

  QuestionPageState({
    this.onAwait = false,
    this.errMsg = '',
    this.selectedTopic = '',
    this.selectedComplexity = '',
  });

  QuestionPageState copyWith({
    bool? onAwait,
    String? errMsg,
    String? selectedTopic,
    String? selectedComplexity,
  }) {
    return QuestionPageState(
      onAwait: onAwait ?? this.onAwait,
      errMsg: errMsg ?? this.errMsg,
      selectedTopic: selectedTopic ?? this.selectedTopic,
      selectedComplexity: selectedComplexity ?? this.selectedComplexity,
    );
  }
}
