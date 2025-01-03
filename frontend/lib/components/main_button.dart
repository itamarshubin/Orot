import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum MainButtonSize { big, small }

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final MainButtonSize size;
  final bool disabled;

  const MainButton({
    super.key,
    required this.text,
    required this.onPress,
    this.size = MainButtonSize.big,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.sizeOf(context).width * 0.75,
      height: size == MainButtonSize.big
          ? screenHeight * 0.07
          : screenHeight * 0.06,
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
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: disabled ? null : onPress,
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
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
