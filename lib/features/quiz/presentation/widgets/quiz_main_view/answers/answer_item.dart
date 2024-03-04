import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/core/utils/html_encode.dart';

// TODO: style this widget
class AnswerItem extends StatelessWidget {
  final String answer;
  final bool selected;
  final void Function() onItemSelected;

  const AnswerItem({
    Key? key,
    required this.answer,
    required this.selected,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get theme data
    ThemeData theme = Theme.of(context);

    //
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextButton(
        onPressed: onItemSelected,
        style: TextButton.styleFrom(
          backgroundColor:
              selected ? theme.highlightColor : theme.primaryColorDark,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            HtmlEncode.encode(answer),
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontSize: 20,
              color: theme.hintColor,
            ),
          ),
        ),
      ),
    );
  }
}
