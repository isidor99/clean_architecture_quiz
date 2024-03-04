import 'question.dart';

class MultipleChoiceQuestion extends Question {
  final List<String> answers;

  MultipleChoiceQuestion({
    required this.answers,
    required super.category,
    required super.difficulty,
    required super.question,
  });

  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    final List<String> answers = [];

    answers.add(json['correct_answer']);
    for (int i = 0; i < 3; ++i) {
      answers.add(json['incorrect_answers'][i]);
    }

    return MultipleChoiceQuestion(
      answers: answers,
      category: json['category'],
      difficulty: json['difficulty'],
      question: json['question'],
    );
  }
}
