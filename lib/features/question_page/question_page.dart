import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/domain/repositories/global_rep.dart';

import 'bloc/question_page_bloc.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key, this.args}) : super(key: key);

  final Object? args;

  @override
  Widget build(BuildContext context) {
    final Map<String, String?> pageArgs = args as Map<String, String?>? ?? {};
    return BlocProvider(
      create: (context) => QuestionPageBloc(
        globalRep: context.read<GlobalRep>(),
        pageState: QuestionPageState(
          selectedComplexity: pageArgs['complexity'] ?? '',
          selectedTopic: pageArgs['topic'] ?? '',
        ),
      ),
      child: BlocBuilder<QuestionPageBloc, QuestionPageBlocState>(
        builder: (context, state) {
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
                            Text(state.pageState.selectedTopic),
                            Text(state.pageState.selectedComplexity),
                          ],
                        ),
                        const SizedBox(height: 100),
                        // const SelectItemWidget(
                        //   title: 'Тема:',
                        //   hintTitle: 'Выберите тему:',
                        //   items: [
                        //     'Linux',
                        //     'DevOps',
                        //     'Networking',
                        //     'Programming',
                        //     'Cloud',
                        //     'Docker',
                        //     'Kubernetes',
                        //   ],
                        // ),
                        const SizedBox(height: 50),
                        // const SelectItemWidget(
                        //   title: 'Сложность:',
                        //   hintTitle: 'Выберите сложность:',
                        //   items: [
                        //     'Easy',
                        //     'Medium',
                        //     'Hard',
                        //   ],
                        // ),
                        const SizedBox(height: 100),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Ответить'),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
