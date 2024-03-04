import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/core/utils/html_encode.dart';

class QuestionText extends StatelessWidget {
  final String question;

  const QuestionText({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        HtmlEncode.encode(question),
        textAlign: TextAlign.center,
        style: GoogleFonts.merriweather(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
