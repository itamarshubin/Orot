import 'package:flutter/material.dart';

class VolenteersPage extends StatefulWidget {
  const VolenteersPage({super.key});

  @override
  State<VolenteersPage> createState() => _VolenteersPageState();
}

class _VolenteersPageState extends State<VolenteersPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      width: 1000,

      decoration: const BoxDecoration(
        color:Color.fromARGB(100, 243, 217, 217),
        image: DecorationImage(
          image: AssetImage('assets/img/punk2.png'),
          scale: 0.87,
          fit: BoxFit.none,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
                height: 60,
                margin: const EdgeInsets.only(bottom: 50),
                child: const Text("title", style: TextStyle(fontSize: 40)))),
        Container(
            margin: const EdgeInsets.only(left: 100),
            width: 250,
            child: TextField(
                controller: controller,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  hintText: "חיפוש שם",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),),
                  )
              )
          ),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const VolenteerCube();
                }))
      ]),
    ));
  }
}

class VolenteerCube extends StatelessWidget {
  const VolenteerCube({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      color: Colors.white,
      height: 50,
      child: const Row(mainAxisAlignment: MainAxisAlignment.spaceAround
      , children: [
        Text("מחוז"),
        Text("name"),
        Row(children: [
          Text("the third"),
          Text("icon")
          ]),
      ],),
    );
  }
}
