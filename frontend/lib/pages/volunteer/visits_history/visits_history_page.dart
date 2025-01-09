import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/models/visit.dart';
import 'package:orot/pages/volunteer/visits_history/visits_history_app_bar.dart';
import 'package:orot/providers/visits_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/fixed_column.dart';

class VisitsHistoryPage extends StatefulWidget {
  const VisitsHistoryPage({super.key});

  @override
  State<VisitsHistoryPage> createState() => _VisitsHistoryPageState();
}

class _VisitsHistoryPageState extends State<VisitsHistoryPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<VisitsProvider>(context, listen: false)
            .getVisitsHistory(),
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
            final visits = snapshot.data as List<Visit>;
            return Scaffold(
              backgroundColor: Color.fromRGBO(237, 237, 237, 1),
              appBar: VisitsHistoryAppBar(),
              body: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 40, left: 30, right: 30),
                child: Stack(
                  textDirection: TextDirection.rtl,
                  alignment: Alignment.topRight,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -30,
                      right: 10,
                      child: Text(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        " ${visits.length} מפגשים ",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color.fromRGBO(32, 82, 115, 1),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 229, 243, 1),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        child: FixedColumn(children: _getVisitsHistory(visits)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  List<VisitCard> _getVisitsHistory(List<Visit> visits) {
    return visits.map((visit) => VisitCard(visit: visit)).toList();
  }
}
