import 'package:flutter/material.dart';
import 'package:orot/components/back_to_main_page_button.dart';
import 'package:orot/components/centered_title.dart';
import 'package:orot/components/dropdown.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/future_handler.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/models/district.dart';
import 'package:orot/models/family.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/admin_service.dart';
import 'package:orot/services/coordinator_service.dart';
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
  late Future<List<District>> _getDistricts;
  late Future<List<Family>> _getFamilies;
  late bool _firstTimeInitGetFamilies = false;
  String _selectedDistrictId = '';
  String _selectedFamilyId = '';
  List<District> _districts = [];
  List<Family> _families = [];

  @override
  void initState() {
    super.initState();
    _getDistricts = AdminService().getDistricts();
  }

  void _updateSelectedDistrict(District? district) {
    setState(() {
      _selectedDistrictId = district?.id ?? '';
      _getFamilies = CoordinatorService().getFamilies(_selectedDistrictId);
    });
  }

  void _updateSelectedFamily(Family? family) {
    setState(() => _selectedFamilyId = family?.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return FutureHandler<List<District>>(
      future: _getDistricts,
      onSuccess: (context, districts) {
        _districts = districts;
        if (_firstTimeInitGetFamilies == false) {
          _firstTimeInitGetFamilies = true;
          _getFamilies = CoordinatorService().getFamilies(districts.first.id);
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.sw, vertical: 10.sh),
              child: creationForm(),
            ),
          ),
        );
      },
    );
  }

  Widget creationForm() {
    return FixedColumn(
      spacing: 5.sh,
      children: [
        BackToMainPage(userPermission: widget.userProvider.userPermission),
        CenteredTitle(text: "הוספת מתנדבת"),
        FieldInput(
          inputTitle: 'מייל',
          textEditingController: _emailController,
          autofocus: true,
        ),
        FieldInput(
          inputTitle: 'שם',
          textDirection: TextDirection.rtl,
          textEditingController: _nameController,
        ),
        FieldInput(
          inputTitle: 'סיסמה',
          textEditingController: _passwordController,
          obscureText: true,
        ),
        districtDropdown(),
        familyDropdown(),
        _createVolunteer(),
      ],
    );
  }

  Dropdown<District> districtDropdown() {
    return Dropdown<District>(
      title: "מחוז",
      items: _districts,
      selectedItem: _districts.firstWhere(
        (district) => district.id == _selectedDistrictId,
        orElse: () {
          District defaultDistrict = _districts.isEmpty
              ? District(id: '0', name: 'בחר מחוז')
              : _districts.first;
          if (!_districts
              .any((district) => district.id == defaultDistrict.id)) {
            _districts.insert(0, defaultDistrict);
          }
          return defaultDistrict;
        },
      ),
      onSelectedChange: _updateSelectedDistrict,
      getLabel: (district) => district.name,
      getId: (district) => district.id,
    );
  }

  FutureHandler<List<Family>> familyDropdown() {
    return FutureHandler<List<Family>>(
      future: _getFamilies,
      onSuccess: (context, families) {
        _families = families;

        Family selectedFamily = _families.firstWhere(
          (family) => family.id == _selectedFamilyId,
          orElse: () {
            Family defaultFamily =
                Family(id: '0', name: 'בחר משפחה', address: '', contact: '');
            if (!_families.any((family) => family.id == defaultFamily.id)) {
              _families.insert(0, defaultFamily);
            }
            return defaultFamily;
          },
        );

        return Dropdown<Family>(
          title: "משפחה",
          items: _families,
          selectedItem: selectedFamily,
          onSelectedChange: _updateSelectedFamily,
          getLabel: (family) => family.name,
          getId: (family) => family.id,
        );
      },
    );
  }

  Widget _createVolunteer() {
    return MainButton(
      text: 'יצירת מתנדבת',
      disabled: createVolunteerDisablementStatus,
      onPress: () async {
        setState(() => createVolunteerDisablementStatus = true);
        await CoordinatorService().createVolunteer(
          email: _emailController.text,
          password: _passwordController.text,
          displayName: _nameController.text,
          districtId: _selectedDistrictId,
          familyId: _selectedFamilyId,
        );
        setState(() => createVolunteerDisablementStatus = false);
      },
    );
  }
}
