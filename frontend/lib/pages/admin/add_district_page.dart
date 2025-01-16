import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/main_button_v2.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/services/admin_service.dart';
import 'package:sizer/sizer.dart';

import '../../components/field_input.dart';

class AddDistrictPage extends StatefulWidget {
  const AddDistrictPage({super.key});

  @override
  State<AddDistrictPage> createState() => _AddDistrictPageState();
}

class _AddDistrictPageState extends State<AddDistrictPage> {
  final _nameController = TextEditingController();
  bool _distinctDisablementStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Column(
        spacing: 5.sh,
        children: [
          BackToAdminPage(),
          _title(),
          FieldInput(
            textEditingController: _nameController,
            inputTitle: 'שם מחוז',
            autofocus: true,
            inputTitleStyle: GoogleFonts.openSans(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            inputValidation: (text) {
              if (text == null || text.isEmpty) {
                return "אנא הוסיפי מחוז.";
              }
              return null;
            },
          ),
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
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 40,
        ),
      ),
    );
  }

  Widget _createDistrict() {
    return MainButton2(
        disabled: _distinctDisablementStatus,
        text: 'יצירת מחוז',
        onPress: () async {
          setState(() => _distinctDisablementStatus = true);
          final district = _nameController.text;
          if (district.isEmpty) {
            Fluttertoast.showToast(msg: "אנא הוסיפי מחוז.");
          } else {
            await AdminService().createDistrict(name: district);
          }
          setState(() => _distinctDisablementStatus = false);
        });
  }
}
