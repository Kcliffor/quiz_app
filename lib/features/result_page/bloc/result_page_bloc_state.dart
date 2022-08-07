part of 'result_page_bloc.dart';

@immutable
abstract class ResultPageBlocState {
  final ResultPageState pageState;

  const ResultPageBlocState(this.pageState);
}

class ResultPageDone extends ResultPageBlocState {
  const ResultPageDone(ResultPageState pageState) : super(pageState);
}

class ResultPageSavedResult extends ResultPageBlocState {
  const ResultPageSavedResult(ResultPageState pageState) : super(pageState);
}

class ResultPageUp extends ResultPageBlocState {
  const ResultPageUp(ResultPageState pageState) : super(pageState);
}

class ResultPageError extends ResultPageBlocState {
  const ResultPageError(ResultPageState pageState) : super(pageState);
}
