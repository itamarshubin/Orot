import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/add_coordinator_page.dart';
import 'package:orot/pages/admin/add_district_page.dart';
import 'package:orot/pages/admin/add_family_page.dart';
import 'package:orot/pages/admin/add_volunteer_page.dart';
import 'package:orot/pages/volunteer/navigation.dart';
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
                _addFamilyButton(context),
              if (userProvider.userPermission == UserPermission.admin)
                _addCoordinatorButton(context),
              if (userProvider.userPermission == UserPermission.admin)
                _addDistrictButton(context),
              _addUserButton(context),
            ],
          ),
        ),
      );
    });
  }

  Widget _addUserButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddVolunteerPage()));
          },
          child: const Text('הוספת משתמש')),
    );
  }

  Widget _addCoordinatorButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const AddCoordinatorPage()));
          },
          child: const Text('הוספת רכזת')),
    );
  }

  Widget _addDistrictButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddDistrictPage()));
          },
          child: const Text('הוספת מחוז')),
    );
  }

  Widget _addFamilyButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddFamilyPage()));
          },
          child: const Text('הוספת משפחה')),
    );
  }
}
