import 'package:flutter/material.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/coordinator/volunteers_list/volunteers_list.dart';
import 'package:orot/pages/profile/profile_page.dart';
import 'package:orot/pages/volunteer/home/home_page.dart';
import 'package:orot/pages/volunteer/visits_history/visits_history_page.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CoordinatorNavigation extends StatefulWidget {
  const CoordinatorNavigation({super.key});

  @override
  State<CoordinatorNavigation> createState() => _CoordinatorNavigationState();
}

class _CoordinatorNavigationState extends State<CoordinatorNavigation> {
  Widget currentChild =
      CircularProgressIndicator(); //todo: should have volunteerlist but cant get district id..
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
          body: currentChild,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => _onItemTapped(context, index, userProvider),
            iconSize: 25,
            currentIndex: currentIndex,
            selectedItemColor: Color(0xFF205273),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                // backgroundColor: Colors.black,
                tooltip: 'פרופיל',
                icon: Icon(Icons.person),
                label: '',
              ),
              BottomNavigationBarItem(
                tooltip: 'עריכת מתנדבות',
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
    });
  }

  void _onItemTapped(
      BuildContext context, int index, UserProvider userProvider) {
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
          currentChild = VolunteersList(id: userProvider.user?.district?.id);
        });
        break;
    }
  }
}
