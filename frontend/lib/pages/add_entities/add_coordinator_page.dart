import 'package:flutter/material.dart';
import 'package:orot/components/back_to_main_page_button.dart';
import 'package:orot/components/centered_title.dart';
import 'package:orot/components/dropdown.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/future_handler.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/models/district.dart';
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
  late Future<List<District>> _districtsFuture;
  bool createCoordinatorDisablementStatus = false;

  String _selectedDistrictId = '';

  void _updateSelectedDistrict(String? districtId) {
    setState(() => _selectedDistrictId = districtId ?? "0");
  }

  @override
  void initState() {
    super.initState();
    _districtsFuture = AdminService().getDistricts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureHandler<List<District>>(
        future: _districtsFuture,
        onSuccess: (context, districts) {
          if (_selectedDistrictId.isEmpty) {
            _selectedDistrictId = districts.first.id;
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
                  CenteredTitle(text: 'הוספת רכזת'),
                  _buildFormFields(),
                  _buildDistrictDropdown(districts),
                  _createCoordinator(),
                ],
              ),
            ),
          ));
        });
  }

  Widget _buildFormFields() {
    final titleStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
    return FixedColumn(
      children: [
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
        )
      ],
    );
  }

  Widget _buildDistrictDropdown(List<District> districts) {
    if (districts.isEmpty) {
      return Text('לא נמצאו משפחות למחוז שנבחר');
    } else {
      return Dropdown<District>(
        title: 'מחוז',
        items: districts,
        selectedItemId: _selectedDistrictId,
        onSelectedIdChange: _updateSelectedDistrict,
      );
    }
  }

  Widget _createCoordinator() {
    return MainButton(
        text: 'יצירת רכזת',
        disabled: createCoordinatorDisablementStatus,
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
