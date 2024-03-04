import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTitle extends StatelessWidget {
  final int index;

  const PageTitle({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Question ${index + 1}/10',
      style: GoogleFonts.merriweather(fontSize: 16),
    );
  }
}
