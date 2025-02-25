import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/back_to_main_page_button.dart';
import 'package:orot/components/centered_title.dart';
import 'package:orot/components/dropdown.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/models/district.dart';
import 'package:orot/models/family.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/components/families_dropdown.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/admin_service.dart';
import 'package:orot/services/coordinator_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddVolunteerPage extends StatefulWidget {
  final UserProvider userProvider;

  const AddVolunteerPage(this.userProvider, {super.key});

  @override
  State<AddVolunteerPage> createState() => _AddVolunteerPageState();
}

class _AddVolunteerPageState extends State<AddVolunteerPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool createVolunteerDisablementStatus = false;

  List<District> _districts = [District(id: '0', name: 'loading...')];
  List<Family> _families = [
    Family(id: '0', name: 'loading...', address: "add", contact: "con")
  ];
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
    final titleStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      if (userProvider.userPermission == UserPermission.coordinator) {
        if (_selectedFamilyId == "0") {
          _selectedFamilyId = "1";
          _getFamilies(userProvider.user?.district?.id);
        }
      }

      Future<void> _initDistricts() async {
        // todo: create future builder to get this
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
              _families = [
                Family(
                  id: '0',
                  name: 'error loading families',
                  address: "add",
                  contact: "con",
                )
              ];
            });
          }
        } catch (e) {
          setState(() {
            _districts = [District(id: '0', name: 'error loading districts')];
          });
        }
      }

      return Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.sw,
            vertical: 10.sh,
          ),
          child: FixedColumn(
            spacing: 5.sh,
            children: [
              BackToMainPage(
                  userPermission: widget.userProvider.userPermission),
              CenteredTitle(text: "הוספת מתנדבת"),
              FieldInput(
                inputTitle: 'מייל',
                textEditingController: _emailController,
                autofocus: true,
                inputTitleStyle: titleStyle,
              ),
              FieldInput(
                inputTitle: 'שם',
                textDirection: TextDirection.rtl,
                textEditingController: _nameController,
                inputTitleStyle: titleStyle,
              ),
              FieldInput(
                inputTitle: 'סיסמה',
                textEditingController: _passwordController,
                obscureText: true,
                inputTitleStyle: titleStyle,
              ),
              if (userProvider.userPermission == UserPermission.admin)
                Dropdown<District>(
                  title: 'מחוז',
                  items: _districts,
                  selectedItemId: _selectedDistrictId,
                  onSelectedIdChange: _updateSelectedDistrict,
                  onInit: _initDistricts,
                )
              else
                _district(userProvider.user?.district),
              if (_selectedFamilyId != "1")
                FamiliesDropdown(
                  families: _families,
                  selectedFamilyId: _selectedFamilyId,
                  onSelectedFamilyChange: _updateSelectedFamily,
                ),
              _createVolunteer(),
            ],
          ),
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
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          )),
    );
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
        _families = [
          Family(
            id: '0',
            name: 'error loading families',
            address: "add",
            contact: "con",
          )
        ];
      });
    }
  }

  Widget _createVolunteer() {
    return MainButton(
        text: 'יצירת משתמש',
        disabled: createVolunteerDisablementStatus,
        onPress: () async {
          setState(() => createVolunteerDisablementStatus = true);
          await CoordinatorService().createVolunteer(
              email: _emailController.text,
              password: _passwordController.text,
              displayName: _nameController.text,
              districtId: _selectedDistrictId,
              familyId: _selectedFamilyId);
          setState(() => createVolunteerDisablementStatus = false);
        });
  }
}
