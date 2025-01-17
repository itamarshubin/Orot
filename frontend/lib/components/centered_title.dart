import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CenteredTitle extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const CenteredTitle({
    super.key,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 40,
        ),
      ),
    );
  }
}
