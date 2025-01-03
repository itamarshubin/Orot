import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/models/calendar/event.dart';
import 'package:orot/models/calendar/event_time.dart';
import 'package:orot/pages/volunteer/navigation.dart';
import 'package:orot/pages/volunteer/new_visit/field.dart';
import 'package:orot/services/calender_service.dart';
import 'package:orot/services/google_auth.dart';
import 'package:orot/services/volunteer_service.dart';

class NewVisitPage extends StatefulWidget {
  const NewVisitPage({super.key});

  @override
  State<NewVisitPage> createState() => _NewVisitPageState();
}

class _NewVisitPageState extends State<NewVisitPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3EDED),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            children: [
              _xRedButton(),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  spacing: 20,
                  children: [_title(), _from()],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset('assets/img/calendar_people.webp'),
              _sendButton(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _xRedButton() {
    return Container(
      alignment: Alignment.topRight,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => VolunteerNavigation(),
              ))
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/green_circle_icon.svg",
              colorFilter: ColorFilter.mode(
                Colors.redAccent,
                BlendMode.srcATop,
              ),
              height: 35,
            ),
            Text(
              "X",
              textAlign: TextAlign.center,
              style: GoogleFonts.varelaRound(
                color: Color(0xffF27E7E),
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
        alignment: Alignment.topRight,
        child: Text(
          "קביעת מפגש",
          style: GoogleFonts.varelaRound(
            color: Color(0xff205273),
            fontWeight: FontWeight.w700,
            fontSize: 32,
          ),
        ));
  }

  Widget _from() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        _addDate(),
        _addTime(),
        _addToCalender(),
      ],
    );
  }

  Widget _addDate() {
    return Field(
      fieldTitle: "תאריך",
      content: DateFormat('dd/MM/yyyy').format(_selectedDate),
      context: context,
      iconPath: "assets/icons/pick_date_icon.svg",
      onTap: () => _selectDate(context),
    );
  }

  Widget _addTime() {
    return Container(
        alignment: Alignment.topRight,
        child: Field(
          fieldTitle: 'שעה',
          content: formatTimeOfDay(_selectedTime),
          context: context,
          iconPath: "assets/icons/pick_time_icon.svg",
          onTap: () => _selectTime(context),
        ));
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
          size: MainButtonSize.small,
        ));
  }

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

  DateTime getUpdatedDateTime() {
    return _selectedDate.copyWith(
      hour: _selectedTime.hour,
      minute: _selectedTime.minute,
    );
  }
}
