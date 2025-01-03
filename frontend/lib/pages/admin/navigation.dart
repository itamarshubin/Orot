import 'package:flutter/material.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/admin/district_list.dart';
import 'package:orot/pages/profile/profile_page.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  late Widget currentChild;
  int currentIndex = 2;
  List<Widget> pages = [
    const ProfilePage(),
    const AdminPage(),
    const DistrictList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() => currentIndex = index),
          iconSize: 25,
          currentIndex: currentIndex,
          selectedItemColor: Color(0xFF205273),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                tooltip: 'פרופיל', icon: Icon(Icons.person), label: ''),
            BottomNavigationBarItem(
                tooltip: 'עריכה', icon: Icon(Icons.edit), label: ''),
            BottomNavigationBarItem(
                tooltip: 'מסך ראשי', icon: Icon(Icons.home), label: ''),
          ],
        ));
  }
}
