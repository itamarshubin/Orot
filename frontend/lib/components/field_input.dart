import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final String inputTitle;
  final String? hintText;
  final VoidCallback? onEditingCompleteFunction;
  final bool obscureText;

  const FieldInput({
    required this.textEditingController,
    required this.inputTitle,
    this.hintText,
    this.onEditingCompleteFunction,
    this.obscureText = false,
    super.key,
  });

  @override
  State<FieldInput> createState() => _FieldInputState();
}

class _FieldInputState extends State<FieldInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 3,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.centerRight,
            child: Text(
              widget.inputTitle,
              style: GoogleFonts.varelaRound(
                  textStyle: const TextStyle(
                color: Color(0xff2B2B2B),
                fontWeight: FontWeight.w400,
                fontSize: 17,
              )),
            )),
        TextField(
          maxLines: 1,
          controller: widget.textEditingController,
          onEditingComplete: widget.onEditingCompleteFunction,
          textAlignVertical: TextAlignVertical.bottom,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            constraints: BoxConstraints(maxHeight: 36),
            filled: true,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.varelaRound(
                textStyle: const TextStyle(
              color: Color(0xffB7B4B4),
              fontSize: 20,
            )),
            fillColor: const Color(0xffF5F5F5),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        )
      ],
    );
  }
}
