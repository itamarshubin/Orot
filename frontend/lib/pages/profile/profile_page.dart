import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/pages/volunteer/new_visit/field.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:provider/provider.dart';

//TODO: this page is waiting for ui-ux decision.
/*
* This file can be used for both coordinator and volunteer.
* We need to pass the volunteer's details via route to page.
* */

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              _topIcon(),
              Text(
                userProvider.userName ?? '',
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xFFB22759)),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  spacing: 30,
                  children: [
                    _name(name: userProvider.userName ?? ''),
                    _district(),
                    _familyName(),
                    _familyContact()
                  ],
                ),
              )
            ],
          ));
    });
  }

  Widget _name({required String name}) {
    return Field(fieldTitle: "שם", content: name, context: context);
  }

  Widget _district() {
    return Field(
        fieldTitle: 'מחוז', content: 'fucking district', context: context);
  }

  Widget _familyName() {
    return Field(
        fieldTitle: 'שם משפחה שכולה', content: 'bluh bluh', context: context);
  }

  Widget _familyContact() {
    return Field(
        fieldTitle: 'איש קשר', content: 'bluh ljhdflkjdw', context: context);
  }

  Widget _topIcon() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 130,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFC3C3), // Corrected first color
                Color(0xFFFECED6), // Corrected second color
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(300, 40),
              bottomRight: Radius.elliptical(300, 40),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child:
              Image.asset('assets/img/blue_hug.png', width: 150, height: 150),
        )
      ],
    );
  }

  Widget _username() {
    return Container(
      alignment: Alignment.center,
      child: Text('שלום, יוסי',
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color(0xFFB22759))),
    );
  }
}
