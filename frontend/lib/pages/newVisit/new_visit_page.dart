import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/pages/newVisit/field.dart';

class NewVisitPage extends StatefulWidget {
  const NewVisitPage({super.key});

  @override
  State<NewVisitPage> createState() => _NewVisitPageState();
}

class _NewVisitPageState extends State<NewVisitPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

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
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
        child: Align(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _title(),
              const SizedBox(
                height: 20,
              ),
              Field('תאריך', _selectDate, context,
                  DateFormat('dd/MM/yyyy').format(_selectedDate)),
              const SizedBox(
                height: 20,
              ),
              Field(
                  'שעה', _selectTime, context, formatTimeOfDay(_selectedTime)),
              const SizedBox(
                height: 20,
              ),
              MainButton(text: 'שליחה', onPress: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      alignment: Alignment.topRight,
      child: const Text("קביעת מפגש",
          style: TextStyle(
              fontFamily: 'VarelaRound',
              fontWeight: FontWeight.w400,
              fontSize: 32)),
    );
  }
}
