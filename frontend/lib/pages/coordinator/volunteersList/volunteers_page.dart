import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VolunteersPage extends StatefulWidget {
  const VolunteersPage({super.key});

  @override
  State<VolunteersPage> createState() => _VolunteersPageState();
}

class _VolunteersPageState extends State<VolunteersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: Column(
        children: [_title()],
      ),
    );
  }

  Widget _title() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 130,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFC3C3),
                Color(0xFFFECED6),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(700, 100),
                bottomRight: Radius.elliptical(700, 100)),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Text(
            'מתנדבות מחוז מרכז',
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.w700,
                fontSize: 40,
                color: const Color(0xFF205273)),
          ),
        )
      ],
    );
  }
}
