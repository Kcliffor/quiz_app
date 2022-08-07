part of 'question_page_bloc.dart';

@immutable
abstract class QuestionPageEvent {}

class QuestionPageInit extends QuestionPageEvent {}

class QuestionPageAnswer extends QuestionPageEvent {
  final Answer? selectedAnswer;
  final List<Answer>? selectedAnswers;

  QuestionPageAnswer({this.selectedAnswer, this.selectedAnswers});
}

class QuestionPageMsgErr extends QuestionPageEvent {
  final String msg;

  QuestionPageMsgErr(this.msg);
}
