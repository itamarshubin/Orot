import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/models/district.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/pages/admin/components/districts_dropdown.dart';
import 'package:orot/pages/admin/components/families_dropdown.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/admin_service.dart';
import 'package:orot/services/coordinator_service.dart';
import 'package:provider/provider.dart';

class AddVolunteerPage extends StatefulWidget {
  AddVolunteerPage({super.key});

  @override
  State<AddVolunteerPage> createState() => _AddVolunteerPageState();
}

class _AddVolunteerPageState extends State<AddVolunteerPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  List<District> _districts = [District(id: '0', name: 'loading...')];
  List<Family> _families = [Family(id: '0', name: 'loading...')];
  String _selectedDistrictId = '0';
  String _selectedFamilyId = '0';

  void _updateSelectedDistrict(String? districtId) {
    setState(() {
      _selectedDistrictId = districtId ?? "0";
    });
    _getFamilies(_selectedDistrictId);
  }

  void _updateSelectedFamily(String? familyId) {
    setState(() {
      _selectedFamilyId = familyId ?? "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      if (userProvider.userPermission == UserPermission.coordinator) {
        if (_selectedFamilyId == "0") {
          _selectedFamilyId = "1";
          _getFamilies(userProvider.user?.district?.id);
        }
      }

      return Scaffold(
          body: Container(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
        child: Column(
          //TODO: spacing: , consider using this instead of SizeBox
          children: [
            BackToAdminPage(),
            _title(),
            const SizedBox(height: 30),
            _emailAddress(),
            const SizedBox(height: 30),
            _password(),
            const SizedBox(height: 30),
            _name(),
            const SizedBox(height: 30),
            if (userProvider.userPermission == UserPermission.admin)
              DistrictsDropdown(
                districts: _districts,
                selectedDistrictId: _selectedDistrictId,
                onSelectedIdChange: _updateSelectedDistrict,
              )
            else
              _district(userProvider.user?.district),
            const SizedBox(height: 30),
            //TODO: fix this shit, its bad.
            //TODO: add loading stuff until this dropdown shown
            if (_selectedFamilyId != "1")
              FamiliesDropdown(
                families: _families,
                selectedFamilyId: _selectedFamilyId,
                onSelectedFamilyChange: _updateSelectedFamily,
              ),
            _createVolunteer(),
          ],
        ),
      ));
    });
  }

  Widget _district(District? district) {
    return Container(
      alignment: Alignment.topRight,
      child: Text(
          'מחוז: ${district?.name ?? 'שגיאה - יש לנסות לרענן את האפליקצייה'}',
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20))),
    );
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

  Future<void> _initDistricts() async {
    try {
      final List<District> districts = await AdminService().getDistricts();
      setState(() {
        _districts = districts;
        _selectedDistrictId = districts.first.id;
      });

      try {
        await _getFamilies(_selectedDistrictId);
      } catch (e) {
        setState(() {
          _families = [Family(id: '0', name: 'error loading families')];
        });
      }
    } catch (e) {
      setState(() {
        _districts = [District(id: '0', name: 'error loading districts')];
      });
    }
  }

  Future<void> _getFamilies(String? districtId) async {
    try {
      final List<Family> families =
          await CoordinatorService().getFamilies(districtId);
      setState(() {
        _families = families;
        _selectedFamilyId = families.first.id;
      });
    } catch (e) {
      setState(() {
        _families = [Family(id: '0', name: 'error loading families')];
      });
    }
  }

  Widget _createVolunteer() {
    return MainButton(
        text: 'יצירת משתמש',
        onPress: () async {
          await CoordinatorService().createVolunteer(
              email: _emailController.text,
              password: _passwordController.text,
              displayName: _nameController.text,
              districtId: _selectedDistrictId,
              familyId: _selectedFamilyId);
        });
  }
}
