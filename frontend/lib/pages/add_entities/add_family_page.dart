import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/back_to_main_page_button.dart';
import 'package:orot/components/centered_title.dart';
import 'package:orot/components/dropdown.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/future_handler.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/models/district.dart';
import 'package:orot/models/user.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/admin_service.dart';
import 'package:provider/provider.dart';
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
  late Future<List<District>> _districtsFuture;
  String _selectedDistrictId = '';
  bool createFamilyDisablementStatus = false;

  @override
  void initState() {
    super.initState();
    _districtsFuture = AdminService().getDistricts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureHandler(
        future: _districtsFuture,
        onSuccess: (context, districts) {
          return Consumer<UserProvider>(
              builder: (context, userProvider, child) {
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
                      _buildFormFields(),
                      _buildDistrictDropdown(userProvider, districts),
                      _createFamily(),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Widget _buildDistrictDropdown(
      UserProvider userProvider, List<District> districts) {
    if (userProvider.userPermission == UserPermission.coordinator) {
      return _districtDisplay(userProvider.user?.district);
    }
    if (districts.isEmpty) {
      return Text('לא נמצאו משפחות למחוז שנבחר');
    } else {
      if (_selectedDistrictId.isEmpty &&
          userProvider.userPermission == UserPermission.admin) {
        _selectedDistrictId = districts.first.id;
      }
      return Dropdown<District>(
        title: 'מחוז',
        items: districts,
        selectedItemId: _selectedDistrictId,
        onSelectedIdChange: (id) =>
            setState(() => _selectedDistrictId = id ?? "0"),
      );
    }
  }

  Widget _districtDisplay(District? district) {
    return Text(
      'מחוז: ${district?.name ?? 'שגיאה - יש לנסות לרענן את האפליקציה'}',
      style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w400),
    );
  }

  Widget _buildFormFields() {
    final titleStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
    return FixedColumn(children: [
      FieldInput(
        textEditingController: _familyNameController,
        textDirection: TextDirection.rtl,
        inputTitle: "שם",
        inputTitleStyle: titleStyle,
      ),
      FieldInput(
        textEditingController: _addressController,
        textDirection: TextDirection.rtl,
        inputTitle: "כתובת",
        inputTitleStyle: titleStyle,
      ),
      FieldInput(
        textEditingController: _contactController,
        textDirection: TextDirection.rtl,
        inputTitle: 'איש קשר  (מס טלפון)',
        inputTitleStyle: titleStyle,
      ),
    ]);
  }

  Widget _createFamily() {
    return MainButton(
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
