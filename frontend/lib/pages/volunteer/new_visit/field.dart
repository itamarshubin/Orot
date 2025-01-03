import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Field extends StatefulWidget {
  const Field({
    super.key,
    this.onTap,
    this.iconPath,
    required this.fieldTitle,
    required this.content,
    required this.context,
  });

  final String fieldTitle;
  final VoidCallback? onTap;
  final BuildContext context;
  final String content;
  final String? iconPath;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Container(
            alignment: Alignment.bottomRight,
            child: Text(
              widget.fieldTitle,
              style: GoogleFonts.varelaRound(
                color: Color(0xff205273),
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            )),
        SizedBox(
          height: 40,
          child: InkWell(
            onTap: widget.onTap,
            child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3, color: Colors.grey, offset: Offset(0, 1))
                  ],
                  color: Color(0xFFFFFFFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 10,
                  children: [
                    Text(
                      widget.content,
                      style: GoogleFonts.varelaRound(
                        color: Color(0xff205273),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    if (widget.iconPath != null)
                      SvgPicture.asset(
                        widget.iconPath!,
                        width: 25,
                        height: 25,
                      )
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
