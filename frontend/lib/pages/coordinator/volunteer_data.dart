import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/services/coordinator_service.dart';

class VolunteerData extends StatefulWidget {
  User volunteer;
  VolunteerData(this.volunteer, {super.key});

  @override
  State<VolunteerData> createState() => _VolunteerDataState();
}

class _VolunteerDataState extends State<VolunteerData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CoordinatorService().getVisitData(widget.volunteer.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return Center(
            child: Text('Error: ${snapshot.error}\n${snapshot.stackTrace}'),
          );
        } else {
          return Scaffold(
            body: Column(
              children: [_topIcon(), _volunteerName()],
            ),
          );
          ;
        }
      },
    );
  }

  Widget _volunteerName() {
    return Text(
      widget.volunteer.name,
      style: GoogleFonts.openSans(
          fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xff205273)),
    );
  }

  Widget _topIcon() {
    final double pageHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.13,
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
          height: pageHeight * 0.2,
          // color: Colors.yellow,
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(0, pageHeight * 0.05, 0, 0),
          child: Image.asset('assets/img/blue_hug.png',
              width: MediaQuery.of(context).size.width * 0.3,
              height: pageHeight * 0.3),
        ),
        BackToAdminPage(),
      ],
    );
  }
}
