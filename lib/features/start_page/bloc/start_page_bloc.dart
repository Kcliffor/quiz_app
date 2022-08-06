import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/domain/repositories/global_rep.dart';
import 'package:quiz_app/domain/services/router/delegate.dart';

part 'start_page_bloc_state.dart';
part 'start_page_event.dart';
part 'start_page_state.dart';

class StartPageBloc extends Bloc<StartPageEvent, StartPageBlocState> {
  final StartPageState pageState;
  final GlobalRep globalRep;

  StartPageBloc({
    required this.globalRep,
    required this.pageState,
  }) : super(StartPageInitial(pageState)) {
    on<StartPageSelectTopic>(selectTopic);
    on<StartPageSelectComplexity>(selectComplexity);
    on<StartPageRunQuiz>(run);
    on<StartPageMsgErr>(err);
  }

  selectTopic(StartPageSelectTopic event, emit) {
    pageState.topic = event.topic;
    emit(StartPageTopicSelected(pageState));
  }

  selectComplexity(StartPageSelectComplexity event, emit) {
    pageState.complexity = event.complexity;
    emit(StartPageComplexitySelected(pageState));
  }

  run(StartPageRunQuiz event, emit) async {
    await globalRep.init();
    globalRep.router.push(Routes.questionPage, args: {
      'topic': pageState.topic,
      'complexity': pageState.complexity,
    });
  }

  err(StartPageMsgErr event, emit) {
    pageState
      ..errMsg = event.msg
      ..onAwait = false;
    emit(StartPageError(pageState));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(StartPageMsgErr(error.toString()));
    super.onError(error, stackTrace);
  }
}
