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
            padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddUserPage()));
                },
                child: Text('הוספת משתמש')),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddCoordinatorPage()));
                },
                child: Text('הוספת רכזת')),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddDistrictPage()));
                },
                child: Text('הוספת מחוז')),
          ),
        ],
      ),
    );
  }
}
