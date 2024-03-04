import 'package:flutter/material.dart';

class QuizEndView extends StatelessWidget {
  final int score;

  const QuizEndView({Key? key, required this.score}) : super(key: key);

  // TODO: style further this widget
  // TODO: implement question review
  @override
  Widget build(BuildContext context) {
    return Text('$score');
  }
}
