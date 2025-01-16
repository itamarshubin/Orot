import 'package:flutter/material.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/add_coordinator_page.dart';
import 'package:orot/pages/admin/add_district_page.dart';
import 'package:orot/pages/admin/add_family_page.dart';
import 'package:orot/pages/admin/add_volunteer_page.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            spacing: 20,
            children: [
              if (userProvider.userPermission == UserPermission.admin)
                _addEntityButton(context, 'הוספת משפחה', AddFamilyPage()),
              if (userProvider.userPermission == UserPermission.admin)
                _addEntityButton(context, 'הוספת רכזת', AddCoordinatorPage()),
              if (userProvider.userPermission == UserPermission.admin)
                _addEntityButton(context, 'הוספת מחוז', AddDistrictPage()),
              _addEntityButton(context, 'הוספת משתמש', AddVolunteerPage()),
            ],
          ),
        ),
      );
    });
  }

  Widget _addEntityButton(BuildContext context, String text, Widget page) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => page)),
            child: Text(text)),
      ),
    );
  }
}
