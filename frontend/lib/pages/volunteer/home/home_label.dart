import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeLabelText extends StatelessWidget {
  final String text;

  const HomeLabelText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      textDirection: TextDirection.rtl,
      style: GoogleFonts.assistant(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(32, 82, 115, 1),
      ),
    );
  }
}
