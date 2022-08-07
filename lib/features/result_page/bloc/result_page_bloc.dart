import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/domain/repositories/global_rep.dart';

part 'result_page_event.dart';
part 'result_page_state.dart';
part 'result_page_bloc_state.dart';

class ResultPageBloc extends Bloc<ResultPageEvent, ResultPageBlocState> {
  final ResultPageState pageState;
  final GlobalRep globalRep;

  ResultPageBloc({
    required this.globalRep,
    required this.pageState,
  }) : super(ResultPageDone(pageState)) {
    on<ResultPageSaveResult>(saveResult);
    on<ResultPageMsgErr>(err);
  }

  saveResult(ResultPageSaveResult event, emit) {
    pageState.onAwait = true;
    emit(ResultPageUp(pageState));
    FirebaseFirestore.instance.collection('result').add({
      'correctAnswers': pageState.correctQuestions,
      'totalQuestions': pageState.totalQuestions,
      'dateTime': DateTime.now(),
      'topic': pageState.topic,
      'complexity': pageState.complexity,
    });
    pageState.onAwait = false;
    emit(ResultPageDone(pageState));
  }

  err(ResultPageMsgErr event, emit) {
    pageState
      ..errMsg = event.msg
      ..onAwait = false;
    emit(ResultPageError(pageState));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(ResultPageMsgErr(error.toString()));
    super.onError(error, stackTrace);
  }
}
