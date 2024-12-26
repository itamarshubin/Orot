import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum MainButtonSize { big, small }

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final MainButtonSize size;

  const MainButton({
    super.key,
    required this.text,
    required this.onPress,
    this.size = MainButtonSize.big,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: size == MainButtonSize.big ? 53 : 43,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF205273),
            Color(0xFF3C9BD9),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1, 6),
            blurRadius: 14,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
