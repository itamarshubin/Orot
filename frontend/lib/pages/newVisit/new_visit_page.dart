import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orot/components/AppFooter.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/pages/newVisit/field.dart';
import 'package:orot/services/auth_service.dart';
import 'package:orot/services/google_auth.dart';
import 'package:orot/services/google_calender/calender_service.dart';
import 'package:orot/services/google_calender/schemas/event.dart';
import 'package:orot/services/google_calender/schemas/event_time.dart';
import 'package:orot/services/volunteer_service.dart';

class NewVisitPage extends StatefulWidget {
  const NewVisitPage({super.key});

  @override
  State<NewVisitPage> createState() => _NewVisitPageState();
}

class _NewVisitPageState extends State<NewVisitPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  User? _user = AuthService().getCurrentUser();

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final hours = timeOfDay.hour.toString().padLeft(2, '0');
    final minutes = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 47),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF3EDED),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_title(), _from()],
                )),
            const Spacer(),
            _sendButton(),
            const AppFooter()
          ],
        ));
  }

  Widget _from() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _addDate(),
        const SizedBox(height: 20),
        _addTime(),
        const SizedBox(height: 20),
        _addToCalender(),
      ],
    );
  }

  Widget _title() {
    return Container(
      alignment: Alignment.topRight,
      child: const Text("קביעת מפגש",
          style: TextStyle(
            fontFamily: 'VarelaRound',
            fontWeight: FontWeight.w400,
            fontSize: 32,
          )),
    );
  }

  Widget _addDate() {
    return Field(
      "תאריך",
      _selectDate,
      context,
      DateFormat('dd/MM/yyyy').format(_selectedDate),
      "assets/icons/pick_date_icon.svg",
    );
  }

  Widget _addTime() {
    return Container(
      alignment: Alignment.topRight,
      child: Field(
        'שעה',
        _selectTime,
        context,
        formatTimeOfDay(_selectedTime),
        "assets/icons/pick_time_icon.svg",
      ),
    );
  }

  Widget _addToCalender() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () async => addCalenderEvent(
          Event(
            start: EventTime(getUpdatedDateTime()),
            end: EventTime(getUpdatedDateTime()),
          ),
          accessToken: await signInWithGoogle(),
        ),
        child: const Text(
          "Google Calendar-הוספה ל",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _sendButton() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 60, right: 60),
        child: MainButton(
          text: 'שליחה',
          onPress: () {
            VolunteerService().createVisit(dateTime: getUpdatedDateTime());
          },
        ));
  }

  DateTime getUpdatedDateTime() {
    return _selectedDate.copyWith(
      hour: _selectedTime.hour,
      minute: _selectedTime.minute,
    );
  }
}
