part of 'question_page_bloc.dart';

@immutable
abstract class QuestionPageEvent {}

class QuestionPageInit extends QuestionPageEvent {}

class QuestionPageMsgErr extends QuestionPageEvent {
  final String msg;

  QuestionPageMsgErr(this.msg);
}
