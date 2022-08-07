import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/data/model/question_model.dart';
import 'package:quiz_app/domain/models/answers.dart';
import 'package:quiz_app/domain/repositories/global_rep.dart';
import 'package:quiz_app/domain/services/router/delegate.dart';

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
    on<QuestionPageAnswer>(answer);
    on<QuestionPageMsgErr>(err);

    add(QuestionPageInit());
  }

  int counterCorrectAnswers = 0;

  getAnswers() {
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
  }

  init(QuestionPageInit event, emit) {
    pageState.onAwait = true;
    emit(QuestionPageUp(pageState));
    pageState.currentQuestion = pageState.questionList.first;
    getAnswers();
    pageState.onAwait = false;

    emit(QuestionPageInitial(pageState));
  }

  answer(QuestionPageAnswer event, emit) {
    if (event.selectedAnswer != null) {
      if (event.selectedAnswer?.isCorrect ?? false) counterCorrectAnswers++;
    } else if (event.selectedAnswers != null) {
      bool flag = true;
      for (Answer elem in event.selectedAnswers!) {
        if (!elem.isCorrect) {
          flag = false;
          break;
        }
      }
      if (flag) counterCorrectAnswers++;
    }
    if (pageState.currentQuestion != pageState.questionList.last) {
      pageState.questionCounter++;
      pageState.currentQuestion = pageState.questionList[pageState.questionCounter - 1];
      getAnswers();
      emit(QuestionPageNextQuestion(pageState));
    } else {
      globalRep.router.push(Routes.resultPage);
    }
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
