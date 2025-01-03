import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/models/user.dart';
import 'package:orot/models/visit.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/services/coordinator_service.dart';

class VolunteerData extends StatefulWidget {
  final bool isAdmin;
  final User volunteer;
  const VolunteerData(this.volunteer, {super.key, this.isAdmin = false});

  @override
  State<VolunteerData> createState() => _VolunteerDataState();
}

class _VolunteerDataState extends State<VolunteerData> {
  @override
  Widget build(BuildContext context) {
    print('nigga is admin:${widget.isAdmin}');
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _topIcon(),
                  _volunteerName(),
                  snapshot.data?.isNotEmpty ?? false
                      ? _lastVisit(snapshot.data![0])
                      : Text('אין ביקורים קודמים'),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _nextVisitDate(snapshot.data?.last.visitDate != null
                            ? DateFormat('dd.MM').format(
                                snapshot.data?.last.visitDate as DateTime)
                            : "something"),
                        _visitsCount(snapshot.data?.length ?? 0)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _moreDetails(widget.volunteer),
                ],
              ),
            ),
          );
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

  Widget _lastVisit(Visit visit) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 45),
          alignment: Alignment.topRight,
          child: Text(
            'הביקור האחרון',
            style: GoogleFonts.assistant(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xffF27E7E)),
          ),
        ),
        VisitCard(
          visit: visit,
          showCountdown: true,
        )
      ],
    );
  }

  Widget _visitsCount(int count) {
    return Container(
      width: 120,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$count',
            style: GoogleFonts.heebo(
                fontSize: 34,
                fontWeight: FontWeight.w400,
                color: Color(0xff727272)),
          ),
          Text('ביקורים',
              style: GoogleFonts.heebo(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffF27E7E)))
        ],
      ),
    );
  }

  Widget _moreDetails(User volunteer) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: MediaQuery.sizeOf(context).width * 0.80,
      height: MediaQuery.sizeOf(context).height * 0.30,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              'פרטים נוספים',
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffF27E7E)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'שם משפחה שכולה',
                    style: GoogleFonts.openSans(
                        color: Color(0xff34698B),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                  Text(
                    '${volunteer.family?.name}',
                    style: GoogleFonts.openSans(
                        color: Color(0xff001228),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'מחוז',
                    style: GoogleFonts.openSans(
                        color: Color(0xff34698B),
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                  Text(
                    '${volunteer.district?.name}',
                    style: GoogleFonts.openSans(
                        color: Color(0xff001228),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'איש קשר',
                  style: GoogleFonts.openSans(
                      color: Color(0xff34698B),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
                Text(
                  '${volunteer.family?.contact}',
                  style: GoogleFonts.openSans(
                      color: Color(0xff001228),
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nextVisitDate(String date) {
    return Container(
      width: 120,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$date',
            style: GoogleFonts.heebo(
                fontSize: 34,
                fontWeight: FontWeight.w400,
                color: Color(0xff727272)),
          ),
          Text('הביקור הבא',
              style: GoogleFonts.heebo(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffF27E7E)))
        ],
      ),
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
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(0, pageHeight * 0.05, 0, 0),
          child: Image.asset('assets/img/blue_hug.png',
              width: MediaQuery.of(context).size.width * 0.3,
              height: pageHeight * 0.3),
        ),
        BackToAdminPage(
          isAdmin: widget.isAdmin,
        ),
      ],
    );
  }
}
