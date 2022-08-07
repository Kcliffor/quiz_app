part of 'question_page_bloc.dart';

@immutable
abstract class QuestionPageBlocState {
  final QuestionPageState pageState;

  const QuestionPageBlocState(this.pageState);
}

class QuestionPageInitial extends QuestionPageBlocState {
  const QuestionPageInitial(QuestionPageState pageState) : super(pageState);
}

class QuestionPageNextQuestion extends QuestionPageBlocState {
  const QuestionPageNextQuestion(QuestionPageState pageState) : super(pageState);
}

class QuestionPageUp extends QuestionPageBlocState {
  const QuestionPageUp(QuestionPageState pageState) : super(pageState);
}

class QuestionPageError extends QuestionPageBlocState {
  const QuestionPageError(QuestionPageState pageState) : super(pageState);
}
