import 'package:flutter/material.dart';
import 'package:quiz_app/features/quiz/presentation/pages/quiz_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: QuizPage()),
    );
  }
}
