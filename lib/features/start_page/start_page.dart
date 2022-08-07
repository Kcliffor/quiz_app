import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/domain/repositories/global_rep.dart';
import 'package:quiz_app/features/start_page/widgets/select_item_widget.dart';

import 'bloc/start_page_bloc.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StartPageBloc>(
      create: (context) => StartPageBloc(
        globalRep: context.read<GlobalRep>(),
        pageState: StartPageState(),
      ),
      child: BlocConsumer<StartPageBloc, StartPageBlocState>(
        listener: (context, state) {
          if (state is StartPageError) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.pageState.errMsg),
                ),
              );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Выберите тему и сложность квиза:'),
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
                        const SizedBox(height: 100),
                        SelectItemWidget(
                          title: 'Тема:',
                          hintTitle: 'Выберите тему :',
                          items: const [
                            'Linux',
                            'DevOps',
                            'Networking',
                            'Programming',
                            'Cloud',
                            'Docker',
                            'Kubernetes',
                          ],
                          selected: (String value) {
                            context
                                .read<StartPageBloc>()
                                .add(StartPageSelectTopic(value));
                          },
                        ),
                        const SizedBox(height: 50),
                        SelectItemWidget(
                          title: 'Сложность:',
                          hintTitle: 'Выберите сложность:',
                          items: const [
                            'Easy',
                            'Medium',
                            'Hard',
                          ],
                          selected: (String value) {
                            context
                                .read<StartPageBloc>()
                                .add(StartPageSelectComplexity(value));
                          },
                        ),
                        const SizedBox(height: 100),
                        ElevatedButton(
                          onPressed: state.pageState.topic != null &&
                                  state.pageState.complexity != null
                              ? () => context
                                  .read<StartPageBloc>()
                                  .add(StartPageRunQuiz())
                              : null,
                          child: const Text('Начать!'),
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
