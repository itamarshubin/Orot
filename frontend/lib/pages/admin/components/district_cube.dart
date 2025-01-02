import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/models/district.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/coordinator/volunteers_list/volunteers_list.dart';

class DistrictCube extends StatelessWidget {
  final District district;
  const DistrictCube({super.key, required this.district});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => VolunteersList(
                      id: district.id,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        color: Colors.white,
        height: 50,
        child: _CubeText(district.name),
      ),
    );
  }

  Widget _CubeText(String text) {
    return Text(text,
        style:
            GoogleFonts.varelaRound(fontSize: 18, fontWeight: FontWeight.w400));
  }
}
