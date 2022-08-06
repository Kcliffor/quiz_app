part of 'start_page_bloc.dart';

@immutable
abstract class StartPageEvent {}

class StartPageSelectTopic extends StartPageEvent {
  final String topic;

  StartPageSelectTopic(this.topic);
}

class StartPageSelectComplexity extends StartPageEvent {
  final String complexity;

  StartPageSelectComplexity(this.complexity);
}

class StartPageRunQuiz extends StartPageEvent {}

class StartPageMsgErr extends StartPageEvent {
  final String msg;

  StartPageMsgErr(this.msg);
}
