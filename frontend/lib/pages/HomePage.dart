import 'package:flutter/material.dart';
import 'package:orot/api/api.dart';
import 'package:orot/components/DatesWrapper.dart';
import 'package:orot/types/profiles.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/punk.png'),
              scale: 0.87,
              fit: BoxFit.none,
              alignment: Alignment.topCenter,
            ),
          ),
          child: FutureBuilder(
              future: Future.wait([
                fetchMeetingDates("aa"),
                fetchFamilyProfile("שובין"),
                fetchProfile("itamar")
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Image.asset(
                              'assets/img/blue.png',
                              width: 200,
                              height: 145,
                            )),
                        ProfileData(snapshot.data![2]),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Dateswrapper(snapshot.data![0][0])),
                        FamilyData(snapshot.data![1])
                      ]);
                }
              })),
    );
  }
}

class FamilyData extends StatelessWidget {
  const FamilyData(this.profile, {super.key});
  final FamilyProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
          padding: const EdgeInsets.fromLTRB(0, 40, 20, 0),
          child: const Text('המשפחה השנייה שלי',
              style: TextStyle(
                  color: Color.fromARGB(255, 4, 45, 107), fontSize: 22))),
      FamilyDetails(profile.fullname, profile.address, profile.contact),
    ]);
  }
}

class FamilyDetails extends StatelessWidget {
  const FamilyDetails(this.lastName, this.address, this.contactName,
      {super.key});
  final String lastName;
  final String address;
  final String contactName;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 200,
        margin: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromRGBO(212, 218, 222, 1)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text("משפחת $lastName",
                style: const TextStyle(
                  fontSize: 23.5,
                )),
            Text(address, style: const TextStyle(fontSize: 23.5)),
            Text("$contactName (איש קשר)",
                style: const TextStyle(fontSize: 23.5)),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    alignment: Alignment.bottomLeft,
                    child: Image.asset('assets/img/hand.png')))
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
        Text(profile.fullname,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            )),
        Text(profile.address,
            style: TextStyle(color: Colors.grey[600], fontSize: 16)),
        Text(profile.phoneNumber,
            style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      ],
    );
  }
}
