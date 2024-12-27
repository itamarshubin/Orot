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
  Widget currentChild = const HomePage();
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
          // selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              // backgroundColor: Colors.black,
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
          ;
          currentChild = const VisitsHistoryPage();
        });
        break;
      case 2:
        setState(() {
          currentIndex = 2;
          currentChild = const HomePage();
        });
        break;
    }
  }
}
