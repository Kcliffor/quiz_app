import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/domain/repositories/global_rep.dart';
import 'package:quiz_app/features/result_page/bloc/result_page_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, this.args}) : super(key: key);

  final Object? args;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> pageArgs = args as Map<String, dynamic>? ?? {};

    return BlocProvider<ResultPageBloc>(
      create: (context) => ResultPageBloc(
        globalRep: context.read<GlobalRep>(),
        pageState: ResultPageState(
          complexity: pageArgs['complexity'] ?? '',
          topic: pageArgs['topic'] ?? '',
          correctQuestions: pageArgs['correctQuestions'] ?? 0,
          totalQuestions: pageArgs['totalQuestions'] ?? 0,
        ),
      ),
      child: BlocConsumer<ResultPageBloc, ResultPageBlocState>(
        listener: (context, state) {
          if (state is ResultPageError) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.pageState.errMsg),
                ),
              );
          } else if (state is ResultPageDone) {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('Успешно сохранено'),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Ваш результат:'),
            ),
            body: state.pageState.onAwait
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Вы ответили правильно на',
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 12),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: state.pageState.correctQuestions.toString(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' из ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                      ),
                                    ),
                                    TextSpan(
                                      text: state.pageState.totalQuestions.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'вопросов',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Сохранить результат в Firebase Firestore?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () =>
                                      context.read<ResultPageBloc>().add(ResultPageSaveResult()),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Сохранить',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.save_alt),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
