import 'package:flutter/material.dart';
import 'package:orot/pages/profile/profile_page.dart';
import 'package:orot/pages/volunteer/home/home_page.dart';
import 'package:orot/pages/volunteer/visits_history/visits_history_page.dart';

class VolunteerNavigation extends StatefulWidget {
  const VolunteerNavigation({super.key});

  @override
  State<VolunteerNavigation> createState() => _VolunteerNavigationState();
}

class _VolunteerNavigationState extends State<VolunteerNavigation> {
  late Widget currentChild;
  int currentIndex = 2;
  List<Widget> pages = [
    const ProfilePage(),
    const VisitsHistoryPage(),
    const HomePage(),
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
              tooltip: 'פרופיל',
              icon: Icon(Icons.person),
              label: '',
            ),
            BottomNavigationBarItem(
              tooltip: 'היסטורית פגישות',
              icon: Icon(Icons.history),
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
}
