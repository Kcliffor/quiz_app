part of 'question_page_bloc.dart';

class QuestionPageState {
  bool onAwait;
  String errMsg;
  List<QuestionModel> questionList;
  QuestionModel? currentQuestion;
  List<Answer>? answers;
  String selectedTopic;
  String selectedComplexity;

  QuestionPageState({
    this.onAwait = false,
    this.questionList = const [],
    this.currentQuestion,
    this.answers,
    this.errMsg = '',
    this.selectedTopic = '',
    this.selectedComplexity = '',
  });

  QuestionPageState copyWith({
    bool? onAwait,
    String? errMsg,
    List<QuestionModel>? questionList,
    QuestionModel? currentQuestion,
    List<Answer>? answers,
    String? selectedTopic,
    String? selectedComplexity,
  }) {
    return QuestionPageState(
      onAwait: onAwait ?? this.onAwait,
      errMsg: errMsg ?? this.errMsg,
      questionList: questionList ?? this.questionList,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      answers: answers ?? this.answers,
      selectedTopic: selectedTopic ?? this.selectedTopic,
      selectedComplexity: selectedComplexity ?? this.selectedComplexity,
    );
  }
}
