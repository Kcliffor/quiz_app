import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/data/model/question_model.dart';
import 'package:quiz_app/domain/models/answers.dart';
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

  init(QuestionPageInit event, emit) {
    pageState.currentQuestion = pageState.questionList.first;
    pageState.answers = List.generate(
      pageState.currentQuestion?.answers.length ?? 0,
      (index) => Answer(
        id: pageState.currentQuestion?.answers.keys.elementAt(index) ?? '',
        answer: pageState.currentQuestion?.answers.values.elementAt(index),
        isCorrect: pageState
                .currentQuestion
                ?.correctAnswers[
                    '${pageState.currentQuestion?.answers.keys.elementAt(index)}_correct']
                ?.boolValue ??
            false,
      ),
    );
    pageState.answers?.removeWhere((element) => element.answer == null);
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
