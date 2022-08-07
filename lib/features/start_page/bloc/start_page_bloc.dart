import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/data/model/question_model.dart';
import 'package:quiz_app/data/model/questions_response.dart';
import 'package:quiz_app/data/model/server_response.dart';
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
    on<StartPageInit>(init);
    on<StartPageSelectTopic>(selectTopic);
    on<StartPageSelectComplexity>(selectComplexity);
    on<StartPageRunQuiz>(run);
    on<StartPageMsgErr>(err);

  }

  List<QuestionModel> questionList = [];

  init(StartPageInit event, emit) async {}

  selectTopic(StartPageSelectTopic event, emit) {
    pageState.topic = event.topic;
    emit(StartPageTopicSelected(pageState));
  }

  selectComplexity(StartPageSelectComplexity event, emit) {
    pageState.complexity = event.complexity;
    emit(StartPageComplexitySelected(pageState));
  }

  run(StartPageRunQuiz event, emit) async {
    pageState.onAwait = true;
    emit(StartPageUp(pageState));
    await globalRep.init();
    ServerResponse res = await globalRep.netExchange.netGet(
      command: 'api/v1/questions',
      args: {
        'apiKey': 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa',
        'difficulty': pageState.complexity ?? '',
        'category': pageState.topic ?? '',
        'limit': '10',
      },
    );
    if (res.body != null && res.code == '200') {
      QuestionsResponse response = QuestionsResponse.fromJson(res.body as List<dynamic>);
      questionList = response.list;
    } else if (res.code == '404' || res.code == '401' || res.code == '429') {
      add(StartPageMsgErr((res.body as Map<String, dynamic>)['error'].toString()));
    } else {
      add(StartPageMsgErr('Ошибка сервера'));
    }

    pageState.onAwait = false;
    emit(StartPageInitial(pageState));
    if (questionList.isNotEmpty) {
      globalRep.router.push(Routes.questionPage, args: {
        'topic': pageState.topic,
        'complexity': pageState.complexity,
        'questions': questionList,
      });
    }
  }

  err(StartPageMsgErr event, emit) {
    pageState
      ..errMsg = event.msg
      ..onAwait = false
      ..complexity = null
      ..topic = null;

    emit(StartPageError(pageState));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(StartPageMsgErr(error.toString()));
    super.onError(error, stackTrace);
  }
}
