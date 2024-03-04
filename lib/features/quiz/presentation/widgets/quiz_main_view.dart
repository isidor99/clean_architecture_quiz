import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/boolean_question.dart';
import '../../domain/entities/multiple_choice_question.dart';
import '../../domain/entities/question.dart';
import '../blocs/quiz/quiz_bloc.dart';
import 'quiz_main_view/answers.dart';
import 'quiz_main_view/bottom_buttons.dart';
import 'quiz_main_view/page_title.dart';
import 'quiz_main_view/question_text.dart';

// TODO: implement this widget
class QuizMainView extends StatelessWidget {
  final int index;
  final Question question;

  final ValueNotifier<int> _selectedIndex = ValueNotifier(-1);

  late final List<String> answers;

  QuizMainView({
    Key? key,
    required this.index,
    required this.question,
  }) : super(key: key);

  // on item selected callback
  void _onItemSelected(int index) {
    // update selected index
    _selectedIndex.value = index;
  }

  // on next button pressed callback
  void _onNextButtonPressedCallback(BuildContext context) {
    if (_selectedIndex.value == -1) {
      // nothing is selected, can't go to next question
      return;
    }

    // get reference to quiz bloc
    QuizBloc bloc = BlocProvider.of<QuizBloc>(context);

    // add new event
    bloc.add(QuestionAnswer(answer: answers[_selectedIndex.value]));
  }

  @override
  Widget build(BuildContext context) {
    // get answers
    answers = (question is MultipleChoiceQuestion)
        ? (question as MultipleChoiceQuestion).answers
        : (question as BooleanQuestion).answers;

    // shuffle list
    answers.shuffle();

    return SingleChildScrollView(
      child: Column(
        children: [
          // whitespace
          const SizedBox(height: 8),

          // question label
          PageTitle(index: index),

          // whitespace
          SizedBox(height: MediaQuery.of(context).size.height / 6),

          // question
          QuestionText(question: question.question),

          // whitespace
          const SizedBox(height: 16),

          // answers
          ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (_, value, __) => Answers(
              answers: answers,
              selected: value,
              onItemSelected: _onItemSelected,
            ),
          ),

          // whitespace
          const SizedBox(height: 8),

          // buttons
          BottomButtons(
            onNextButtonPressed: () => _onNextButtonPressedCallback(context),
          ),
        ],
      ),
    );
  }
}
