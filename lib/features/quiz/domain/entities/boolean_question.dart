import 'question.dart';

class BooleanQuestion extends Question {
  final List<String> answers;

  BooleanQuestion({
    required this.answers,
    required super.category,
    required super.difficulty,
    required super.question,
  });

  factory BooleanQuestion.fromJson(Map<String, dynamic> json) {
    List<String> answers = [];

    answers.add(json['correct_answer']);
    answers.add(json['incorrect_answers'][0]);

    return BooleanQuestion(
      answers: answers,
      category: json['category'],
      difficulty: json['difficulty'],
      question: json['question'],
    );
  }
}
