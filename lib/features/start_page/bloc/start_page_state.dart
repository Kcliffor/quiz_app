part of 'start_page_bloc.dart';

class StartPageState {
  bool onAwait;
  String? topic;
  String? complexity;
  String errMsg;

  StartPageState({
    this.onAwait = false,
    this.topic,
    this.complexity,
    this.errMsg = '',
  });

  StartPageState copyWith({
    bool? onAwait,
    String? topic,
    String? complexity,
    String? errMsg,
  }) {
    return StartPageState(
      onAwait: onAwait ?? this.onAwait,
      topic: topic ?? this.topic,
      complexity: complexity ?? this.complexity,
      errMsg: errMsg ?? this.errMsg,
    );
  }
}
