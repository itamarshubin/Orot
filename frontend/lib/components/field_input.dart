import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final String inputTitle;
  final TextStyle? inputTitleStyle;
  final String? hintText;
  final VoidCallback? onEditingCompleteFunction;
  final bool obscureText;
  final FormFieldValidator<String>? inputValidation;
  final bool autofocus;
  final TextDirection textDirection;

  const FieldInput({
    required this.textEditingController,
    required this.inputTitle,
    this.hintText,
    this.onEditingCompleteFunction,
    this.inputValidation,
    this.obscureText = false,
    this.inputTitleStyle,
    this.autofocus = false,
    this.textDirection = TextDirection.ltr,
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
            style: widget.inputTitleStyle,
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            autofocus: widget.autofocus,
            maxLines: 1,
            textDirection: widget.textDirection,
            controller: widget.textEditingController,
            onEditingComplete: widget.onEditingCompleteFunction,
            textAlignVertical: TextAlignVertical.center,
            obscureText: widget.obscureText,
            validator: widget.inputValidation,
            autovalidateMode: AutovalidateMode.onUnfocus,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              filled: true,
              hintText: widget.hintText,
              hintTextDirection: TextDirection.ltr,
              hintStyle: GoogleFonts.varelaRound(
                color: Color(0xffB7B4B4),
                fontSize: 20,
              ),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        )
      ],
    );
  }
}
