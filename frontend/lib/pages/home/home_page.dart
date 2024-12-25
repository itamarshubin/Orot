import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/pages/home/visits_list.dart';
import 'package:orot/pages/profile_page.dart';
import 'package:orot/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

VisitCard getNearestVisit() {
  return const VisitCard(
    placementOption: PlacementOption.editButton,
  );
}

Widget _nearestVisitTitle() {
  return Container(
    alignment: Alignment.topRight,
    child: Text(
      'הביקור הקרוב',
      style: GoogleFonts.assistant(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFF27E7E)),
    ),
  );
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            spacing: 10,
            children: [
              Stack(
                children: [
                  Title(displayName: userProvider.userName),
                  Container(
                    margin: const EdgeInsets.fromLTRB(40, 100, 40, 0),
                    child: Column(
                      children: [
                        _nearestVisitTitle(),
                        getNearestVisit(),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    spacing: 10,
                    children: [_addVisitButton(), _visits()],
                  ))
            ],
          ));
    });
  }

  Widget _addVisitButton() {
    return MainButton(
      text: 'קביעת מפגש',
      onPress: () => {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const ProfilePage()))
      },
    );
  }
}

Widget _visits() {
  return Column(
    spacing: 10,
    children: [
      VisitsList("פגישות עתידיות", getFuture()),
      VisitsList("היסטורית פגישות", getHistory()),
    ],
  );
}

List<VisitCard> getHistory() {
  return [
    for (int i = 0; i < 10; i++)
      VisitCard(
        placementOption: PlacementOption.showPastDate,
        address: "חנה רובינא $i, חיפה",
      )
  ];
}

List<VisitCard> getFuture() {
  return [
    for (int i = 0; i < 10; i++)
      VisitCard(
        address: "חנה רובינא $i, חיפה",
      )
  ];
}

class Title extends StatefulWidget {
  const Title({super.key, this.displayName});

  final String? displayName;

  @override
  State<Title> createState() => _TitleState();
}

class _TitleState extends State<Title> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
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
      child: Column(
        children: [_title()],
      ),
    );
  }

  Widget _title() {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 50, 30, 30),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/img/hand.svg',
            ),
            Text(
              'שלום ${widget.displayName}',
              style: GoogleFonts.assistant(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                color: Color.fromRGBO(32, 82, 1145, 1),
              )),
            ),
          ],
        ));
  }
}
