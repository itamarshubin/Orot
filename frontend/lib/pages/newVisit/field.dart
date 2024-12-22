import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      children: [
        Container(
            alignment: Alignment.bottomRight,
            child: Text(
              widget._fieldTitle,
              style: const TextStyle(
                fontFamily: 'VarelaRound',
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            )),
        const SizedBox(height: 10),
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
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Align to the end for RTL layout
                  children: [
                    // Add some spacing
                    Text(
                      widget._content,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
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
