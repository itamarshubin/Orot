import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/models/family.dart';
import 'package:orot/models/visit.dart';
import 'package:orot/pages/volunteer/home/home_label.dart';
import 'package:orot/pages/volunteer/home/home_title.dart';
import 'package:orot/pages/volunteer/home/visits_list.dart';
import 'package:orot/pages/volunteer/new_visit/new_visit_page.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/volunteer_service.dart';
import 'package:provider/provider.dart';

import '../../../components/main_button_v2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<List<Visit>?> _upcomingVisits =
      VolunteerService().getUpcomingVisits();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Provider.of<UserProvider>(context, listen: false).getUserData(),
        _upcomingVisits
      ]),
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
          return Consumer<UserProvider>(
              builder: (context, userProvider, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color.fromRGBO(237, 237, 237, 1),
              body: SingleChildScrollView(
                child: FixedColumn(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Positioned(
                          child:
                              HomePageTitle(displayName: userProvider.userName),
                        ),
                        Positioned(
                          bottom: -65,
                          child:
                              _nearestVisit(snapshot.data![1] as List<Visit>),
                        )
                      ],
                    ),
                    SizedBox(height: 70),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: FixedColumn(
                        children: [
                          _addVisitButton(),
                          VisitsList(
                              "פגישות עתידיות נוספות",
                              getResetOfVisits(
                                  snapshot.data![1] as List<Visit>)),
                          _getTips(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }
      },
    );
  }

  Widget _nearestVisit(List<Visit> visits) {
    if (visits.isEmpty) {
      //TODO: make Widget for that (maybe some image that ofir can give us)
      return Text('no upcoming visits');
    }

    return Container(
        alignment: Alignment.topRight,
        child: FixedColumn(
          children: [
            Transform.translate(
              offset: const Offset(10, 0),
              child: HomeLabelText(text: 'הביקור הקרוב'),
            ),
            VisitCard(
              showEditButton: false,
              visit: visits[0],
            )
          ],
        ));
  }

  Widget _addVisitButton() {
    return Center(
      child: MainButton2(
        text: 'קביעת מפגש',
        onPress: () => {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const NewVisitPage()))
        },
      ),
    );
  }

  Widget _getTips() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        HomeLabelText(text: 'איך נתמודד במפגש?'),
        Text(
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          '5 טיפים שיוכלו לעזור לנו להתנהל במפגש',
          style: GoogleFonts.assistant(
            color: Color.fromRGBO(32, 82, 115, 1),
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        )
      ],
    );
  }
}

List<VisitCard> getHistory() {
  return [
    for (int i = 0; i < 10; i++)
      VisitCard(
        hasVisited: Random().nextDouble() <= 0.3,
        showEditButton: true,
        visit: Visit(
            id: 'id',
            family: Family(id: 'id', name: 'name', address: 'ddd', contact: ''),
            visitDate: DateTime.now()),
      )
  ];
}

List<VisitCard> getResetOfVisits(List<Visit> visits) {
  return [
    for (int i = 1; i < visits.length; i++)
      VisitCard(
        visit: visits[i],
      )
  ];
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('dd.MM | HH:mm');
  return formatter.format(dateTime);
}
