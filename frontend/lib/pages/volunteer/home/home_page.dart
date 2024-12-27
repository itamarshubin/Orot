import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/pages/volunteer/home/home_label.dart';
import 'package:orot/pages/volunteer/home/home_title.dart';
import 'package:orot/pages/volunteer/home/visits_list.dart';
import 'package:orot/pages/volunteer/new_visit/new_visit_page.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<UserProvider>(context, listen: false).getUserData(),
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
                          child: _nearestVisitTitle(),
                        )
                      ],
                    ),
                    SizedBox(height: 70),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: FixedColumn(
                        children: [
                          _addVisitButton(),
                          VisitsList("פגישות עתידיות נוספות", getFuture()),
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

  Widget _nearestVisitTitle() {
    return Container(
        alignment: Alignment.topRight,
        child: FixedColumn(
          children: [
            Transform.translate(
              offset: const Offset(10, 0),
              child: HomeLabelText(text: 'הביקור הקרוב'),
            ),
            VisitCard(showEditButton: true)
          ],
        ));
  }

  Widget _addVisitButton() {
    return MainButton(
      text: 'קביעת מפגש',
      onPress: () => {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const NewVisitPage()))
      },
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
        address: "חנה רובינא $i, חיפה",
      )
  ];
}

List<VisitCard> getFuture() {
  return [
    for (int i = 0; i < 2; i++)
      VisitCard(
        address: "חנה רובינא $i, חיפה",
      )
  ];
}
