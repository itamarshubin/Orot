import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/switch_buttons.dart';
import 'package:orot/pages/visit_reminder/question_title.dart';

enum ComingOptions { comingAlone, notComingAlone, notComing }

class UserArrivalDetails {
  final bool isComing;
  final ComingOptions? comingOptions;

  UserArrivalDetails({
    this.isComing = true,
    this.comingOptions = ComingOptions.comingAlone,
  });

  String toJson() {
    return JsonEncoder()
        .convert({"isComing": isComing, "comingOptions": comingOptions});
  }
}

class VisitReminderPage extends StatefulWidget {
  const VisitReminderPage({super.key});

  @override
  State<VisitReminderPage> createState() => _VisitReminderPageState();
}

class _VisitReminderPageState extends State<VisitReminderPage> {
  final UserArrivalDetails userArrivalDetails = UserArrivalDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            _reminderCard(),
            SvgPicture.asset('assets/img/shadow_floating_object.svg'),
            _validateUserArrival(),
          ],
        ),
      ),
    );
  }

  Widget _reminderCard() {
    return Card(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          height: 190,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerRight,
            children: [
              Positioned(
                top: -40,
                left: -35,
                child: SvgPicture.asset(height: 70, 'assets/img/bell.svg'),
              ),
              Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "תזכורת!",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.assistant(
                      color: Color(0xffB22759),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                        style: GoogleFonts.assistant(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(text: "מחר - יום רביעי 12.11"),
                          TextSpan(text: "\nמתרחשת פגישה עם משפחת אבגד"),
                          TextSpan(text: "\nבכתובת חנה רובינא 3, חיפה"),
                        ]),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget _validateUserArrival() {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        QuestionTitle(text: "האם תגיעי מחר לפגישה?"),
        SwitchButtons(activated: userArrivalDetails.isComing),
        QuestionTitle(text: "במידה ואת מגיעה האם את באה לבד?"),
        SwitchButtons(activated: userArrivalDetails.isComing),
      ],
    );
  }
}
