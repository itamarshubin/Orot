import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//ignore: must_be_immutable
class SwitchButtons extends StatefulWidget {
  bool activated;
  final String activateTextButton;
  final String deactivateTextButton;

  SwitchButtons({
    super.key,
    this.activated = false,
    this.activateTextButton = "כן",
    this.deactivateTextButton = "לא",
  });

  @override
  State<SwitchButtons> createState() => _SwitchButtonsState();
}

class _SwitchButtonsState extends State<SwitchButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        _button(widget.activateTextButton),
        _button(widget.deactivateTextButton),
      ],
    );
  }

  Widget _button(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: getCurrentBackgroundColor(text),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => setActivationOnPressed(text),
        child: Text(
          text,
          style: GoogleFonts.assistant(
            color: getCurrentColor(text),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void setActivationOnPressed(String textButton) {
    setState(() {
      widget.activated = textButton == widget.activateTextButton;
    });
  }

  Color? getCurrentColor(String textButton) {
    Color activatedColor = Color(0xffB22759);
    Color deactivatedColor = Color(0xff525050);
    if (textButton == widget.activateTextButton) {
      return widget.activated ? activatedColor : deactivatedColor;
    } else if (textButton == widget.deactivateTextButton) {
      return !widget.activated ? activatedColor : deactivatedColor;
    }
    return null;
  }

  Color? getCurrentBackgroundColor(String textButton) {
    Color activatedColor = Color(0xffFFC3C3);
    Color deactivatedColor = Color(0xffE8E4E4);
    if (textButton == widget.activateTextButton) {
      return widget.activated ? activatedColor : deactivatedColor;
    } else if (textButton == widget.deactivateTextButton) {
      return !widget.activated ? activatedColor : deactivatedColor;
    }
    return null;
  }
}
