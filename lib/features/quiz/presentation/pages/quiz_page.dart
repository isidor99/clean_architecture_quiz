import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/injection_container.dart';

import '../blocs/quiz/quiz_bloc.dart';
import '../widgets/quiz_end_view.dart';
import '../widgets/quiz_loading.dart';
import '../widgets/quiz_main_view.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  //
  // bloc listener
  void _blocListener(_, __) {}

  //
  // bloc builder
  Widget _blocBuilder(_, QuizState state) {
    if (state is QuizSuccess) {
      // quiz was successfully started
      return QuizMainView(
        index: state.index,
        question: state.questions[state.index],
      );
    } else if (state is QuizEnd) {
      // user answered all question, quiz has ended
      return QuizEndView(score: state.score);
    } else if (state is QuizFailure) {
      // error happened while tying to load token/questions
      // TODO: create error widget
      return const Text('Failure');
    }

    // in default case return loading widget
    return const QuizLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocProvider<QuizBloc>(
        create: (_) => sl()..add(QuizStart()),
        child: BlocConsumer<QuizBloc, QuizState>(
          listener: _blocListener,
          builder: _blocBuilder,
        ),
      ),
    );
  }
}
