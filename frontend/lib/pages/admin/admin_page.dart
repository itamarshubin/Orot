import 'package:flutter/material.dart';
import 'package:orot/pages/admin/add_coordinator_page.dart';
import 'package:orot/pages/admin/add_district_page.dart';
import 'package:orot/pages/admin/add_user_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddUserPage()));
                },
                child: const Text('הוספת משתמש')),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
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
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddDistrictPage()));
                },
                child: const Text('הוספת מחוז')),
          ),
        ],
      ),
    );
  }
}
