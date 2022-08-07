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
  List<Answer>? selectedAnswers;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> pageArgs = widget.args as Map<String, dynamic>? ?? {};
    return BlocProvider(
      create: (context) => QuestionPageBloc(
        globalRep: context.read<GlobalRep>(),
        pageState: QuestionPageState(
          selectedComplexity: pageArgs['complexity'] ?? '',
          selectedTopic: pageArgs['topic'] ?? '',
          questionList: pageArgs['questions'] ?? '',
        ),
      ),
      child: BlocBuilder<QuestionPageBloc, QuestionPageBlocState>(
        builder: (context, state) {
          bool multiCorrectAnswers =
              state.pageState.currentQuestion?.multipleCorrectAnswers.boolValue ?? false;
          return Scaffold(
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
                        const SizedBox(height: 100),
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
                                      if (selectedAnswers!
                                          .contains(state.pageState.answers?[index])) {
                                        selectedAnswers!.remove(state.pageState.answers![index]);
                                      } else {
                                        selectedAnswers!.add(state.pageState.answers![index]);
                                      }
                                    } else {
                                      _selectedIndex = index;
                                    }
                                  });
                                },
                                selected: multiCorrectAnswers
                                    ? selectedAnswers!.contains(state.pageState.answers?[index])
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
                          onPressed:
                              _selectedIndex != null || selectedAnswers != null ? () {} : null,
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
