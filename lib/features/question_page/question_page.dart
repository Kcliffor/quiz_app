import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/data/model/question_model.dart';
import 'package:quiz_app/domain/models/answers.dart';
import 'package:quiz_app/domain/repositories/global_rep.dart';

import 'bloc/question_page_bloc.dart';
import 'widgets/custom_checkbox.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key, this.args}) : super(key: key);

  final Object? args;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int? _selectedIndex;
  List<Answer> _selectedAnswers = [];
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> pageArgs = widget.args as Map<String, dynamic>? ?? {};
    return BlocProvider(
      create: (context) => QuestionPageBloc(
        globalRep: context.read<GlobalRep>(),
        pageState: QuestionPageState(
          selectedComplexity: pageArgs['complexity'] ?? '',
          selectedTopic: pageArgs['topic'] ?? '',
          questionList: pageArgs['questions'],
        ),
      ),
      child: BlocBuilder<QuestionPageBloc, QuestionPageBlocState>(
        builder: (context, state) {
          bool multiCorrectAnswers =
              state.pageState.currentQuestion?.multipleCorrectAnswers.boolValue ?? false;
          return Scaffold(
            backgroundColor: const Color(0xFFF2F7F6),
            appBar: AppBar(
              title: const Text('Выберите правильный ответ'),
            ),
            body: state.pageState.onAwait
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.pageState.selectedTopic,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              state.pageState.selectedComplexity,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Text(
                          '<${state.pageState.questionCounter}/${state.pageState.questionList.length}>',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          state.pageState.currentQuestion?.question ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTileCheckBox(
                                title: state.pageState.answers?[index].answer ?? '',
                                onPressed: () {
                                  setState(() {
                                    if (multiCorrectAnswers) {
                                      if (_selectedAnswers
                                          .contains(state.pageState.answers?[index])) {
                                        _selectedAnswers.remove(state.pageState.answers![index]);
                                      } else {
                                        _selectedAnswers.add(state.pageState.answers![index]);
                                      }
                                    } else {
                                      _selectedIndex = index;
                                    }
                                  });
                                },
                                selected: multiCorrectAnswers
                                    ? _selectedAnswers.contains(state.pageState.answers?[index])
                                    : _selectedIndex == index,
                                isMultipleChoice: multiCorrectAnswers,
                                margin: const EdgeInsets.only(bottom: 5),
                              );
                            },
                            itemCount: state.pageState.answers?.length ?? 0,
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _selectedIndex != null || _selectedAnswers.isNotEmpty
                              ? () {
                                  context.read<QuestionPageBloc>().add(QuestionPageAnswer(
                                        selectedAnswer: _selectedIndex != null
                                            ? state.pageState.answers?.elementAt(_selectedIndex!)
                                            : null,
                                        selectedAnswers:
                                            _selectedAnswers.isNotEmpty ? _selectedAnswers : null,
                                      ));
                                  _selectedAnswers = [];
                                  _selectedIndex = null;
                                }
                              : null,
                          child: const Text('Ответить'),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
