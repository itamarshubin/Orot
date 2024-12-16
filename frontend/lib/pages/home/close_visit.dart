import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CloseVisit extends StatefulWidget {
  const CloseVisit({super.key});

  @override
  State<CloseVisit> createState() => _CloseVisitState();
}

class _CloseVisitState extends State<CloseVisit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.fromLTRB(40, 140, 40, 0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
          color: Color(0xFFFFFFFF)),
      child: Column(
        children: [_closeVisitDate(), _closeVisitLocation()],
      ),
    );
  }

  Widget _closeVisitDate() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '16:00 | 19.1',
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Color(0xff205273),
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(
            Icons.calendar_month_outlined,
            color: Color(0xff205273),
          )
        ],
      ),
    );
  }

  Widget _closeVisitLocation() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'חנה רובינא 2, חיפה',
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Color(0xff205273),
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(
            Icons.location_on_outlined,
            color: Color(0xff205273),
          )
        ],
      ),
    );
  }
}
