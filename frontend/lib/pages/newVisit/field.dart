import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  const Field(this._fieldTitle, this._onTap, this.context, this._content,
      {super.key});
  final String _fieldTitle;
  final Future<void> Function(BuildContext) _onTap;
  final BuildContext context;
  final String _content;

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
            alignment: Alignment.centerRight,
            child: Text(
              widget._fieldTitle,
              style: const TextStyle(
                  fontFamily: 'VarelaRound',
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            )),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: InkWell(
            onTap: () async {
              await widget._onTap(widget.context);
            },
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(30)),
                  color: Color(0xFFFFFFFF)),
              child: Text(
                widget._content,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}
