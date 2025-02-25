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
import 'package:orot/models/family.dart';
import 'package:orot/models/user.dart';
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

  late Future<List<District>> _districtsFuture;
  Future<List<Family>>? _familiesFuture;

  List<District> _districts = [];
  List<Family> _families = [];

  String _selectedDistrictId = '';
  String _selectedFamilyId = '';
  bool _disableCreateVolunteer = false;

  @override
  void initState() {
    super.initState();
    _districtsFuture = AdminService().getDistricts();
  }

  void _updateFamilies(String districtId) {
    _selectedDistrictId = districtId;
    _familiesFuture = CoordinatorService().getFamilies(districtId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureHandler<List<District>>(
      future: _districtsFuture,
      onSuccess: (context, districts) {
        _districts = districts;
        if (_districts.isNotEmpty && _selectedDistrictId.isEmpty) {
          _selectedDistrictId = _districts.first.id;
          _updateFamilies(_selectedDistrictId);
        }

        return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Scaffold(
              body: SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sw, vertical: 10.sh),
                child: FixedColumn(
                  spacing: 5.sh,
                  children: [
                    BackToMainPage(userPermission: userProvider.userPermission),
                    const CenteredTitle(text: "הוספת מתנדבת"),
                    _buildInputFields(),
                    _buildDistrictDropdown(userProvider),
                    _buildFamilyDropdown(),
                    _buildCreateVolunteerButton(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildDistrictDropdown(UserProvider userProvider) {
    if (userProvider.userPermission == UserPermission.coordinator) {
      return _districtDisplay(userProvider.user?.district);
    }
    return Dropdown<District>(
      title: 'מחוז',
      items: _districts,
      selectedItemId: _selectedDistrictId,
      onSelectedIdChange: (id) => setState(() => _updateFamilies(id ?? '')),
    );
  }

  Widget _buildFamilyDropdown() {
    return FutureHandler<List<Family>>(
      future: _familiesFuture ?? Future.value([]),
      onSuccess: (context, families) {
        _families = families;
        if (_families.isEmpty) {
          return const Text('לא נמצאו משפחות למחוז שנבחר');
        }
        if (!_families.any((family) => family.id == _selectedFamilyId)) {
          _selectedFamilyId = _families.first.id;
        }

        return Dropdown<Family>(
          title: 'משפחה',
          items: _families,
          selectedItemId: _selectedFamilyId,
          onSelectedIdChange: (id) =>
              setState(() => _selectedFamilyId = id ?? ''),
        );
      },
    );
  }

  Widget _districtDisplay(District? district) {
    return Text(
      'מחוז: ${district?.name ?? 'שגיאה - יש לנסות לרענן את האפליקציה'}',
      style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w400),
    );
  }

  Widget _buildCreateVolunteerButton() {
    return MainButton(
      text: 'יצירת משתמש',
      disabled: _disableCreateVolunteer,
      onPress: _createVolunteer,
    );
  }

  Future<void> _createVolunteer() async {
    setState(() => _disableCreateVolunteer = true);
    await CoordinatorService().createVolunteer(
      email: _emailController.text,
      password: _passwordController.text,
      displayName: _nameController.text,
      districtId: _selectedDistrictId,
      familyId: _selectedFamilyId,
    );
    setState(() => _disableCreateVolunteer = false);
  }
}
