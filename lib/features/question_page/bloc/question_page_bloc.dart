import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/data/model/question_model.dart';
import 'package:quiz_app/data/model/questions_response.dart';
import 'package:quiz_app/data/model/server_response.dart';
import 'package:quiz_app/domain/repositories/global_rep.dart';

part 'question_page_bloc_state.dart';
part 'question_page_event.dart';
part 'question_page_state.dart';

class QuestionPageBloc extends Bloc<QuestionPageEvent, QuestionPageBlocState> {
  final QuestionPageState pageState;
  final GlobalRep globalRep;

  QuestionPageBloc({
    required this.globalRep,
    required this.pageState,
  }) : super(QuestionPageInitial(pageState)) {
    on<QuestionPageInit>(init);
    on<QuestionPageMsgErr>(err);

    add(QuestionPageInit());
  }

  List<QuestionModel> questionList = [];

  init(QuestionPageInit event, emit) async {
    pageState.onAwait = true;
    emit(QuestionPageUp(pageState));
    ServerResponse res = await globalRep.netExchange.netGet(
      command: 'api/v1/questions',
      args: {
        'apiKey': 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa',
        'difficulty': pageState.selectedComplexity,
        'category': pageState.selectedTopic,
        'limit': '10',
      },
    );
    if (res.body != null && res.code == '200') {
      QuestionsResponse response = QuestionsResponse.fromJson(res.body as List<dynamic>);
      questionList = response.list;
    }

    pageState.onAwait = false;
    emit(QuestionPageInitial(pageState));
  }

  err(QuestionPageMsgErr event, emit) {
    pageState
      ..errMsg = event.msg
      ..onAwait = false;
    emit(QuestionPageError(pageState));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(QuestionPageMsgErr(error.toString()));
    super.onError(error, stackTrace);
  }
}
