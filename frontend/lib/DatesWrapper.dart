import 'package:flutter/material.dart';

class DatesWrapper extends StatelessWidget {
  const DatesWrapper({super.key});

  @override
  Widget build(BuildContext context) {

    return const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Blob('ביקור עתידי', '25.2'),
          Blob('ביקור עתידי', '19.1'),
          Blob('ביקורים', '14'),
        ]
      );
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
            child: Test(lowerText, upperText),
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


