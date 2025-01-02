import 'package:flutter/material.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/admin/district_list.dart';
import 'package:orot/pages/coordinator/volunteers_list/volunteers_list.dart';
import 'package:orot/pages/profile/profile_page.dart';
import 'package:orot/pages/volunteer/home/home_page.dart';
import 'package:orot/pages/volunteer/visits_history/visits_history_page.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  Widget currentChild = DistrictList();
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentChild,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => _onItemTapped(context, index),
          iconSize: 25,
          currentIndex: currentIndex,
          selectedItemColor: Color(0xFF205273),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              tooltip: 'פרופיל',
              icon: Icon(Icons.person),
              label: '',
            ),
            BottomNavigationBarItem(
              tooltip: 'עריכה',
              icon: Icon(Icons.edit),
              label: '',
            ),
            BottomNavigationBarItem(
              tooltip: 'מסך ראשי',
              icon: Icon(Icons.home),
              label: '',
            ),
          ],
        ));
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        setState(() {
          currentIndex = 0;
          currentChild = const ProfilePage();
        });
        break;
      case 1:
        setState(() {
          currentIndex = 1;
          currentChild = const AdminPage();
        });
        break;
      case 2:
        setState(() {
          currentIndex = 2;
          currentChild = DistrictList();
        });
        break;
    }
  }
}
