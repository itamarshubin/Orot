import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/coordinator/volunteer_data.dart';
import 'package:sizer/sizer.dart';

class VolunteerCube extends StatelessWidget {
  final User volunteer;
  final String? id;

  const VolunteerCube({super.key, required this.volunteer, this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => VolunteerData(volunteer, isAdmin: id != null)));
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(242, 126, 126, 0.26),
              offset: Offset(0, 5),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 2.sw),
        alignment: Alignment.center,
        height: 10.sh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _styledText(volunteer.district?.name ?? "מחוז לא ידוע"),
            _styledText(volunteer.family?.name ?? 'משפחה לא ידועה'),
            _styledText(volunteer.name),
            Container(
              width: 8.sh,
              height: 8.sh,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(32, 82, 115, 0.15),
              ),
              child: _styledText(volunteer.name[0]),
            )
          ],
        ),
      ),
    );
  }

  Widget _styledText(String text) {
    return Text(text,
        style: GoogleFonts.varelaRound(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ));
  }
}
