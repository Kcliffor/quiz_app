import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, this.args}) : super(key: key);

  final Object? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваш результат:'),
      ),
      body: Center(),
    );
  }
}
