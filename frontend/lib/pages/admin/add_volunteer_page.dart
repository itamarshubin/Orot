import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/services/auth_service.dart';
import 'package:orot/services/coordinator_service.dart';

class AddVolunteerPage extends StatelessWidget {
  AddVolunteerPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
      child: Column(
        //spacing: , consider using this instead of SizeBox
        children: [
          _title(),
          const SizedBox(height: 30),
          _emailAddress(),
          const SizedBox(height: 30),
          _password(),
          const SizedBox(height: 30),
          _name(),
          const SizedBox(height: 30),
          _createVolunteer(),
        ],
      ),
    ));
  }

  Widget _title() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'הוספת משתמש',
        style: GoogleFonts.openSans(
          textStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 40,
          ),
        ),
      ),
    );
  }

  Widget _emailAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.centerRight,
            child: Text(
              'מייל',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              filled: true,
              hintText: 'example@gmail.com',
              hintStyle: const TextStyle(
                  color: Color(0xff6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24))),
        )
      ],
    );
  }

  Widget _password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            'סיסמה',
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24))),
        )
      ],
    );
  }

  Widget _name() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            'שם מלא',
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24))),
        )
      ],
    );
  }

  Widget _createVolunteer() {
    return MainButton(
        text: 'יצירת משתמש',
        onPress: () async {
          await CoordinatorService().createVolunteer(
            email: _emailController.text,
            password: _passwordController.text,
            displayName: _nameController.text,
          );
        });
  }
}
