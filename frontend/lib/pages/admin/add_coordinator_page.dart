import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/main_button_v2.dart';
import 'package:orot/models/district.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/pages/admin/components/districts_dropdown.dart';
import 'package:orot/services/admin_service.dart';

class AddCoordinatorPage extends StatefulWidget {
  const AddCoordinatorPage({super.key});

  @override
  State<AddCoordinatorPage> createState() => _AddCoordinatorPageState();
}

class _AddCoordinatorPageState extends State<AddCoordinatorPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  List<District> _districts = [District(id: '0', name: 'loading...')];
  String _selectedDistrictId = '0';

  void _updateSelectedDistrict(String? districtId) {
    setState(() {
      _selectedDistrictId = districtId ?? "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            BackToAdminPage(),
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
            DistrictsDropdown(
              districts: _districts,
              selectedDistrictId: _selectedDistrictId,
              onSelectedIdChange: _updateSelectedDistrict,
              onInit: _initDistricts,
            ),
            _createCoordinator(),
            SizedBox(
              height: 30,
            )
          ],
        ),
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

  Future<void> _initDistricts() async {
    try {
      final List<District> districts = await AdminService().getDistricts();
      setState(() {
        _districts = districts;
        _selectedDistrictId = districts.first.id;
      });
    } catch (e) {
      _districts = [District(id: '0', name: 'error loading districts')];
    }
  }

  Widget _createCoordinator() {
    return MainButton2(
        text: 'יצירת רכזת',
        onPress: () async {
          await AdminService().createCoordinator(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
              districtId: _selectedDistrictId);
        });
  }
}
