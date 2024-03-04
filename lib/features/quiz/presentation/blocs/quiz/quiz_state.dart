part of 'quiz_bloc.dart';

abstract class QuizState {}

class QuizInitial extends QuizState {}

// quiz state
class QuizSuccess extends QuizState {
  final String? token;
  final List<Question> questions;
  final int index;
  final List<String> answers;

  QuizSuccess({
    this.token,
    required this.questions,
    required this.index,
    required this.answers,
  });
}

// quiz end state
class QuizEnd extends QuizState {
  final String token;
  final int score;

  QuizEnd({required this.token, required this.score});
}

// error state
class QuizFailure extends QuizState {}
