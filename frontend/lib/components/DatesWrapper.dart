import 'package:flutter/material.dart';
import 'package:orot/api/api.dart';

class Dateswrapper extends StatefulWidget {
  const Dateswrapper({super.key});

  @override
  State<Dateswrapper> createState() => _DateswrapperState();
}

class _DateswrapperState extends State<Dateswrapper> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(future: fetchMeetingDates("aaa"), builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> data = snapshot.data![0];
          return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: data.map((arr) {
                return Blob(arr[0].toString(), arr[1].toString());
          }).toList());
            } else {
              return Text("AAA");
            }
        });
      }
}

// class _DateswrapperState extends State<Dateswrapper> {
//   @override
//   Widget build(BuildContext context) {

//     return Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           FutureBuilder(future: fetchMeetingDates("aaa"), builder: (context, snapshot) {
//             if (snapshot.hasData) {
//                 return ListView.builder(
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (context, i) {
//                     return Blob(snapshot.data[0], snapshot.data[1]);
//                   },
//                 );
//             } else {
//               return const Text("bbb");
//             }
//           })
//         ]
//       );
//   }
// }

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


