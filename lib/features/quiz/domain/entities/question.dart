import 'boolean_question.dart';
import 'multiple_choice_question.dart';

abstract class Question {
  final String category;
  final String difficulty;
  final String question;

  Question({
    required this.category,
    required this.difficulty,
    required this.question,
  });

  static List<Question> fromJsonArray(List<dynamic> jsonArray) {
    List<Question> questions = [];

    for (var json in jsonArray) {
      if (json['type'] == 'multiple') {
        questions.add(MultipleChoiceQuestion.fromJson(json));
      } else if (json['type'] == 'boolean') {
        questions.add(BooleanQuestion.fromJson(json));
      }
    }

    return questions;
  }
}
