part of 'start_page_bloc.dart';

@immutable
abstract class StartPageBlocState {
  final StartPageState pageState;

  const StartPageBlocState(this.pageState);
}

class StartPageInitial extends StartPageBlocState {
  const StartPageInitial(StartPageState pageState) : super(pageState);
}

class StartPageTopicSelected extends StartPageBlocState {
  const StartPageTopicSelected(StartPageState pageState) : super(pageState);
}

class StartPageComplexitySelected extends StartPageBlocState {
  const StartPageComplexitySelected(StartPageState pageState) : super(pageState);
}

class StartPageUp extends StartPageBlocState {
  const StartPageUp(StartPageState pageState) : super(pageState);
}

class StartPageError extends StartPageBlocState {
  const StartPageError(StartPageState pageState) : super(pageState);
}
