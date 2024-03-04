import 'package:flutter/material.dart';

import 'answers/answer_item.dart';

class Answers extends StatelessWidget {
  final List<String> answers;
  final int selected;
  final void Function(int index) onItemSelected;

  const Answers({
    Key? key,
    required this.answers,
    required this.selected,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return list
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: answers.length,
      itemBuilder: (_, i) => AnswerItem(
        answer: answers[i],
        selected: selected == i,
        onItemSelected: () => onItemSelected(i),
      ),
    );
  }
}
