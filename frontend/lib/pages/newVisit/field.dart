import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Field extends StatefulWidget {
  const Field(this._fieldTitle, this._onTap, this.context, this._content,
      this._iconPath,
      {super.key});

  final String _fieldTitle;
  final Future<void> Function(BuildContext) _onTap;
  final BuildContext context;
  final String _content;
  final String _iconPath;

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
              widget._fieldTitle,
              style: GoogleFonts.varelaRound(
                color: Color(0xff205273),
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            )),
        SizedBox(
          height: 40,
          child: InkWell(
            onTap: () async {
              await widget._onTap(widget.context);
            },
            // borderRadius: BorderRadius.circular(18),
            child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(30)),
                  color: Color(0xFFFFFFFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 10,
                  children: [
                    // Add some spacing
                    Text(
                      widget._content,
                      style: GoogleFonts.varelaRound(
                        color: Color(0xff205273),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SvgPicture.asset(
                      widget._iconPath,
                      width: 25,
                      height: 25,
                    ) // Replace with your desired icon
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
