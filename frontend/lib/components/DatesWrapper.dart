import 'package:flutter/material.dart';
import 'package:orot/api/api.dart';

class Dateswrapper extends StatefulWidget {
  const Dateswrapper(this.data, {super.key});
  final List<dynamic> data;

  @override
  State<Dateswrapper> createState() => _DateswrapperState();
}

class _DateswrapperState extends State<Dateswrapper> {
  @override
  Widget build(BuildContext context) {
          return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.data.map((arr) {
                return Blob(arr[0].toString(), arr[1].toString());
          }).toList());
      }
}

class Blob extends StatelessWidget {
  const Blob(this.lowerText, this.upperText, {super.key});
  final String lowerText;
  final String upperText;

  @override
  Widget build(BuildContext context) {
    return Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.grey,
                  offset: Offset(0, 10)
                )
              ]
            ),
            child: Test(lowerText, upperText),
        );
  }
}

class Test extends StatelessWidget {
  const Test(this.lowerText, this.upperText, {super.key});
  final String lowerText;
  final String upperText;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
          padding: const EdgeInsets.only(top: 10),
          child: Text(upperText, style: TextStyle(
            fontSize: 35,
            color: Colors.grey[700],
          ))),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(lowerText, style: TextStyle(
              color: Colors.grey[650],
            )),
          ) 
        ],
    );
  }
}


