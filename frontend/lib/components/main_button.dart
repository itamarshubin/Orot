import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  const MainButton({super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 500,
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          '$text',
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
