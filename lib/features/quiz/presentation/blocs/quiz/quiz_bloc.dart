import 'package:bloc/bloc.dart';
import 'package:quiz_app/core/usecase/params.dart';

import '../../../domain/entities/boolean_question.dart';
import '../../../domain/entities/multiple_choice_question.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/usecases/get_questions.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuestions getQuestions;

  QuizBloc({
    required this.getQuestions,
  }) : super(QuizInitial()) {
    on<QuizStart>(_onQuizStart);
    on<QuestionAnswer>(_onQuestionAnswer);
  }

  //
  // on quiz start callback
  //
  void _onQuizStart(QuizStart event, Emitter<QuizState> emit) async {
    // get questions
    final questionsResponse = await getQuestions.call(
      Params({
        Params.keyToken: event.token,
        Params.keyAmount: 10,
      }),
    );

    // check if question fetching  was successful
    questionsResponse.fold(
      (error) {
        emit(QuizFailure());
      },
      (map) {
        // emit quiz success state
        emit(
          QuizSuccess(
            token: map['token'],
            questions: map['questions'],
            index: 0,
            answers: [],
          ),
        );
      },
    );
  }

  //
  // on question answer callback
  //
  void _onQuestionAnswer(QuestionAnswer event, Emitter<QuizState> emit) async {
    // initialize state
    // state is of type QuizSuccess for sure
    QuizSuccess quizState = state as QuizSuccess;

    // get existing answers
    List<String> answers = quizState.answers;

    // add new answer
    answers.add(event.answer);

    // if answers have same number of elements as questions
    // then quiz is over
    if (answers.length == quizState.questions.length) {
      // emit quiz end state
      int score = 0;

      for (int i = 0; i < quizState.questions.length; ++i) {
        // temporary variable to store correct answer
        late String correct;

        //
        if (quizState.questions[i] is MultipleChoiceQuestion) {
          // get correct answer
          correct =
              (quizState.questions[i] as MultipleChoiceQuestion).answers[0];
        } else {
          // get correct answer
          correct = (quizState.questions[i] as BooleanQuestion).answers[0];
        }

        // check if answer is correct
        score += answers[i] == correct ? 1 : 0;
      }

      // emit quiz end state
      emit(QuizEnd(token: quizState.token as String, score: score));
    } else {
      emit(
        QuizSuccess(
          token: quizState.token,
          questions: quizState.questions,
          index: quizState.index + 1,
          answers: answers,
        ),
      );
    }
  }
}
