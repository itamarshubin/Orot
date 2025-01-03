import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum MainButtonSize { big, small }

class MainButton2 extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final MainButtonSize size;
  final bool disabled;

  const MainButton2({
    super.key,
    required this.text,
    required this.onPress,
    this.size = MainButtonSize.big,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    debugPrint('$disabled');
    return InkWell(
      onTap: disabled ? null : onPress,
      child: Container(
          alignment: Alignment.center,
          width: MediaQuery.sizeOf(context).width * 0.75,
          height: screenHeight * (size == MainButtonSize.big ? 0.07 : 0.06),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: disabled
                  ? [Color(0xFF44474C), Color(0xFF777B7C)]
                  : [Color(0xFF205273), Color(0xFF3C9BD9)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: disabled
                ? null
                : [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              text,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: disabled ? Colors.white70 : Colors.white,
              ),
            ),
          )),
    );
  }
}
