import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionTitle extends StatelessWidget {
  final String text;

  const QuestionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: GoogleFonts.assistant(
        color: Color(0xff205273),
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    );
  }
}
