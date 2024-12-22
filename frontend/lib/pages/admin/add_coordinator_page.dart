import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/services/admin_service.dart';
import 'package:orot/services/auth_service.dart';

class AddCoordinatorPage extends StatefulWidget {
  AddCoordinatorPage({super.key});

  @override
  State<AddCoordinatorPage> createState() => _AddCoordinatorPageState();
}

class _AddCoordinatorPageState extends State<AddCoordinatorPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  String _district = 'מחוז צפון';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
      child: Column(
        children: [
          _title(),
          const SizedBox(
            height: 30,
          ),
          _emailAddress(),
          const SizedBox(
            height: 30,
          ),
          _password(),
          const SizedBox(
            height: 30,
          ),
          _name(),
          const SizedBox(
            height: 30,
          ),
          _districtDropdown(),
          _createCoordinator(),
        ],
      ),
    ));
  }

  Widget _title() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'הוספת רכזת',
        style: GoogleFonts.openSans(
            textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 40)),
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
                      fontSize: 20)),
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

  Widget _districtDropdown() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            'מחוז',
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
        DropdownButton<String>(
          value: _district,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            setState(() {
              _district = newValue!;
            });
          },
          items: <String>['מחוז צפון', 'מחוז מרכז', 'מחוז דרום']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _createCoordinator() {
    return MainButton(
        text: 'יצירת רכזת',
        onPress: () async {
          await AdminService().createCoordinator(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text);
        });
  }
}
