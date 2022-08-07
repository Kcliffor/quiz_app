part of 'result_page_bloc.dart';

@immutable
abstract class ResultPageEvent {}

class ResultPageSaveResult extends ResultPageEvent {}

class ResultPageMsgErr extends ResultPageEvent {
  final String msg;

  ResultPageMsgErr(this.msg);
}
