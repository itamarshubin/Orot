import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orot/DatesWrapper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _Homepage();
}

class Profile {
  String fullname;
  String address;
  String phoneNumber;

  Profile.fromJson(Map<String, dynamic> json)
      : fullname = json['fullname'],
        address = json['address'],
        phoneNumber = json['phoneNumber'];

}

class FamilyProfile extends Profile {
  String contact;

  FamilyProfile.fromJson(Map<String, dynamic> json)
    : contact = json['contact'],
      super.fromJson(json);
}

class _Homepage extends State<Homepage> {
  Future<Profile> fetchProfile() async {
    final res = await http.get(Uri.parse("http://10.0.2.2:5000/"));
    print("aaa");
    if (res.statusCode == 200) {
      return Profile.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to fetch joke');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container (
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/punk.png'),
            scale: 0.87,
            fit: BoxFit.none,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Padding(padding: const EdgeInsets.only(top: 60), child: Image.asset('assets/img/blue.png',
            width: 200,
            height: 145,
          )),
          FutureBuilder<Profile>(future: fetchProfile(), builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ProfileData(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            else {
              return Placeholder();
            }
          }) ,//TODO: replace with getProfile
          const Padding(padding: EdgeInsets.only(top: 20), child: DatesWrapper()),
          const FamilyData('אנונימי', 'חנה רובינא 2, חיפה', 'דן עזר'),
        ],
      ), 
    ));
  }
}

class FamilyData extends StatelessWidget {
  const FamilyData(this.lastName, this.address, this.contactName, {super.key});
  final String lastName;
  final String address;
  final String contactName; //TODO: replace with getFamily

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 40, 20, 0),
            child: const Text('המשפחה השנייה שלי', style: TextStyle(
            color: Color.fromARGB(255, 4, 45, 107),
            fontSize: 22
          ))),
          FamilyDetails(lastName, address, contactName),
        ]  
      );
  }
}

class FamilyDetails extends StatelessWidget {
  const FamilyDetails(this.lastName, this.address, this.contactName, {super.key});
  final String lastName;
  final String address;
  final String contactName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      margin: const EdgeInsets.fromLTRB(20,12,20,20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromRGBO(212, 218, 222, 1)
      ),
      child: Padding(padding: const EdgeInsets.fromLTRB(0, 10, 20, 0), child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
            Text("משפחת $lastName", style: const TextStyle(
              fontSize: 23.5,
            )),
            Text(address, style: const TextStyle(
              fontSize: 23.5
            )),
            Text("$contactName (איש קשר)", style: const TextStyle(
              fontSize: 23.5
            )),
            Expanded( child: Container(padding: const EdgeInsets.only(left: 15), alignment: Alignment.bottomLeft, child: 
              Image.asset('assets/img/hand.png'
            )))
          ]),
    )); 
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData(this.profile, {super.key});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(profile.fullname, style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        )),
        Text(profile.address, style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16
        )),
        Text(profile.phoneNumber, style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16
        )),
      ],
    );
  }
}