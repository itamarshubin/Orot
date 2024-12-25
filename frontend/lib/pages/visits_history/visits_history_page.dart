import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VisitsHistoryPage extends StatefulWidget {
  const VisitsHistoryPage({super.key});

  @override
  State<VisitsHistoryPage> createState() => _VisitsHistoryPageState();
}

class _VisitsHistoryPageState extends State<VisitsHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: SvgPicture.asset('assets/img/hand.svg'),
        title: Row(
          textDirection: TextDirection.rtl,
          children: <Text>[
            Text(
              "היסטוריית המפגשים שלי",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        titleTextStyle: GoogleFonts.assistant(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(178, 39, 89, 1),
        ),
        flexibleSpace: Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(300, 40),
              bottomRight: Radius.elliptical(300, 40),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerLeft,
              colors: [
                Colors.white,
                Colors.red,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          textDirection: TextDirection.rtl,
          spacing: 10,
          children: [],
        ),
      ),
    );
  }
}
