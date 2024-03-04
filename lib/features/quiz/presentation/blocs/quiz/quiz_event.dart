part of 'quiz_bloc.dart';

abstract class QuizEvent {}

// this event triggers the fetching of a session token
// and the fetching of questions based on the session token
// if quiz is played again, existing session token is used
class QuizStart extends QuizEvent {
  // TODO: this class should accept quiz type in order to know
  //  how many questions has to be fetched
  final String? token;

  QuizStart({this.token});
}

// this event is added when user answers question
class QuestionAnswer extends QuizEvent {
  final String answer;

  QuestionAnswer({required this.answer});
}
