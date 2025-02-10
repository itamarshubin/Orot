import 'package:flutter/material.dart';
import 'package:orot/components/centered_title.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/main_button_v2.dart';
import 'package:orot/models/district.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/pages/admin/components/districts_dropdown.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/admin_service.dart';
import 'package:sizer/sizer.dart';

class AddFamilyPage extends StatefulWidget {
  final UserProvider userProvider;

  const AddFamilyPage(this.userProvider, {super.key});

  @override
  State<AddFamilyPage> createState() => _AddFamilyPageState();
}

class _AddFamilyPageState extends State<AddFamilyPage> {
  final _familyNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  List<District> _districts = [District(id: '0', name: 'loading...')];
  String _selectedDistrictId = '0';
  bool createFamilyDisablementStatus = false;

  void _updateSelectedDistrict(String? districtId) {
    setState(() => _selectedDistrictId = districtId ?? "0");
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
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
              CenteredTitle(text: 'הוספת משפחה'),
              FieldInput(
                textEditingController: _familyNameController,
                inputTitle: "שם",
                inputTitleStyle: titleStyle,
              ),
              FieldInput(
                textEditingController: _addressController,
                inputTitle: "כתובת",
                inputTitleStyle: titleStyle,
              ),
              FieldInput(
                textEditingController: _contactController,
                inputTitle: 'איש קשר  (מס טלפון)',
                inputTitleStyle: titleStyle,
              ),
              DistrictsDropdown(
                districts: _districts,
                selectedDistrictId: _selectedDistrictId,
                onSelectedIdChange: _updateSelectedDistrict,
                onInit: _initDistricts,
              ),
              _createFamily(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initDistricts() async {
    // todo: use future builder to reduce wait
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
        disabled: createFamilyDisablementStatus,
        onPress: () async {
          setState(() => createFamilyDisablementStatus = true);
          await AdminService().createFamily(
              name: _familyNameController.text,
              address: _addressController.text,
              contact: _contactController.text,
              districtId: _selectedDistrictId);
          setState(() => createFamilyDisablementStatus = false);
        });
  }
}
