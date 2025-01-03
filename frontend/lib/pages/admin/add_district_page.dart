import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/main_button_v2.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/services/admin_service.dart';

class AddDistrictPage extends StatelessWidget {
  AddDistrictPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Column(
        children: [
          BackToAdminPage(),
          _title(),
          const SizedBox(height: 30),
          _name(),
          const SizedBox(height: 30),
          _createDistrict(),
        ],
      ),
    ));
  }

  Widget _title() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'הוספת מחוז',
        style: GoogleFonts.openSans(
            textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 40)),
      ),
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
            'שם המחוז',
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

  Widget _createDistrict() {
    return MainButton2(
        text: 'יצירת מחוז',
        onPress: () async {
          await AdminService().createDistrict(name: _nameController.text);
        });
  }
}
