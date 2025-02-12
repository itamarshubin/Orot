import 'package:flutter/material.dart';
import 'package:orot/components/centered_title.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/models/district.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/pages/admin/components/districts_dropdown.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/admin_service.dart';
import 'package:sizer/sizer.dart';

class AddCoordinatorPage extends StatefulWidget {
  final UserProvider userProvider;

  const AddCoordinatorPage(this.userProvider, {super.key});

  @override
  State<AddCoordinatorPage> createState() => _AddCoordinatorPageState();
}

class _AddCoordinatorPageState extends State<AddCoordinatorPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool createCoordinatorDisablementStatus = false;

  List<District> _districts = [District(id: '0', name: 'loading...')];
  String _selectedDistrictId = '0';

  void _updateSelectedDistrict(String? districtId) {
    setState(() {
      _selectedDistrictId = districtId ?? "0";
    });
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
        child: Column(
          spacing: 5.sh,
          children: [
            BackToMainPage(userPermission: widget.userProvider.userPermission),
            CenteredTitle(text: 'הוספת רכזת'),
            FieldInput(
              textEditingController: _emailController,
              inputTitle: "מייל",
              autofocus: true,
              inputTitleStyle: titleStyle,
            ),
            FieldInput(
              textEditingController: _nameController,
              inputTitle: "שם",
              textDirection: TextDirection.rtl,
              inputTitleStyle: titleStyle,
            ),
            FieldInput(
              textEditingController: _passwordController,
              inputTitle: "סיסמה",
              obscureText: true,
              inputTitleStyle: titleStyle,
            ),
            DistrictsDropdown(
              districts: _districts,
              selectedDistrictId: _selectedDistrictId,
              onSelectedIdChange: _updateSelectedDistrict,
              onInit: _initDistricts,
            ),
            _createCoordinator(),
          ],
        ),
      ),
    ));
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
    return MainButton(
        text: 'יצירת רכזת',
        onPress: () async {
          setState(() => createCoordinatorDisablementStatus = true);
          await AdminService().createCoordinator(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
              districtId: _selectedDistrictId);
          setState(() => createCoordinatorDisablementStatus = false);
        });
  }
}
