import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/main_button_v2.dart';
import 'package:orot/models/district.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/pages/admin/components/districts_dropdown.dart';
import 'package:orot/services/admin_service.dart';

class AddFamilyPage extends StatefulWidget {
  const AddFamilyPage({super.key});

  @override
  State<AddFamilyPage> createState() => _AddFamilyPageState();
}

class _AddFamilyPageState extends State<AddFamilyPage> {
  final _familyNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
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
          //spacing: , consider using this instead of SizeBox
          children: [
            BackToAdminPage(),
            _title(),
            const SizedBox(height: 30),
            _familyName(),
            const SizedBox(height: 30),
            _address(),
            const SizedBox(height: 30),
            _contact(),
            const SizedBox(height: 30),
            DistrictsDropdown(
              districts: _districts,
              selectedDistrictId: _selectedDistrictId,
              onSelectedIdChange: _updateSelectedDistrict,
              onInit: _initDistricts,
            ),
            _createFamily(),
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
        'הוספת משפחה',
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

  Widget _familyName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.centerRight,
            child: Text(
              'שם',
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
          controller: _familyNameController,
          decoration: InputDecoration(
              filled: true,
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

  Widget _address() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            'כתובת',
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
          controller: _addressController,
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

  Widget _contact() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            'איש קשר (שם וטלפון)',
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
          controller: _contactController,
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

  Widget _createFamily() {
    return MainButton2(
        text: 'שמירת משפחה',
        onPress: () async {
          await AdminService().createFamily(
              name: _familyNameController.text,
              address: _addressController.text,
              contact: _contactController.text,
              districtId: _selectedDistrictId);
        });
  }
}
