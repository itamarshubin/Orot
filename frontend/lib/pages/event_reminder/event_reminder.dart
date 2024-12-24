import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventReminderPage extends StatefulWidget {
  const EventReminderPage({super.key});

  @override
  State<EventReminderPage> createState() => _EventReminderPageState();
}

class _EventReminderPageState extends State<EventReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 10,
          children: [
            _reminderCard(),
          ],
        ),
      ),
    );
  }

  Widget _reminderCard() {
    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: -5,
                left: -5,
                child: SvgPicture.asset('assets/img/bell.svg'),
              )
            ],
          ),
          Title(color: Color(0xffB22759), child: Text("""
            מחר - יום רביעי 12.11
            מתרחשת פגישה עם משפחת אבגד
            בכתובת חנה רובינא 3, חיפה
            """))
        ],
      ),
    );
  }
}
