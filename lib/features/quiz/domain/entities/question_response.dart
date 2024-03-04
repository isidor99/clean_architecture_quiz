import 'question.dart';

abstract class QuestionResponse {
  final int responseCode;
  final List<Question> questions;

  QuestionResponse({required this.responseCode, required this.questions});
}
